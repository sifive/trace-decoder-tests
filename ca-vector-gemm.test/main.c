/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "gemm.h"
#include "util.h"
#include "sifive_trace.h"

int main() {

    /* GEMM Problem Parameters 
     *
     * Change these to test different GEMM problem sizes and layouts.
     * The computed GEMM will be of the form:
     *
     * C[m * n] = beta * C[] + alpha * A[m * k] * B[k * n] */
    RV_INT          m       = 32;
    RV_INT          n       = 32;
    RV_INT          k       = 32;
    CBLAS_LAYOUT    layout  = CblasRowMajor;
    CBLAS_TRANSPOSE transa  = CblasNoTrans;
    CBLAS_TRANSPOSE transb  = CblasNoTrans;
    GEMM_TYPE       alpha   = 1;
    GEMM_TYPE       beta    = 0;

    /* Should we warm up caches with real code and data first? */
    bool            warm    = true;

    /* Compute leading dimensions based on layout */
    RV_INT lda = LDIMM(m, k, transa, layout);
    RV_INT ldb = LDIMM(k, n, transb, layout);
    RV_INT ldc = IS_COLMAJ(layout) ? m : n;

    /* Create random matrices */
    GEMM_TYPE* a = malloc(m * k * sizeof(GEMM_TYPE));
    GEMM_TYPE* b = malloc(k * n * sizeof(GEMM_TYPE));
    GEMM_TYPE* c = malloc(m * n * sizeof(GEMM_TYPE));
    if (!a || !b || !c)
        return -1;
    rand_max1(a, m * k);
    rand_max1(b, k * n);
    rand_max1(c, m * n);

    /* Compute "golden model" output and tolerance for verification */
    GEMM_TYPE* correct      = malloc(m * n * sizeof(GEMM_TYPE));
    GEMM_TYPE* tolerance    = malloc(m * n * sizeof(GEMM_TYPE));
    if (!correct || !tolerance)
        return -1;
    correct_gemm(CBLAS_GEMM_ARG_NAMES, correct, tolerance);

    /* Warmup with real function and data */
    if (warm) {
        // GEMM is not idempotent when beta != 0, so adjust correct
        // output matrix for double application of GEMM function
        GEMM_TYPE* tmp = c;
        c = correct; // Use previous output as input second time
        correct_gemm(CBLAS_GEMM_ARG_NAMES, correct, tolerance);
        c = tmp;
        GEMM_FUNC(CBLAS_GEMM_ARG_NAMES);
    }

    int infinite = 0;

    if (infinite == 0) {
    	_caTraceOnBTMDefaults();
    }

    /* Begin cycle count here */
    uint64_t c0 = rdcycle(), i0 = rdinstret();



    do {
    /* Compute the actual GEMM result
       By default, gemm.h sets GEMM_FUNC to cblas_sgemm */
    	GEMM_FUNC(CBLAS_GEMM_ARG_NAMES);
    } while(infinite);

	/* End cycle count here */
	uint64_t cycles = rdcycle() - c0;
	uint64_t insts = rdinstret() - i0;

    int retval = check_gemm_tolerance(CBLAS_GEMM_ARG_NAMES,
                                        correct,
                                        tolerance);

    printf("%s; cycles %ld; instret %ld\n",
            retval ? "FAIL" : "PASS",
            cycles,
            insts);

    free(a);
    free(b);
    free(c);
    free(correct);
    free(tolerance);

    return retval; 
}
