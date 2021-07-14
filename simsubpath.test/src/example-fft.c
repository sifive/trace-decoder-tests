#include "example-fft.h"
#include <complex.h>
#include <stdbool.h>
#include <stdio.h>

#define ABS(x) ((x) < 0 ? -(x) : (x))

// assuming __riscv_xlen == 64
#define _RD_COUNTER(COUNTER) \
    static uint64_t rd ## COUNTER() \
    { \
        uint64_t res; \
        asm volatile ("rd" #COUNTER " %0" : "=r" (res)); \
        return res; \
    }

_RD_COUNTER(cycle);   // rdcycle()

float _Alignas(4096) complex buf1[64];

int main()
{
   
    uint64_t c0, c1;
    uint64_t i0, i1;

    // Warmup with real function and data
    cfft_64((float complex*)test_input_00064, buf1, (float complex*)twi_00064);

    // 2nd call to FUNC_NAME(benchmark_cfft) is timed
    c0 = rdcycle();

    cfft_64(buf1, (float complex*)test_input_00064, (float complex*)twi_00064);

    c1 = rdcycle();

    uint64_t cycles = c1 - c0;

    float *bm_output = (float*)test_input_00064;

    // check FFT answer with Golden
    uint64_t error_cnt = 0;
    for (int ii = 0; ii < 64*2; ++ii) {
        float a = (bm_output)[ii];
        float b = ((float*)test_output_00064)[ii];
        if (ABS(a - b) < bound) {
        } else {
            error_cnt += 1;
        }
    }

    if (error_cnt != 0) return -1;

    // print results
    printf("N = 64 complex FFT (FP32): %d cycles\n", cycles);

    return 0;
}
