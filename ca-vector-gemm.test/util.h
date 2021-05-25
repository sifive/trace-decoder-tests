/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */
#ifndef GEMM_UTIL_H
#define GEMM_UTIL_H

#ifdef DEBUG
#define debugf(...) fprintf(stderr, __VA_ARGS__)
#else
#define debugf(...)
#endif // DEBUG

#include <inttypes.h>
#include <stddef.h>

#if __riscv_xlen == 32
#define _RD_COUNTER(COUNTER) \
  static uint64_t rd ## COUNTER() \
  { \
    uint32_t lo; \
    uint32_t hi0, hi1; \
    do { \
      asm volatile ("rd" #COUNTER "h %0" : "=r" (hi0)); \
      asm volatile ("rd" #COUNTER " %0" : "=r" (lo)); \
      asm volatile ("rd" #COUNTER "h %0" : "=r" (hi1)); \
    } while (hi0 != hi1); \
    return (uint64_t) lo + ((uint64_t) hi1 << 32); \
  }
#elif __riscv_xlen == 64
#define _RD_COUNTER(COUNTER) \
    static uint64_t rd ## COUNTER() \
    { \
        uint64_t res; \
        asm volatile ("rd" #COUNTER " %0" : "=r" (res)); \
        return res; \
    }
#endif

#ifdef __riscv
_RD_COUNTER(cycle);   // rdcycle()
_RD_COUNTER(time);    // rdtime()
_RD_COUNTER(instret); // rdinstret()

#endif // __riscv

#endif // GEMM_UTIL_H
