/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */
#ifndef GEMM_H
#define GEMM_H
#include <inttypes.h>
#include <string.h>

/* Datatype for matrix elements */
#define GEMM_TYPE   float

/* cblas_sgemm or cblas_dgemm (must match GEMM_TYPE) */
#define GEMM_FUNC   cblas_sgemm

/* CBLAS Layout Settings */
typedef enum CBLAS_LAYOUT {
    CblasRowMajor   = 101,
    CblasColMajor   = 102
} CBLAS_LAYOUT;

typedef enum CBLAS_TRANSPOSE {
    CblasNoTrans    = 111,  // trans='N'
    CblasTrans      = 112   // trans='T'
} CBLAS_TRANSPOSE;

#define IS_TRANS(t) ((t) != CblasNoTrans)
#define IS_COLMAJ(l) ((l) == CblasColMajor)

/* The leading dimension of a matrix, given its transposition (or lack) */
#define LDIMM(rows, cols, trans, layout) \
    ( \
      IS_COLMAJ(layout) ? \
        (IS_TRANS(trans) ? (cols) : (rows)) \
      : (IS_TRANS(trans) ? (rows) : (cols)) \
    )


#define RV_INT int64_t

/* GEMM APIs defined by CBLAS */

#define CBLAS_GEMM_ARGS             \
        CBLAS_LAYOUT        layout, \
        CBLAS_TRANSPOSE     transa, \
        CBLAS_TRANSPOSE     transb, \
        RV_INT              m,      \
        RV_INT              n,      \
        RV_INT              k,      \
        GEMM_TYPE           alpha,  \
        const GEMM_TYPE*    a,      \
        RV_INT              lda,    \
        const GEMM_TYPE*    b,      \
        RV_INT              ldb,    \
        GEMM_TYPE           beta,   \
        GEMM_TYPE*          c,      \
        RV_INT              ldc

#define CBLAS_GEMM_ARG_NAMES    \
        layout,                 \
        transa,                 \
        transb,                 \
        m,                      \
        n,                      \
        k,                      \
        alpha,                  \
        a,                      \
        lda,                    \
        b,                      \
        ldb,                    \
        beta,                   \
        c,                      \
        ldc

/* Fills arr with len elements between 0.0 and 1.0 */
void rand_max1(GEMM_TYPE* arr, RV_INT len);


/* Verify that computed matrix multiply is correct based on golden model
 * Returns 0 iff mat_c's values are within specified tolerances of their 
 * corresponding values in mat_c_correct. */
int check_gemm_tolerance(
        CBLAS_GEMM_ARGS,
        GEMM_TYPE* correct,
        GEMM_TYPE* tolerance);

/* Computes the "correct" and tolerance matrices for S- and DGEMM
 * If rwarm>0, the (possibly non-idempotent) GEMM will be applied repeatedly. */
int correct_gemm(
        CBLAS_GEMM_ARGS,
        GEMM_TYPE* correct,
        GEMM_TYPE* tolerance
        );

/* CBLAS-Compatible Library Function such as cblas_sgemm or cblas_dgemm */
void GEMM_FUNC(CBLAS_GEMM_ARGS);

#endif // GEMM_H
