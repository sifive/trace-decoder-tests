/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include "gemm.h"

/* Convert a 2D index [row, col] into a 1D array subscript */
#define IDX(row, col, ld, trans) \
        ((trans) ? ((col) * (ld) + (row)) : ((row) * (ld) + (col)))

#define ABS(x) ((x) < 0 ? -(x) : (x))

void rand_max1(GEMM_TYPE* arr, RV_INT len)
{
    const double a = -1.0, b = 1.0;
    for (RV_INT i = 0; i < len; i++) {
        double frac = (GEMM_TYPE) ((double) rand() / (double) RAND_MAX);
        arr[i] = (GEMM_TYPE) (frac * (b - a) + a);
    }
}

int correct_gemm(
        CBLAS_GEMM_ARGS,
        GEMM_TYPE* output,
        GEMM_TYPE* tolerance)
{
    // Machine precision depends on floating-point type used
    double u;
    switch (sizeof(GEMM_TYPE)) {
        case 2:
            u = pow(2.0, -11);
            break;
        case 4:
            u = pow(2.0, -24);
            break;
        case 8:
            u = pow(2.0, -54);
            break;
        default:
            return -1;
    }
    double tol_scale_coeff = 9.0;
    double gk = k * u / (1.0 - k * u);

    const size_t c_size = m * n * sizeof(GEMM_TYPE);
    if (!memcpy(output, c, c_size))
        return -1;

    const bool a_cmaj = IS_COLMAJ(layout) != IS_TRANS(transa);
    const bool b_cmaj = IS_COLMAJ(layout) != IS_TRANS(transb);

    double alpha_abs = ABS(alpha);
    double beta_abs = ABS(beta);

    for (RV_INT ii = 0; ii < m; ii++) {
        for (RV_INT jj = 0; jj < n; jj++) {
            const RV_INT c_idx = IDX(ii, jj, ldc, IS_COLMAJ(layout));
            double cc = output[c_idx];
            double acc = (double) beta * cc;
            double tol_acc = beta_abs * ABS(cc);
            for (RV_INT kk = 0; kk < k; kk++) {
                const RV_INT a_idx = IDX(ii, kk, lda, a_cmaj);
                const RV_INT b_idx = IDX(kk, jj, ldb, b_cmaj);
                double ad = (a[a_idx]);
                double bd = (b[b_idx]);
                acc += (double) alpha * ad * bd;
                tol_acc += alpha_abs * ABS(ad) * ABS(bd);
            }
            const double tol = tol_scale_coeff * gk * tol_acc;
            output[c_idx] = acc;
            tolerance[c_idx] = tol;
        }
    }

    return 0;
}

/* A default three-nested-loops GEMM implementation */
void gemm_3nl(CBLAS_GEMM_ARGS)
{
    const bool a_cmaj = IS_COLMAJ(layout) != IS_TRANS(transa);
    const bool b_cmaj = IS_COLMAJ(layout) != IS_TRANS(transb);

    for (RV_INT ii = 0; ii < m; ii++) {
        for (RV_INT jj = 0; jj < n; jj++) {
            const RV_INT c_idx = IDX(ii, jj, ldc, IS_COLMAJ(layout));
            GEMM_TYPE acc = beta * c[c_idx];
            for (RV_INT kk = 0; kk < k; kk++) {
                const RV_INT a_idx = IDX(ii, kk, lda, a_cmaj);
                const RV_INT b_idx = IDX(kk, jj, ldb, b_cmaj);
                acc += alpha * a[a_idx] * b[b_idx];
            }
            c[c_idx] = acc;
        }
    }
}


int check_gemm_tolerance(
        CBLAS_GEMM_ARGS,
        GEMM_TYPE* correct,
        GEMM_TYPE* tolerance)
{
    int retval = 0;

    for (RV_INT i = 0; i < m; i++) {
        for (RV_INT j = 0; j < n; j++) {
            RV_INT idx = IS_COLMAJ(layout) ? (j * m + i) : (i * n + j);
            double tol = tolerance[idx];
            double cc_true = correct[idx];
            double cc = c[idx];
            if (ABS(cc -  cc_true) > tol) {
                printf("[%d,%d]: %f != %f\n", i, j, cc, cc_true);
                retval = -1;
            }
        }
    }

    return retval;
}

/* Dimensions of a GEMM sub-problem.
 *
 * Used as argument to partial GEMM functions so they can indicate
 * how much of a requested multiply (C[MxN] += A[MxK] * B[KxN]) they actually
 * completed, enabling tile_gemm_cube() to fill in the rest. */
typedef struct gemm_cube {
    RV_INT m;
    RV_INT n;
    RV_INT k;
} gemm_cube_t;

/* Repeatedly applies gemm_dispatch() to cover a full m x n x k cube
 *
 * Since an optimized GEMM function may not cover the full dimensions
 * requested due to the use of a fixed tile size etc., this function
 * ensures any remainder elements are processed after gemm_dispatch()
 * returns, falling back to "failsafe" three-nested-loops in case no
 * elements were processed. */
void tile_gemm_cube(CBLAS_GEMM_ARGS, gemm_cube_t* completed)
{
    // If work done in any dimension is zero, then no assembly
    // function can handle the given problem parameters, so fall back
    // to a failsafe GEMM.
    if (completed->m == 0 || completed->n == 0 || completed->k == 0) {
        gemm_3nl(layout, transa, transb,
                    m, n, k, alpha, 
                    a, lda, b, ldb, beta, c, ldc);
        return;
    }

    // Compute remaining fixup dimensions
    RV_INT fixup_m = m - completed->m;
    RV_INT fixup_n = n - completed->n;
    RV_INT fixup_k = k - completed->k;

    // Recursively dispatch over remaining sub-cubes
    if (fixup_m > 0) {  // Bottom (fixup_m x n x k) computation cube
        const GEMM_TYPE* a_rem =
            a + completed->m * ((IS_COLMAJ(layout) != IS_TRANS(transa)) ? 1 : lda);
        GEMM_TYPE* c_rem =
            c + completed->m * (IS_COLMAJ(layout) ? 1 : ldc);
        GEMM_FUNC(layout, transa, transb,
                            fixup_m, n, k,
                            alpha,
                            a_rem, lda,
                            b, ldb,
                            beta, 
                            c_rem, ldc);
    }

    if (fixup_n > 0) {  // Right-side (completed->m x fixup_n x k) cube
        const GEMM_TYPE* b_rem =
            b + completed->n * ((IS_COLMAJ(layout) != IS_TRANS(transb)) ? ldb : 1);
        GEMM_TYPE* c_rem =
            c + completed->n * (IS_COLMAJ(layout) ? ldc : 1);
        GEMM_FUNC(layout, transa, transb,
                            completed->m, fixup_n, k,
                            alpha,
                            a, lda,
                            b_rem, ldb,
                            beta, 
                            c_rem, ldc);
    }

    if (fixup_k > 0) { // Back-side (completed->m x completed->n x fixup_k)
        // Must set beta = 1.0 because all C values have been scaled already
        beta = 1.0;
        const GEMM_TYPE* a_rem =
            a + completed->k * ((IS_COLMAJ(layout) != IS_TRANS(transa)) ? lda : 1);
        const GEMM_TYPE* b_rem =
            b + completed->k * ((IS_COLMAJ(layout) != IS_TRANS(transb)) ? 1 : ldb);
        GEMM_FUNC(layout, transa, transb,
                            completed->m, completed->n, fixup_k,
                            alpha,
                            a_rem, lda,
                            b_rem, ldb,
                            beta,
                            c, ldc);
    }
}

/* Arguments to partial GEMM functions
 *
 * Last two arguments will be passed in floating-point registers 
 * in the LP64D ABI; ldc will be passed on the stack */
#define ASM_GEMM_ARGS                               \
                RV_INT m, RV_INT n, RV_INT k,       \
                const GEMM_TYPE* a,                 \
                RV_INT lda,                         \
                const GEMM_TYPE* b,                 \
                RV_INT ldb,                         \
                GEMM_TYPE* c,                       \
                RV_INT ldc,                         \
                GEMM_TYPE alpha, GEMM_TYPE beta,    \
                gemm_cube_t* completed

#define ASM_GEMM_ARG_NAMES  \
                m, n, k,    \
                a,          \
                lda,        \
                b,          \
                ldb,        \
                c,          \
                ldc,        \
                alpha, beta,\
                &completed


extern void cblas_sgemm_rrr(ASM_GEMM_ARGS);
extern void cblas_sgemm_rrc(ASM_GEMM_ARGS);
extern void cblas_sgemm_rcr(ASM_GEMM_ARGS);
extern void cblas_sgemm_rcc(ASM_GEMM_ARGS);
extern void cblas_sgemm_crr(ASM_GEMM_ARGS);
extern void cblas_sgemm_crc(ASM_GEMM_ARGS);
extern void cblas_sgemm_ccr(ASM_GEMM_ARGS);
extern void cblas_sgemm_ccc(ASM_GEMM_ARGS);

void cblas_sgemm(CBLAS_GEMM_ARGS)
{
    gemm_cube_t completed = { 0, 0, 0 };

    // Choose a GEMM variant based on the memory layout of each matrix
    const bool cma = IS_TRANS(transa) != IS_COLMAJ(layout);
    const bool cmb = IS_TRANS(transb) != IS_COLMAJ(layout);
    const bool cmc = IS_COLMAJ(layout);
    if        ( !cma && !cmb && !cmc ) {
        cblas_sgemm_rrr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma && !cmb &&  cmc ) {
        cblas_sgemm_rrc(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb && !cmc ) {
        cblas_sgemm_rcr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb &&  cmc ) {
        cblas_sgemm_rcc(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb && !cmc ) {
        cblas_sgemm_crr(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb &&  cmc ) {
        cblas_sgemm_crc(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb && !cmc ) {
        cblas_sgemm_ccr(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb &&  cmc ) {
        cblas_sgemm_ccc(ASM_GEMM_ARG_NAMES);
    }

    // Recursively finish remainder of the GEMM problem
    tile_gemm_cube(CBLAS_GEMM_ARG_NAMES, &completed);
}


extern void cblas_dgemm_rrr(ASM_GEMM_ARGS);
extern void cblas_dgemm_rrc(ASM_GEMM_ARGS);
extern void cblas_dgemm_rcr(ASM_GEMM_ARGS);
extern void cblas_dgemm_rcc(ASM_GEMM_ARGS);
extern void cblas_dgemm_crr(ASM_GEMM_ARGS);
extern void cblas_dgemm_crc(ASM_GEMM_ARGS);
extern void cblas_dgemm_ccr(ASM_GEMM_ARGS);
extern void cblas_dgemm_ccc(ASM_GEMM_ARGS);

void cblas_dgemm(CBLAS_GEMM_ARGS)
{
    gemm_cube_t completed = { 0, 0, 0 };

    // Choose a GEMM variant based on the memory layout of each matrix
    const bool cma = IS_TRANS(transa) != IS_COLMAJ(layout);
    const bool cmb = IS_TRANS(transb) != IS_COLMAJ(layout);
    const bool cmc = IS_COLMAJ(layout);
    if        ( !cma && !cmb && !cmc ) {
        cblas_dgemm_rrr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma && !cmb &&  cmc ) {
        cblas_dgemm_rrc(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb && !cmc ) {
        cblas_dgemm_rcr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb &&  cmc ) {
        cblas_dgemm_rcc(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb && !cmc ) {
        cblas_dgemm_crr(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb &&  cmc ) {
        cblas_dgemm_crc(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb && !cmc ) {
        cblas_dgemm_ccr(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb &&  cmc ) {
        cblas_dgemm_ccc(ASM_GEMM_ARG_NAMES);
    }

    // Recursively finish remainder of the GEMM problem
    tile_gemm_cube(CBLAS_GEMM_ARG_NAMES, &completed);
}

extern void cblas_hgemm_rrr(ASM_GEMM_ARGS);
extern void cblas_hgemm_rrc(ASM_GEMM_ARGS);
extern void cblas_hgemm_rcr(ASM_GEMM_ARGS);
extern void cblas_hgemm_rcc(ASM_GEMM_ARGS);
extern void cblas_hgemm_crr(ASM_GEMM_ARGS);
extern void cblas_hgemm_crc(ASM_GEMM_ARGS);
extern void cblas_hgemm_ccr(ASM_GEMM_ARGS);
extern void cblas_hgemm_ccc(ASM_GEMM_ARGS);

void cblas_hgemm(CBLAS_GEMM_ARGS)
{
    gemm_cube_t completed = { 0, 0, 0 };

    // Choose a GEMM variant based on the memory layout of each matrix
    const bool cma = IS_TRANS(transa) != IS_COLMAJ(layout);
    const bool cmb = IS_TRANS(transb) != IS_COLMAJ(layout);
    const bool cmc = IS_COLMAJ(layout);
    if        ( !cma && !cmb && !cmc ) {
        cblas_hgemm_rrr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma && !cmb &&  cmc ) {
        cblas_hgemm_rrc(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb && !cmc ) {
        cblas_hgemm_rcr(ASM_GEMM_ARG_NAMES);
    } else if ( !cma &&  cmb &&  cmc ) {
        cblas_hgemm_rcc(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb && !cmc ) {
        cblas_hgemm_crr(ASM_GEMM_ARG_NAMES);
    } else if (  cma && !cmb &&  cmc ) {
        cblas_hgemm_crc(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb && !cmc ) {
        cblas_hgemm_ccr(ASM_GEMM_ARG_NAMES);
    } else if (  cma &&  cmb &&  cmc ) {
        cblas_hgemm_ccc(ASM_GEMM_ARG_NAMES);
    }

    // Recursively finish remainder of the GEMM problem
    tile_gemm_cube(CBLAS_GEMM_ARG_NAMES, &completed);
}
