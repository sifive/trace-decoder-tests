/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

.text
.global cblas_hgemm_ccc
.type cblas_hgemm_ccc, @function

cblas_hgemm_ccc:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_ccc:
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccc_0
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_hgemm_ccc_1
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccc_2
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_hgemm_ccc_3
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccc_4
1:   
    li s1, 32
    blt a0, s1, 1f
    j cblas_hgemm_ccc_5
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_hgemm_ccc_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_hgemm_ccc_7
1:   
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_0:

cblas_hgemm_ccc_0__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_0__exit_gemm

cblas_hgemm_ccc_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_0__exit_gemm

cblas_hgemm_ccc_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_0__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_0__epilog
    vle16.v v8, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v8, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmul.vf v2, v8, ft1
    vfmul.vf v4, v8, ft2
    vfmul.vf v6, v8, ft3
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v2, ft1, v8
    vfmacc.vf v4, ft2, v8
    vfmacc.vf v6, ft3, v8
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_0__startup:
    vle16.v v8, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_0__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v10, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    vfmacc.vf v2, ft1, v8
    add t2, t2, a6
    flh ft4, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft2, v8
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmacc.vf v6, ft3, v8
    vle16.v v8, 0(t2)
    add s10, s10, a4
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v10
    fmul.h ft5, ft5, fa0
    flh ft7, 0(s10)
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft5, v10
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v4, ft6, v10
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    vfmacc.vf v6, ft7, v10
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccc_0__inner_loop

cblas_hgemm_ccc_0__epilog:
    vfmacc.vf v0, ft0, v8
    mv s10, s0
    vfmacc.vf v2, ft1, v8
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v8
    add s10, s10, t0
    vfmacc.vf v6, ft3, v8
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v6, 0(s10)

cblas_hgemm_ccc_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_0__c_col_loop

cblas_hgemm_ccc_0__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_0__c_row_loop

cblas_hgemm_ccc_0__end_c_row_loop:

cblas_hgemm_ccc_0__exit_gemm:

cblas_hgemm_ccc_0_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_1:

cblas_hgemm_ccc_1__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_1__exit_gemm

cblas_hgemm_ccc_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_1__exit_gemm

cblas_hgemm_ccc_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_1__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_1__epilog
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s10)
    vfmul.vf v6, v6, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v2, ft1, v8
    vfmacc.vf v4, ft2, v8
    vfmacc.vf v6, ft3, v8
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_1__startup:
    vle16.v v8, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_1__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v10, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    vfmacc.vf v2, ft1, v8
    add t2, t2, a6
    flh ft4, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft2, v8
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmacc.vf v6, ft3, v8
    vle16.v v8, 0(t2)
    add s10, s10, a4
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v10
    fmul.h ft5, ft5, fa0
    flh ft7, 0(s10)
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft5, v10
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v4, ft6, v10
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    vfmacc.vf v6, ft7, v10
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccc_1__inner_loop

cblas_hgemm_ccc_1__epilog:
    vfmacc.vf v0, ft0, v8
    mv s10, s0
    vfmacc.vf v2, ft1, v8
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v8
    add s10, s10, t0
    vfmacc.vf v6, ft3, v8
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v6, 0(s10)

cblas_hgemm_ccc_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_1__c_col_loop

cblas_hgemm_ccc_1__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_1__c_row_loop

cblas_hgemm_ccc_1__end_c_row_loop:

cblas_hgemm_ccc_1__exit_gemm:

cblas_hgemm_ccc_1_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_2:

cblas_hgemm_ccc_2__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_2__exit_gemm

cblas_hgemm_ccc_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_2__exit_gemm

cblas_hgemm_ccc_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_2__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_2__epilog
    vle16.v v6, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v6, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmul.vf v2, v6, ft1
    vfmul.vf v4, v6, ft2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v6, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v6
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft1, v6
    vfmacc.vf v4, ft2, v6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_2__startup:
    vle16.v v6, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_2__inner_loop:
    vfmacc.vf v0, ft0, v6
    vle16.v v8, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    vfmacc.vf v2, ft1, v6
    add t2, t2, a6
    flh ft3, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft2, v6
    flh ft4, 0(s10)
    vle16.v v6, 0(t2)
    add s10, s10, a4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft3, v8
    fmul.h ft4, ft4, fa0
    flh ft5, 0(s10)
    fmul.h ft5, ft5, fa0
    vfmacc.vf v2, ft4, v8
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft5, v8
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccc_2__inner_loop

cblas_hgemm_ccc_2__epilog:
    vfmacc.vf v0, ft0, v6
    mv s10, s0
    vfmacc.vf v2, ft1, v6
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v6
    add s10, s10, t0
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)

cblas_hgemm_ccc_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_2__c_col_loop

cblas_hgemm_ccc_2__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_2__c_row_loop

cblas_hgemm_ccc_2__end_c_row_loop:

cblas_hgemm_ccc_2__exit_gemm:

cblas_hgemm_ccc_2_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_3:

cblas_hgemm_ccc_3__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_3__exit_gemm

cblas_hgemm_ccc_3__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_3__exit_gemm

cblas_hgemm_ccc_3__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_3__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_3__epilog
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v4, 0(s10)
    vfmul.vf v4, v4, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v6, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v6
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft1, v6
    vfmacc.vf v4, ft2, v6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_3__startup:
    vle16.v v6, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_3__inner_loop:
    vfmacc.vf v0, ft0, v6
    vle16.v v8, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    vfmacc.vf v2, ft1, v6
    add t2, t2, a6
    flh ft3, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft2, v6
    flh ft4, 0(s10)
    vle16.v v6, 0(t2)
    add s10, s10, a4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft3, v8
    fmul.h ft4, ft4, fa0
    flh ft5, 0(s10)
    fmul.h ft5, ft5, fa0
    vfmacc.vf v2, ft4, v8
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft5, v8
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccc_3__inner_loop

cblas_hgemm_ccc_3__epilog:
    vfmacc.vf v0, ft0, v6
    mv s10, s0
    vfmacc.vf v2, ft1, v6
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v6
    add s10, s10, t0
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)

cblas_hgemm_ccc_3__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_3__c_col_loop

cblas_hgemm_ccc_3__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_3__c_row_loop

cblas_hgemm_ccc_3__end_c_row_loop:

cblas_hgemm_ccc_3__exit_gemm:

cblas_hgemm_ccc_3_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_4:

cblas_hgemm_ccc_4__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_4__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_4__exit_gemm

cblas_hgemm_ccc_4__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_4__exit_gemm

cblas_hgemm_ccc_4__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_4__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_4__epilog
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v2, ft0
    addi t1, t1, 2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v2
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_4__startup:
    vle16.v v2, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_4__inner_loop:
    vfmacc.vf v0, ft0, v2
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v2, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v4
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_ccc_4__inner_loop

cblas_hgemm_ccc_4__epilog:
    vfmacc.vf v0, ft0, v2
    vse16.v v0, 0(s0)

cblas_hgemm_ccc_4__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_4__c_col_loop

cblas_hgemm_ccc_4__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_4__c_row_loop

cblas_hgemm_ccc_4__end_c_row_loop:

cblas_hgemm_ccc_4__exit_gemm:

cblas_hgemm_ccc_4_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_5:

cblas_hgemm_ccc_5__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_5__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_5__exit_gemm

cblas_hgemm_ccc_5__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_5__exit_gemm

cblas_hgemm_ccc_5__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_5__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_5__epilog
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v2
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_5__startup:
    vle16.v v2, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_5__inner_loop:
    vfmacc.vf v0, ft0, v2
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v2, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v4
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_ccc_5__inner_loop

cblas_hgemm_ccc_5__epilog:
    vfmacc.vf v0, ft0, v2
    vse16.v v0, 0(s0)

cblas_hgemm_ccc_5__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_5__c_col_loop

cblas_hgemm_ccc_5__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_5__c_row_loop

cblas_hgemm_ccc_5__end_c_row_loop:

cblas_hgemm_ccc_5__exit_gemm:

cblas_hgemm_ccc_5_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_6:

cblas_hgemm_ccc_6__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccc_6__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccc_6__exit_gemm

cblas_hgemm_ccc_6__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccc_6__exit_gemm

cblas_hgemm_ccc_6__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccc_6__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccc_6__epilog
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v1, 0(s10)
    add s10, s10, t0
    vfmul.vf v1, v1, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v3, 0(s10)
    vfmul.vf v3, v3, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v4
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v4
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccc_6__startup:
    vle16.v v4, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccc_6__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v5, 0(t2)
    vfmacc.vf v1, ft1, v4
    mv s10, t1
    vfmacc.vf v2, ft2, v4
    flh ft4, 0(s10)
    vfmacc.vf v3, ft3, v4
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v5
    fmul.h ft5, ft5, fa0
    vfmacc.vf v1, ft5, v5
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft6, v5
    fmul.h ft7, ft7, fa0
    vfmacc.vf v3, ft7, v5
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccc_6__inner_loop

cblas_hgemm_ccc_6__epilog:
    vfmacc.vf v0, ft0, v4
    mv s10, s0
    vfmacc.vf v1, ft1, v4
    vfmacc.vf v2, ft2, v4
    vfmacc.vf v3, ft3, v4
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vse16.v v1, 0(s10)
    add s10, s10, t0
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v3, 0(s10)

cblas_hgemm_ccc_6__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccc_6__c_col_loop

cblas_hgemm_ccc_6__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccc_6__c_row_loop

cblas_hgemm_ccc_6__end_c_row_loop:

cblas_hgemm_ccc_6__exit_gemm:

cblas_hgemm_ccc_6_jexit:
    j exit_cblas_hgemm_ccc

cblas_hgemm_ccc_7:

cblas_hgemm_ccc_7__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m4
    li s10, 1
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_ccc_7__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_ccc_7__exit_gemm
    beqz a1, cblas_hgemm_ccc_7__exit_gemm

cblas_hgemm_ccc_7__loop_kk:
    mv s8, a1

cblas_hgemm_ccc_7__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_ccc_7__post_scale

cblas_hgemm_ccc_7__prolog_scale:
    slli s2, a0, 1
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_ccc_7__epilog_scale
    vsetvli s5, s8, e16,m4
    mul s6, s5, t0
    slli s5, s5, 1
    vlse16.v v8, 0(s3), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse16.v v0, 0(s0), t0
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    vfmacc.vf v0, ft0, v8
    vsse16.v v0, 0(s0), t0
    addi s0, s0, 2
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse16.v v4, 0(s0), t0
    addi s0, s0, 2
    vfmul.vf v4, v4, fa1
    flh ft1, 0(t1)
    vlse16.v v0, 0(s0), t0
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    addi s0, s0, 2
    vfmacc.vf v4, ft1, v8
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2

cblas_hgemm_ccc_7__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    li s10, 4
    sub s0, s0, s10
    vsse16.v v4, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    li s10, 4
    vlse16.v v4, 0(s0), t0
    addi s0, s0, 2
    sub s0, s0, s10
    li s10, 4
    vfmul.vf v4, v4, fa1
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    vfmacc.vf v4, ft1, v8
    vlse16.v v0, 0(s0), t0
    addi s0, s0, 2
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_ccc_7__loop_ii_scale

cblas_hgemm_ccc_7__epilog_scale:
    vfmacc.vf v0, ft0, v8
    li s10, 4
    sub s0, s0, s10
    vsse16.v v4, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    addi s0, s0, 2
    addi t1, t1, 2
    li s10, 4
    sub s0, s0, s10
    li s10, 4
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    j cblas_hgemm_ccc_7__end_loop_ii

cblas_hgemm_ccc_7__post_scale:

cblas_hgemm_ccc_7__prolog:
    slli s2, a0, 1
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_ccc_7__epilog
    vsetvli s5, s8, e16,m4
    mul s6, s5, t0
    slli s5, s5, 1
    vlse16.v v8, 0(s3), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse16.v v0, 0(s0), t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    addi t1, t1, 2
    vsse16.v v0, 0(s0), t0
    addi s0, s0, 2
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse16.v v4, 0(s0), t0
    addi s0, s0, 2
    flh ft1, 0(t1)
    vlse16.v v0, 0(s0), t0
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft1, v8
    addi t1, t1, 2
    addi s0, s0, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2

cblas_hgemm_ccc_7__loop_ii:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    li s10, 4
    sub s0, s0, s10
    vsse16.v v4, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    li s10, 4
    vlse16.v v4, 0(s0), t0
    addi s0, s0, 2
    sub s0, s0, s10
    li s10, 4
    vfmacc.vf v4, ft1, v8
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    vlse16.v v0, 0(s0), t0
    addi s0, s0, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_ccc_7__loop_ii

cblas_hgemm_ccc_7__epilog:
    vfmacc.vf v0, ft0, v8
    li s10, 4
    sub s0, s0, s10
    vsse16.v v4, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    addi s0, s0, 2
    addi t1, t1, 2
    li s10, 4
    sub s0, s0, s10
    li s10, 4
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10

cblas_hgemm_ccc_7__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s6, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_ccc_7__loop_jj

cblas_hgemm_ccc_7__end_loop_jj:
    li s10, 1
    mul s10, s10, a4
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    mul s10, a1, t0
    sub s4, s4, s10
    li s10, 2
    add s3, s3, s10
    addi s9, s9, -1
    bnez s9, cblas_hgemm_ccc_7__loop_kk

cblas_hgemm_ccc_7__end_loop_kk:

cblas_hgemm_ccc_7__exit_gemm:

cblas_hgemm_ccc_7_jexit:
    j exit_cblas_hgemm_ccc

exit_cblas_hgemm_ccc:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_ccc, .-cblas_hgemm_ccc

.text
.global cblas_hgemm_crr
.type cblas_hgemm_crr, @function

cblas_hgemm_crr:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_crr:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_crr_0
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_hgemm_crr_1
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_crr_2
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_hgemm_crr_3
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_crr_4
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_hgemm_crr_5
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_crr_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_hgemm_crr_7
1:   
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_0:

cblas_hgemm_crr_0__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_0__exit_gemm

cblas_hgemm_crr_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_0__exit_gemm

cblas_hgemm_crr_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_0__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_0__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v16, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v16, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmul.vf v4, v16, ft1
    vfmul.vf v8, v16, ft2
    vfmul.vf v12, v16, ft3
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vfmacc.vf v12, ft3, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_0__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_0__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v20, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v4, ft1, v16
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    vfmacc.vf v8, ft2, v16
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v12, ft3, v16
    vle16.v v16, 0(t2)
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v0, ft4, v20
    flh ft3, 6(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft5, v20
    vfmacc.vf v8, ft6, v20
    vfmacc.vf v12, ft7, v20
    blt t1, s2, cblas_hgemm_crr_0__inner_loop

cblas_hgemm_crr_0__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v4, ft1, v16
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v16
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vfmacc.vf v12, ft3, v16
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)

cblas_hgemm_crr_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_0__c_col_loop

cblas_hgemm_crr_0__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    li s9, 8
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_0__c_row_loop

cblas_hgemm_crr_0__end_c_row_loop:

cblas_hgemm_crr_0__exit_gemm:

cblas_hgemm_crr_0_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_1:

cblas_hgemm_crr_1__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_1__exit_gemm

cblas_hgemm_crr_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_1__exit_gemm

cblas_hgemm_crr_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_1__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_1__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v8, 0(s10)
    add s10, s10, t0
    vfmul.vf v8, v8, fa1
    vle16.v v12, 0(s10)
    vfmul.vf v12, v12, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vfmacc.vf v12, ft3, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_1__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_1__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v20, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v4, ft1, v16
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    vfmacc.vf v8, ft2, v16
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v12, ft3, v16
    vle16.v v16, 0(t2)
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v0, ft4, v20
    flh ft3, 6(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft5, v20
    vfmacc.vf v8, ft6, v20
    vfmacc.vf v12, ft7, v20
    blt t1, s2, cblas_hgemm_crr_1__inner_loop

cblas_hgemm_crr_1__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v4, ft1, v16
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v16
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vfmacc.vf v12, ft3, v16
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)

cblas_hgemm_crr_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_1__c_col_loop

cblas_hgemm_crr_1__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    li s9, 8
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_1__c_row_loop

cblas_hgemm_crr_1__end_c_row_loop:

cblas_hgemm_crr_1__exit_gemm:

cblas_hgemm_crr_1_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_2:

cblas_hgemm_crr_2__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_2__exit_gemm

cblas_hgemm_crr_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_2__exit_gemm

cblas_hgemm_crr_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_2__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_2__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v12, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v12, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmul.vf v4, v12, ft1
    vfmul.vf v8, v12, ft2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v12, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v12
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_2__startup:
    vle16.v v12, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_2__inner_loop:
    vfmacc.vf v0, ft0, v12
    vle16.v v16, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v4, ft1, v12
    flh ft3, 0(s10)
    flh ft4, 2(s10)
    flh ft5, 4(s10)
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    vfmacc.vf v8, ft2, v12
    vle16.v v12, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v0, ft3, v16
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft4, v16
    vfmacc.vf v8, ft5, v16
    blt t1, s2, cblas_hgemm_crr_2__inner_loop

cblas_hgemm_crr_2__epilog:
    vfmacc.vf v0, ft0, v12
    mv s10, s0
    vfmacc.vf v4, ft1, v12
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v12
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)

cblas_hgemm_crr_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_2__c_col_loop

cblas_hgemm_crr_2__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 6
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_2__c_row_loop

cblas_hgemm_crr_2__end_c_row_loop:

cblas_hgemm_crr_2__exit_gemm:

cblas_hgemm_crr_2_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_3:

cblas_hgemm_crr_3__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_3__exit_gemm

cblas_hgemm_crr_3__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_3__exit_gemm

cblas_hgemm_crr_3__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_3__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_3__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v8, 0(s10)
    vfmul.vf v8, v8, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v12, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v12
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_3__startup:
    vle16.v v12, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_3__inner_loop:
    vfmacc.vf v0, ft0, v12
    vle16.v v16, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v4, ft1, v12
    flh ft3, 0(s10)
    flh ft4, 2(s10)
    flh ft5, 4(s10)
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    vfmacc.vf v8, ft2, v12
    vle16.v v12, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    vfmacc.vf v0, ft3, v16
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft4, v16
    vfmacc.vf v8, ft5, v16
    blt t1, s2, cblas_hgemm_crr_3__inner_loop

cblas_hgemm_crr_3__epilog:
    vfmacc.vf v0, ft0, v12
    mv s10, s0
    vfmacc.vf v4, ft1, v12
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v12
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)

cblas_hgemm_crr_3__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_3__c_col_loop

cblas_hgemm_crr_3__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 6
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_3__c_row_loop

cblas_hgemm_crr_3__end_c_row_loop:

cblas_hgemm_crr_3__exit_gemm:

cblas_hgemm_crr_3_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_4:

cblas_hgemm_crr_4__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_4__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_4__exit_gemm

cblas_hgemm_crr_4__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_4__exit_gemm

cblas_hgemm_crr_4__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_4__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_4__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v4, ft0
    add t1, t1, a4
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    add t1, t1, a4
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_4__startup:
    vle16.v v4, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_4__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v4, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v8
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt t1, s2, cblas_hgemm_crr_4__inner_loop

cblas_hgemm_crr_4__epilog:
    vfmacc.vf v0, ft0, v4
    vse16.v v0, 0(s0)

cblas_hgemm_crr_4__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_4__c_col_loop

cblas_hgemm_crr_4__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    li s9, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_4__c_row_loop

cblas_hgemm_crr_4__end_c_row_loop:

cblas_hgemm_crr_4__exit_gemm:

cblas_hgemm_crr_4_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_5:

cblas_hgemm_crr_5__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_5__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_5__exit_gemm

cblas_hgemm_crr_5__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_5__exit_gemm

cblas_hgemm_crr_5__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_5__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_5__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    add t1, t1, a4
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_5__startup:
    vle16.v v4, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_5__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v4, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v8
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt t1, s2, cblas_hgemm_crr_5__inner_loop

cblas_hgemm_crr_5__epilog:
    vfmacc.vf v0, ft0, v4
    vse16.v v0, 0(s0)

cblas_hgemm_crr_5__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_5__c_col_loop

cblas_hgemm_crr_5__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    li s9, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_5__c_row_loop

cblas_hgemm_crr_5__end_c_row_loop:

cblas_hgemm_crr_5__exit_gemm:

cblas_hgemm_crr_5_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_6:

cblas_hgemm_crr_6__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m8
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crr_6__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crr_6__exit_gemm

cblas_hgemm_crr_6__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crr_6__exit_gemm

cblas_hgemm_crr_6__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crr_6__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crr_6__epilog
    vsetvli s5, s8, e16,m8
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    add t1, t1, a4
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crr_6__startup:
    vle16.v v8, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crr_6__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v16, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v8, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v16
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt t1, s2, cblas_hgemm_crr_6__inner_loop

cblas_hgemm_crr_6__epilog:
    vfmacc.vf v0, ft0, v8
    vse16.v v0, 0(s0)

cblas_hgemm_crr_6__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crr_6__c_col_loop

cblas_hgemm_crr_6__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    li s9, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crr_6__c_row_loop

cblas_hgemm_crr_6__end_c_row_loop:

cblas_hgemm_crr_6__exit_gemm:

cblas_hgemm_crr_6_jexit:
    j exit_cblas_hgemm_crr

cblas_hgemm_crr_7:

cblas_hgemm_crr_7__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m4
    li s10, 1
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_crr_7__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_crr_7__exit_gemm
    beqz a1, cblas_hgemm_crr_7__exit_gemm

cblas_hgemm_crr_7__loop_kk:
    mv s8, a1

cblas_hgemm_crr_7__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_crr_7__post_scale

cblas_hgemm_crr_7__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_crr_7__epilog_scale
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v8, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    vfmacc.vf v0, ft0, v8
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    add s0, s0, t0
    vfmacc.vf v4, ft1, v8
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    vfmul.vf v0, v0, fa1

cblas_hgemm_crr_7__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmul.vf v4, v4, fa1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vfmacc.vf v4, ft1, v8
    vle16.v v0, 0(s0)
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_crr_7__loop_ii_scale

cblas_hgemm_crr_7__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    addi t1, t1, 2
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    j cblas_hgemm_crr_7__end_loop_ii

cblas_hgemm_crr_7__post_scale:

cblas_hgemm_crr_7__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_crr_7__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v8, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    addi t1, t1, 2
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft1, v8
    addi t1, t1, 2
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2

cblas_hgemm_crr_7__loop_ii:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmacc.vf v4, ft1, v8
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vle16.v v0, 0(s0)
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_crr_7__loop_ii

cblas_hgemm_crr_7__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    addi t1, t1, 2
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10

cblas_hgemm_crr_7__end_loop_ii:
    slli s10, s5, 0
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_crr_7__loop_jj

cblas_hgemm_crr_7__end_loop_jj:
    li s10, 1
    mul s10, s10, a4
    add s1, s1, s10
    slli s10, a1, 1
    sub s3, s3, s10
    sub s4, s4, s10
    slli s10, a6, 0
    add s3, s3, s10
    addi s9, s9, -1
    bnez s9, cblas_hgemm_crr_7__loop_kk

cblas_hgemm_crr_7__end_loop_kk:

cblas_hgemm_crr_7__exit_gemm:

cblas_hgemm_crr_7_jexit:
    j exit_cblas_hgemm_crr

exit_cblas_hgemm_crr:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_crr, .-cblas_hgemm_crr

.text
.global cblas_hgemm_rcr
.type cblas_hgemm_rcr, @function

cblas_hgemm_rcr:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_rcr:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    li s1, 1
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rcr_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rcr_1
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    j cblas_hgemm_rcr_2
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_hgemm_rcr_3
1:   
    j exit_cblas_hgemm_rcr

cblas_hgemm_rcr_0:

cblas_hgemm_rcr_0__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcr_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcr_0__exit_gemm
    beqz a1, cblas_hgemm_rcr_0__exit_gemm

cblas_hgemm_rcr_0__loop_kk:
    mv s8, a1

cblas_hgemm_rcr_0__loop_jj:
    mv s0, s4
    mv t1, s1

cblas_hgemm_rcr_0__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_0__epilog
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    vfmacc.vf v0, ft0, v8
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    vfmacc.vf v4, ft8, v8
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    flh fs0, 0(s10)
    vfmacc.vf v6, fs0, v8
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft10, v12
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmacc.vf v4, ft11, v14
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmacc.vf v6, fs3, v14
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcr_0__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    vfmacc.vf v4, ft8, v8
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    vfmacc.vf v6, fs0, v8
    flh fs3, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v4, ft9, v10
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v6, fs1, v10
    vse16.v v0, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v4, ft10, v12
    add s0, s0, s10
    vse16.v v2, 0(s11)
    mv s11, s0
    vfmacc.vf v6, fs2, v12
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    vfmacc.vf v6, fs3, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_0__loop_ii

cblas_hgemm_rcr_0__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcr_0__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcr_0__loop_jj

cblas_hgemm_rcr_0__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcr_0__loop_kk

cblas_hgemm_rcr_0__end_loop_kk:

cblas_hgemm_rcr_0__exit_gemm:

cblas_hgemm_rcr_0_jexit:
    j exit_cblas_hgemm_rcr

cblas_hgemm_rcr_1:

cblas_hgemm_rcr_1__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcr_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcr_1__exit_gemm
    beqz a1, cblas_hgemm_rcr_1__exit_gemm

cblas_hgemm_rcr_1__loop_kk:
    mv s8, a1

cblas_hgemm_rcr_1__loop_jj:
    mv s0, s4
    mv t1, s1

cblas_hgemm_rcr_1__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_1__epilog
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft11, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v6, fs3, v14
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcr_1__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    add t1, t1, a4
    slli s10, t0, 2
    vfmacc.vf v6, fs1, v10
    sub s0, s0, s10
    mv s11, s0
    vse16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v6, fs2, v12
    vse16.v v2, 0(s11)
    mv s11, s0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs3, v14
    add s11, s11, t0
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_1__loop_ii

cblas_hgemm_rcr_1__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcr_1__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcr_1__loop_jj

cblas_hgemm_rcr_1__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcr_1__loop_kk

cblas_hgemm_rcr_1__end_loop_kk:

cblas_hgemm_rcr_1__exit_gemm:

cblas_hgemm_rcr_1_jexit:
    j exit_cblas_hgemm_rcr

cblas_hgemm_rcr_2:

cblas_hgemm_rcr_2__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcr_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcr_2__exit_gemm
    beqz a1, cblas_hgemm_rcr_2__exit_gemm

cblas_hgemm_rcr_2__loop_kk:
    mv s8, a1

cblas_hgemm_rcr_2__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rcr_2__post_scale

cblas_hgemm_rcr_2__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_2__epilog_scale
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    vfmul.vf v0, v0, fa1
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    vfmacc.vf v0, ft0, v8
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    vfmul.vf v6, v6, fa1
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    vfmacc.vf v4, ft8, v8
    flh ft11, 6(s10)
    mv s10, s11
    flh fs0, 0(s10)
    vfmacc.vf v6, fs0, v8
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v4, ft10, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmul.vf v2, v2, fa1
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    vfmacc.vf v4, ft11, v14
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v6, fs3, v14

cblas_hgemm_rcr_2__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    vfmul.vf v4, v4, fa1
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    vfmul.vf v6, v6, fa1
    flh fs3, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v4, ft8, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v6, fs0, v8
    vse16.v v0, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v4, ft9, v10
    add s0, s0, s10
    vse16.v v2, 0(s11)
    mv s11, s0
    vfmacc.vf v6, fs1, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v4, ft10, v12
    add s11, s11, t0
    vfmacc.vf v6, fs2, v12
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v4, ft11, v14
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmacc.vf v6, fs3, v14
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmul.vf v0, v0, fa1
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    vfmul.vf v2, v2, fa1
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_2__loop_ii_scale

cblas_hgemm_rcr_2__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)
    j cblas_hgemm_rcr_2__end_loop_ii

cblas_hgemm_rcr_2__post_scale:

cblas_hgemm_rcr_2__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_2__epilog
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    vfmacc.vf v0, ft0, v8
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    vfmacc.vf v4, ft8, v8
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    flh fs0, 0(s10)
    vfmacc.vf v6, fs0, v8
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft10, v12
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmacc.vf v4, ft11, v14
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmacc.vf v6, fs3, v14
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcr_2__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    vfmacc.vf v4, ft8, v8
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    vfmacc.vf v6, fs0, v8
    flh fs3, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v4, ft9, v10
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v6, fs1, v10
    vse16.v v0, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v4, ft10, v12
    add s0, s0, s10
    vse16.v v2, 0(s11)
    mv s11, s0
    vfmacc.vf v6, fs2, v12
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    vfmacc.vf v6, fs3, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_2__loop_ii

cblas_hgemm_rcr_2__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcr_2__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcr_2__loop_jj

cblas_hgemm_rcr_2__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcr_2__loop_kk

cblas_hgemm_rcr_2__end_loop_kk:

cblas_hgemm_rcr_2__exit_gemm:

cblas_hgemm_rcr_2_jexit:
    j exit_cblas_hgemm_rcr

cblas_hgemm_rcr_3:

cblas_hgemm_rcr_3__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcr_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcr_3__exit_gemm
    beqz a1, cblas_hgemm_rcr_3__exit_gemm

cblas_hgemm_rcr_3__loop_kk:
    mv s8, a1

cblas_hgemm_rcr_3__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rcr_3__post_scale

cblas_hgemm_rcr_3__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_3__epilog_scale
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    vfmul.vf v0, v0, fa1
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    vfmul.vf v6, v6, fa1
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmul.vf v2, v2, fa1
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v4, ft11, v14
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v6, fs3, v14
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcr_3__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmul.vf v4, v4, fa1
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    vfmul.vf v6, v6, fa1
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft8, v8
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    add t1, t1, a4
    slli s10, t0, 2
    vfmacc.vf v6, fs1, v10
    sub s0, s0, s10
    mv s11, s0
    vse16.v v0, 0(s11)
    vfmacc.vf v4, ft10, v12
    add s11, s11, t0
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v6, fs2, v12
    vse16.v v2, 0(s11)
    mv s11, s0
    add s0, s0, t0
    vfmacc.vf v4, ft11, v14
    add s0, s0, t0
    vle16.v v0, 0(s11)
    add s11, s11, t0
    vfmacc.vf v6, fs3, v14
    vle16.v v2, 0(s11)
    vfmul.vf v0, v0, fa1
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    vfmul.vf v2, v2, fa1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_3__loop_ii_scale

cblas_hgemm_rcr_3__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)
    j cblas_hgemm_rcr_3__end_loop_ii

cblas_hgemm_rcr_3__post_scale:

cblas_hgemm_rcr_3__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcr_3__epilog
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft11, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v6, fs3, v14
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcr_3__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    add t1, t1, a4
    slli s10, t0, 2
    vfmacc.vf v6, fs1, v10
    sub s0, s0, s10
    mv s11, s0
    vse16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v6, fs2, v12
    vse16.v v2, 0(s11)
    mv s11, s0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs3, v14
    add s11, s11, t0
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcr_3__loop_ii

cblas_hgemm_rcr_3__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcr_3__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcr_3__loop_jj

cblas_hgemm_rcr_3__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcr_3__loop_kk

cblas_hgemm_rcr_3__end_loop_kk:

cblas_hgemm_rcr_3__exit_gemm:

cblas_hgemm_rcr_3_jexit:
    j exit_cblas_hgemm_rcr

exit_cblas_hgemm_rcr:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_rcr, .-cblas_hgemm_rcr

.text
.global cblas_hgemm_rrc
.type cblas_hgemm_rrc, @function

cblas_hgemm_rrc:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_rrc:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrc_0
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrc_1
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrc_2
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_hgemm_rrc_3
1:   
    j exit_cblas_hgemm_rrc

cblas_hgemm_rrc_0:

cblas_hgemm_rrc_0__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrc_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrc_0__exit_gemm

cblas_hgemm_rrc_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrc_0__exit_gemm

cblas_hgemm_rrc_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrc_0__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrc_0__epilog
    vsetvli s5, s8, e16,m4
    mul s6, s5, t0
    slli s5, s5, 1
    mv s10, s4
    vlsseg2e16.v v0, 0(s10), t0
    addi s10, s10, 4
    vfmul.vf v0, v0, fa1
    vlsseg2e16.v v8, 0(s10), t0
    vfmul.vf v4, v4, fa1
    vfmul.vf v8, v8, fa1
    vfmul.vf v12, v12, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vfmacc.vf v12, ft3, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrc_0__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrc_0__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v20, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v16
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    vfmacc.vf v8, ft2, v16
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v12, ft3, v16
    vle16.v v16, 0(t2)
    add s10, s10, a4
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft4, v20
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft5, v20
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft6, v20
    vfmacc.vf v12, ft7, v20
    blt t1, s2, cblas_hgemm_rrc_0__inner_loop

cblas_hgemm_rrc_0__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vssseg2e16.v v0, 0(s10), t0
    addi s10, s10, 4
    vfmacc.vf v12, ft3, v16
    vssseg2e16.v v8, 0(s10), t0

cblas_hgemm_rrc_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrc_0__c_col_loop

cblas_hgemm_rrc_0__end_c_col_loop:
    addi s7, s7, -4
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 8
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrc_0__c_row_loop

cblas_hgemm_rrc_0__end_c_row_loop:

cblas_hgemm_rrc_0__exit_gemm:

cblas_hgemm_rrc_0_jexit:
    j exit_cblas_hgemm_rrc

cblas_hgemm_rrc_1:

cblas_hgemm_rrc_1__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrc_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrc_1__exit_gemm

cblas_hgemm_rrc_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrc_1__exit_gemm

cblas_hgemm_rrc_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrc_1__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrc_1__epilog
    vsetvli s5, s8, e16,m4
    mul s6, s5, t0
    slli s5, s5, 1
    mv s10, s4
    vlsseg2e16.v v0, 0(s10), t0
    addi s10, s10, 4
    vfmul.vf v0, v0, fa1
    vlse16.v v8, 0(s10), t0
    vfmul.vf v4, v4, fa1
    vfmul.vf v8, v8, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v12, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v12
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrc_1__startup:
    vle16.v v12, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrc_1__inner_loop:
    vfmacc.vf v0, ft0, v12
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v12
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft2, v12
    vle16.v v12, 0(t2)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft3, v16
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v4, ft4, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v8, ft5, v16
    blt t1, s2, cblas_hgemm_rrc_1__inner_loop

cblas_hgemm_rrc_1__epilog:
    vfmacc.vf v0, ft0, v12
    mv s10, s0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    vssseg2e16.v v0, 0(s10), t0
    addi s10, s10, 4
    vsse16.v v8, 0(s10), t0

cblas_hgemm_rrc_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrc_1__c_col_loop

cblas_hgemm_rrc_1__end_c_col_loop:
    addi s7, s7, -3
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 6
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrc_1__c_row_loop

cblas_hgemm_rrc_1__end_c_row_loop:

cblas_hgemm_rrc_1__exit_gemm:

cblas_hgemm_rrc_1_jexit:
    j exit_cblas_hgemm_rrc

cblas_hgemm_rrc_2:

cblas_hgemm_rrc_2__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrc_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrc_2__exit_gemm

cblas_hgemm_rrc_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrc_2__exit_gemm

cblas_hgemm_rrc_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrc_2__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrc_2__epilog
    vsetvli s5, s8, e16,m4
    mul s6, s5, t0
    slli s5, s5, 1
    vlse16.v v0, 0(s4), t0
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrc_2__startup:
    vle16.v v4, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrc_2__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v4, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v8
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_rrc_2__inner_loop

cblas_hgemm_rrc_2__epilog:
    vfmacc.vf v0, ft0, v4
    vsse16.v v0, 0(s0), t0

cblas_hgemm_rrc_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrc_2__c_col_loop

cblas_hgemm_rrc_2__end_c_col_loop:
    addi s7, s7, -1
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 2
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrc_2__c_row_loop

cblas_hgemm_rrc_2__end_c_row_loop:

cblas_hgemm_rrc_2__exit_gemm:

cblas_hgemm_rrc_2_jexit:
    j exit_cblas_hgemm_rrc

cblas_hgemm_rrc_3:

cblas_hgemm_rrc_3__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 1
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rrc_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rrc_3__exit_gemm
    beqz a1, cblas_hgemm_rrc_3__exit_gemm

cblas_hgemm_rrc_3__loop_kk:
    mv s8, a1

cblas_hgemm_rrc_3__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rrc_3__post_scale

cblas_hgemm_rrc_3__prolog_scale:
    slli s2, a0, 1
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rrc_3__epilog_scale
    vsetvli s5, s8, e16,m2
    mul s6, s5, t0
    slli s5, s5, 1
    vle16.v v4, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse16.v v0, 0(s0), t0
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    vfmacc.vf v0, ft0, v4
    vsse16.v v0, 0(s0), t0
    addi s0, s0, 2
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse16.v v2, 0(s0), t0
    addi s0, s0, 2
    vfmul.vf v2, v2, fa1
    flh ft1, 0(t1)
    vlse16.v v0, 0(s0), t0
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    addi s0, s0, 2
    vfmacc.vf v2, ft1, v4
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4

cblas_hgemm_rrc_3__loop_ii_scale:
    vfmacc.vf v0, ft0, v4
    flh ft1, 0(t1)
    li s10, 4
    sub s0, s0, s10
    vsse16.v v2, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    li s10, 4
    vlse16.v v2, 0(s0), t0
    addi s0, s0, 2
    sub s0, s0, s10
    li s10, 4
    vfmul.vf v2, v2, fa1
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    vfmacc.vf v2, ft1, v4
    vlse16.v v0, 0(s0), t0
    addi s0, s0, 2
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rrc_3__loop_ii_scale

cblas_hgemm_rrc_3__epilog_scale:
    vfmacc.vf v0, ft0, v4
    li s10, 4
    sub s0, s0, s10
    vsse16.v v2, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    addi s0, s0, 2
    add t1, t1, a4
    li s10, 4
    sub s0, s0, s10
    li s10, 4
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    j cblas_hgemm_rrc_3__end_loop_ii

cblas_hgemm_rrc_3__post_scale:

cblas_hgemm_rrc_3__prolog:
    slli s2, a0, 1
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rrc_3__epilog
    vsetvli s5, s8, e16,m2
    mul s6, s5, t0
    slli s5, s5, 1
    vle16.v v4, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse16.v v0, 0(s0), t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    add t1, t1, a4
    vsse16.v v0, 0(s0), t0
    addi s0, s0, 2
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse16.v v2, 0(s0), t0
    addi s0, s0, 2
    flh ft1, 0(t1)
    vlse16.v v0, 0(s0), t0
    fmul.h ft1, ft1, fa0
    vfmacc.vf v2, ft1, v4
    add t1, t1, a4
    addi s0, s0, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4

cblas_hgemm_rrc_3__loop_ii:
    vfmacc.vf v0, ft0, v4
    flh ft1, 0(t1)
    li s10, 4
    sub s0, s0, s10
    vsse16.v v2, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    li s10, 4
    vlse16.v v2, 0(s0), t0
    addi s0, s0, 2
    sub s0, s0, s10
    li s10, 4
    vfmacc.vf v2, ft1, v4
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10
    vlse16.v v0, 0(s0), t0
    addi s0, s0, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rrc_3__loop_ii

cblas_hgemm_rrc_3__epilog:
    vfmacc.vf v0, ft0, v4
    li s10, 4
    sub s0, s0, s10
    vsse16.v v2, 0(s0), t0
    li s10, 4
    add s0, s0, s10
    addi s0, s0, 2
    add t1, t1, a4
    li s10, 4
    sub s0, s0, s10
    li s10, 4
    vsse16.v v0, 0(s0), t0
    add s0, s0, s10

cblas_hgemm_rrc_3__end_loop_ii:
    slli s10, s5, 0
    add s3, s3, s10
    slli s10, s6, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rrc_3__loop_jj

cblas_hgemm_rrc_3__end_loop_jj:
    li s10, 2
    add s1, s1, s10
    slli s10, a1, 1
    sub s3, s3, s10
    mul s10, a1, t0
    sub s4, s4, s10
    slli s10, a6, 0
    add s3, s3, s10
    addi s9, s9, -1
    bnez s9, cblas_hgemm_rrc_3__loop_kk

cblas_hgemm_rrc_3__end_loop_kk:

cblas_hgemm_rrc_3__exit_gemm:

cblas_hgemm_rrc_3_jexit:
    j exit_cblas_hgemm_rrc

exit_cblas_hgemm_rrc:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_rrc, .-cblas_hgemm_rrc

.text
.global cblas_hgemm_ccr
.type cblas_hgemm_ccr, @function

cblas_hgemm_ccr:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_ccr:
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccr_0
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_hgemm_ccr_1
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccr_2
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_hgemm_ccr_3
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_ccr_4
1:   
    li s1, 32
    blt a0, s1, 1f
    j cblas_hgemm_ccr_5
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_hgemm_ccr_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_hgemm_ccr_7
1:   
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_0:

cblas_hgemm_ccr_0__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_0__exit_gemm

cblas_hgemm_ccr_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_0__exit_gemm

cblas_hgemm_ccr_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_0__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_0__epilog
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v4, ft0
    fmul.h ft1, ft1, fa0
    vfmul.vf v1, v4, ft1
    fmul.h ft2, ft2, fa0
    vfmul.vf v2, v4, ft2
    fmul.h ft3, ft3, fa0
    vfmul.vf v3, v4, ft3
    add t2, t2, a6
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v4
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v4
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_0__startup:
    vle16.v v4, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_0__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v5, 0(t2)
    vfmacc.vf v1, ft1, v4
    mv s10, t1
    vfmacc.vf v2, ft2, v4
    flh ft4, 0(s10)
    vfmacc.vf v3, ft3, v4
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v5
    fmul.h ft5, ft5, fa0
    vfmacc.vf v1, ft5, v5
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft6, v5
    fmul.h ft7, ft7, fa0
    vfmacc.vf v3, ft7, v5
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_0__inner_loop

cblas_hgemm_ccr_0__epilog:
    vfmacc.vf v0, ft0, v4
    mv s10, s0
    vfmacc.vf v1, ft1, v4
    vfmacc.vf v2, ft2, v4
    vfmacc.vf v3, ft3, v4
    vssseg4e16.v v0, 0(s10), t0

cblas_hgemm_ccr_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_0__c_col_loop

cblas_hgemm_ccr_0__end_c_col_loop:
    addi s7, s7, -4
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 8
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_0__c_row_loop

cblas_hgemm_ccr_0__end_c_row_loop:

cblas_hgemm_ccr_0__exit_gemm:

cblas_hgemm_ccr_0_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_1:

cblas_hgemm_ccr_1__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_1__exit_gemm

cblas_hgemm_ccr_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_1__exit_gemm

cblas_hgemm_ccr_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_1__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_1__epilog
    mv s10, s4
    vlsseg4e16.v v0, 0(s10), t0
    vfmul.vf v0, v0, fa1
    vfmul.vf v1, v1, fa1
    vfmul.vf v2, v2, fa1
    vfmul.vf v3, v3, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v4
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v4
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_1__startup:
    vle16.v v4, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_1__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v5, 0(t2)
    vfmacc.vf v1, ft1, v4
    mv s10, t1
    vfmacc.vf v2, ft2, v4
    flh ft4, 0(s10)
    vfmacc.vf v3, ft3, v4
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v5
    fmul.h ft5, ft5, fa0
    vfmacc.vf v1, ft5, v5
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft6, v5
    fmul.h ft7, ft7, fa0
    vfmacc.vf v3, ft7, v5
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_1__inner_loop

cblas_hgemm_ccr_1__epilog:
    vfmacc.vf v0, ft0, v4
    mv s10, s0
    vfmacc.vf v1, ft1, v4
    vfmacc.vf v2, ft2, v4
    vfmacc.vf v3, ft3, v4
    vssseg4e16.v v0, 0(s10), t0

cblas_hgemm_ccr_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_1__c_col_loop

cblas_hgemm_ccr_1__end_c_col_loop:
    addi s7, s7, -4
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 8
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_1__c_row_loop

cblas_hgemm_ccr_1__end_c_row_loop:

cblas_hgemm_ccr_1__exit_gemm:

cblas_hgemm_ccr_1_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_2:

cblas_hgemm_ccr_2__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_2__exit_gemm

cblas_hgemm_ccr_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_2__exit_gemm

cblas_hgemm_ccr_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_2__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_2__epilog
    vle16.v v3, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v3, ft0
    fmul.h ft1, ft1, fa0
    vfmul.vf v1, v3, ft1
    fmul.h ft2, ft2, fa0
    vfmul.vf v2, v3, ft2
    add t2, t2, a6
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v3, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v3
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v3
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v3
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_2__startup:
    vle16.v v3, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_2__inner_loop:
    vfmacc.vf v0, ft0, v3
    vle16.v v4, 0(t2)
    vfmacc.vf v1, ft1, v3
    mv s10, t1
    vfmacc.vf v2, ft2, v3
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft3, v4
    fmul.h ft4, ft4, fa0
    vfmacc.vf v1, ft4, v4
    fmul.h ft5, ft5, fa0
    vfmacc.vf v2, ft5, v4
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v3, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_2__inner_loop

cblas_hgemm_ccr_2__epilog:
    vfmacc.vf v0, ft0, v3
    mv s10, s0
    vfmacc.vf v1, ft1, v3
    vfmacc.vf v2, ft2, v3
    vssseg3e16.v v0, 0(s10), t0

cblas_hgemm_ccr_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_2__c_col_loop

cblas_hgemm_ccr_2__end_c_col_loop:
    addi s7, s7, -3
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 6
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_2__c_row_loop

cblas_hgemm_ccr_2__end_c_row_loop:

cblas_hgemm_ccr_2__exit_gemm:

cblas_hgemm_ccr_2_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_3:

cblas_hgemm_ccr_3__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_3__exit_gemm

cblas_hgemm_ccr_3__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_3__exit_gemm

cblas_hgemm_ccr_3__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_3__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_3__epilog
    mv s10, s4
    vlsseg3e16.v v0, 0(s10), t0
    vfmul.vf v0, v0, fa1
    vfmul.vf v1, v1, fa1
    vfmul.vf v2, v2, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v3, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v3
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v3
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v3
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_3__startup:
    vle16.v v3, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_3__inner_loop:
    vfmacc.vf v0, ft0, v3
    vle16.v v4, 0(t2)
    vfmacc.vf v1, ft1, v3
    mv s10, t1
    vfmacc.vf v2, ft2, v3
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft3, v4
    fmul.h ft4, ft4, fa0
    vfmacc.vf v1, ft4, v4
    fmul.h ft5, ft5, fa0
    vfmacc.vf v2, ft5, v4
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v3, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_3__inner_loop

cblas_hgemm_ccr_3__epilog:
    vfmacc.vf v0, ft0, v3
    mv s10, s0
    vfmacc.vf v1, ft1, v3
    vfmacc.vf v2, ft2, v3
    vssseg3e16.v v0, 0(s10), t0

cblas_hgemm_ccr_3__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_3__c_col_loop

cblas_hgemm_ccr_3__end_c_col_loop:
    addi s7, s7, -3
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 6
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_3__c_row_loop

cblas_hgemm_ccr_3__end_c_row_loop:

cblas_hgemm_ccr_3__exit_gemm:

cblas_hgemm_ccr_3_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_4:

cblas_hgemm_ccr_4__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_4__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_4__exit_gemm

cblas_hgemm_ccr_4__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_4__exit_gemm

cblas_hgemm_ccr_4__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_4__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_4__epilog
    vle16.v v1, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v1, ft0
    addi t1, t1, 2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v1, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v1
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_4__startup:
    vle16.v v1, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_4__inner_loop:
    vfmacc.vf v0, ft0, v1
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v1, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v2
    addi t1, t1, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_4__inner_loop

cblas_hgemm_ccr_4__epilog:
    vfmacc.vf v0, ft0, v1
    vsse16.v v0, 0(s0), t0

cblas_hgemm_ccr_4__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_4__c_col_loop

cblas_hgemm_ccr_4__end_c_col_loop:
    addi s7, s7, -1
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 2
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_4__c_row_loop

cblas_hgemm_ccr_4__end_c_row_loop:

cblas_hgemm_ccr_4__exit_gemm:

cblas_hgemm_ccr_4_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_5:

cblas_hgemm_ccr_5__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_5__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_5__exit_gemm

cblas_hgemm_ccr_5__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_5__exit_gemm

cblas_hgemm_ccr_5__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_5__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_5__epilog
    vlse16.v v0, 0(s4), t0
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v1, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v1
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_5__startup:
    vle16.v v1, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_5__inner_loop:
    vfmacc.vf v0, ft0, v1
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v1, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v2
    addi t1, t1, 2
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_5__inner_loop

cblas_hgemm_ccr_5__epilog:
    vfmacc.vf v0, ft0, v1
    vsse16.v v0, 0(s0), t0

cblas_hgemm_ccr_5__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_5__c_col_loop

cblas_hgemm_ccr_5__end_c_col_loop:
    addi s7, s7, -1
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 2
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_5__c_row_loop

cblas_hgemm_ccr_5__end_c_row_loop:

cblas_hgemm_ccr_5__exit_gemm:

cblas_hgemm_ccr_5_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_6:

cblas_hgemm_ccr_6__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_ccr_6__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_ccr_6__exit_gemm

cblas_hgemm_ccr_6__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_ccr_6__exit_gemm

cblas_hgemm_ccr_6__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_ccr_6__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_ccr_6__epilog
    mv s10, s4
    vlsseg4e16.v v0, 0(s10), t0
    vfmul.vf v0, v0, fa1
    vfmul.vf v1, v1, fa1
    vfmul.vf v2, v2, fa1
    vfmul.vf v3, v3, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v4
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v4
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v4
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_ccr_6__startup:
    vle16.v v4, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_ccr_6__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v5, 0(t2)
    vfmacc.vf v1, ft1, v4
    mv s10, t1
    vfmacc.vf v2, ft2, v4
    flh ft4, 0(s10)
    vfmacc.vf v3, ft3, v4
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    vfmacc.vf v0, ft4, v5
    fmul.h ft5, ft5, fa0
    vfmacc.vf v1, ft5, v5
    fmul.h ft6, ft6, fa0
    vfmacc.vf v2, ft6, v5
    fmul.h ft7, ft7, fa0
    vfmacc.vf v3, ft7, v5
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v4, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_ccr_6__inner_loop

cblas_hgemm_ccr_6__epilog:
    vfmacc.vf v0, ft0, v4
    mv s10, s0
    vfmacc.vf v1, ft1, v4
    vfmacc.vf v2, ft2, v4
    vfmacc.vf v3, ft3, v4
    vssseg4e16.v v0, 0(s10), t0

cblas_hgemm_ccr_6__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_ccr_6__c_col_loop

cblas_hgemm_ccr_6__end_c_col_loop:
    addi s7, s7, -4
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 8
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_ccr_6__c_row_loop

cblas_hgemm_ccr_6__end_c_row_loop:

cblas_hgemm_ccr_6__exit_gemm:

cblas_hgemm_ccr_6_jexit:
    j exit_cblas_hgemm_ccr

cblas_hgemm_ccr_7:

cblas_hgemm_ccr_7__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m4
    li s10, 1
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_ccr_7__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_ccr_7__exit_gemm
    beqz a1, cblas_hgemm_ccr_7__exit_gemm

cblas_hgemm_ccr_7__loop_kk:
    mv s8, a1

cblas_hgemm_ccr_7__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_ccr_7__post_scale

cblas_hgemm_ccr_7__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_ccr_7__epilog_scale
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vlse16.v v8, 0(s3), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    vfmacc.vf v0, ft0, v8
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    add s0, s0, t0
    vfmacc.vf v4, ft1, v8
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    vfmul.vf v0, v0, fa1

cblas_hgemm_ccr_7__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmul.vf v4, v4, fa1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vfmacc.vf v4, ft1, v8
    vle16.v v0, 0(s0)
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_ccr_7__loop_ii_scale

cblas_hgemm_ccr_7__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    addi t1, t1, 2
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    j cblas_hgemm_ccr_7__end_loop_ii

cblas_hgemm_ccr_7__post_scale:

cblas_hgemm_ccr_7__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_ccr_7__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vlse16.v v8, 0(s3), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    addi t1, t1, 2
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft1, v8
    addi t1, t1, 2
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2

cblas_hgemm_ccr_7__loop_ii:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    addi t1, t1, 2
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmacc.vf v4, ft1, v8
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vle16.v v0, 0(s0)
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt s0, s2, cblas_hgemm_ccr_7__loop_ii

cblas_hgemm_ccr_7__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    addi t1, t1, 2
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10

cblas_hgemm_ccr_7__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_ccr_7__loop_jj

cblas_hgemm_ccr_7__end_loop_jj:
    li s10, 1
    mul s10, s10, a4
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 2
    add s3, s3, s10
    addi s9, s9, -1
    bnez s9, cblas_hgemm_ccr_7__loop_kk

cblas_hgemm_ccr_7__end_loop_kk:

cblas_hgemm_ccr_7__exit_gemm:

cblas_hgemm_ccr_7_jexit:
    j exit_cblas_hgemm_ccr

exit_cblas_hgemm_ccr:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_ccr, .-cblas_hgemm_ccr

.text
.global cblas_hgemm_crc
.type cblas_hgemm_crc, @function

cblas_hgemm_crc:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_crc:
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_hgemm_crc_0
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_hgemm_crc_1
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_crc_2
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_crc_3
1:   
    j exit_cblas_hgemm_crc

cblas_hgemm_crc_0:

cblas_hgemm_crc_0__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crc_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crc_0__exit_gemm

cblas_hgemm_crc_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crc_0__exit_gemm

cblas_hgemm_crc_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crc_0__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crc_0__epilog
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s10)
    vfmul.vf v6, v6, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v2, ft1, v8
    vfmacc.vf v4, ft2, v8
    vfmacc.vf v6, ft3, v8
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crc_0__startup:
    vle16.v v8, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crc_0__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v10, 0(t2)
    mv s10, t1
    add t1, t1, a4
    vfmacc.vf v2, ft1, v8
    add t2, t2, a6
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    vfmacc.vf v4, ft2, v8
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    vfmacc.vf v6, ft3, v8
    vle16.v v8, 0(t2)
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    vfmacc.vf v0, ft4, v10
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v2, ft5, v10
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    vfmacc.vf v4, ft6, v10
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v6, ft7, v10
    fmul.h ft3, ft3, fa0
    add t1, t1, a4
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_crc_0__inner_loop

cblas_hgemm_crc_0__epilog:
    vfmacc.vf v0, ft0, v8
    mv s10, s0
    vfmacc.vf v2, ft1, v8
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v8
    add s10, s10, t0
    vfmacc.vf v6, ft3, v8
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v6, 0(s10)

cblas_hgemm_crc_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crc_0__c_col_loop

cblas_hgemm_crc_0__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    li s9, 8
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crc_0__c_row_loop

cblas_hgemm_crc_0__end_c_row_loop:

cblas_hgemm_crc_0__exit_gemm:

cblas_hgemm_crc_0_jexit:
    j exit_cblas_hgemm_crc

cblas_hgemm_crc_1:

cblas_hgemm_crc_1__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crc_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crc_1__exit_gemm

cblas_hgemm_crc_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crc_1__exit_gemm

cblas_hgemm_crc_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crc_1__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crc_1__epilog
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v4, 0(s10)
    vfmul.vf v4, v4, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v6, 0(t2)
    mv s10, t1
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v6
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft1, v6
    vfmacc.vf v4, ft2, v6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crc_1__startup:
    vle16.v v6, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crc_1__inner_loop:
    vfmacc.vf v0, ft0, v6
    vle16.v v8, 0(t2)
    mv s10, t1
    add t1, t1, a4
    vfmacc.vf v2, ft1, v6
    add t2, t2, a6
    flh ft3, 0(s10)
    flh ft4, 2(s10)
    vfmacc.vf v4, ft2, v6
    flh ft5, 4(s10)
    vle16.v v6, 0(t2)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft3, v8
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    mv s10, t1
    vfmacc.vf v2, ft4, v8
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    vfmacc.vf v4, ft5, v8
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    add t1, t1, a4
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_crc_1__inner_loop

cblas_hgemm_crc_1__epilog:
    vfmacc.vf v0, ft0, v6
    mv s10, s0
    vfmacc.vf v2, ft1, v6
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v6
    add s10, s10, t0
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vse16.v v4, 0(s10)

cblas_hgemm_crc_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crc_1__c_col_loop

cblas_hgemm_crc_1__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 6
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crc_1__c_row_loop

cblas_hgemm_crc_1__end_c_row_loop:

cblas_hgemm_crc_1__exit_gemm:

cblas_hgemm_crc_1_jexit:
    j exit_cblas_hgemm_crc

cblas_hgemm_crc_2:

cblas_hgemm_crc_2__enter:
    mv s9, a3
    mv a3, a5
    mv a5, s9
    mv s9, a4
    mv a4, a6
    mv a6, s9
    mv s9, a0
    mv a0, a1
    mv a1, s9
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    mul s9, s9, s5
    remu s9, a1, s9
    sub a1, a1, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crc_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crc_2__exit_gemm

cblas_hgemm_crc_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crc_2__exit_gemm

cblas_hgemm_crc_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crc_2__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crc_2__epilog
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v2, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v2
    add t1, t1, a4
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crc_2__startup:
    vle16.v v2, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crc_2__inner_loop:
    vfmacc.vf v0, ft0, v2
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v2, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v4
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt t1, s2, cblas_hgemm_crc_2__inner_loop

cblas_hgemm_crc_2__epilog:
    vfmacc.vf v0, ft0, v2
    vse16.v v0, 0(s0)

cblas_hgemm_crc_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crc_2__c_col_loop

cblas_hgemm_crc_2__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    li s9, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crc_2__c_row_loop

cblas_hgemm_crc_2__end_c_row_loop:

cblas_hgemm_crc_2__exit_gemm:

cblas_hgemm_crc_2_jexit:
    j exit_cblas_hgemm_crc

cblas_hgemm_crc_3:

cblas_hgemm_crc_3__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m8
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_crc_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    mul s6, s5, t0
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_crc_3__exit_gemm

cblas_hgemm_crc_3__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_crc_3__exit_gemm

cblas_hgemm_crc_3__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_crc_3__prolog:
    mul s2, a2, a4
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_crc_3__epilog
    vsetvli s5, s8, e16,m8
    mul s6, s5, t0
    slli s5, s5, 1
    vlse16.v v0, 0(s4), t0
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    add t1, t1, a4
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_crc_3__startup:
    vle16.v v8, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_crc_3__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v16, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v8, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v16
    add t1, t1, a4
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt t1, s2, cblas_hgemm_crc_3__inner_loop

cblas_hgemm_crc_3__epilog:
    vfmacc.vf v0, ft0, v8
    vsse16.v v0, 0(s0), t0

cblas_hgemm_crc_3__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_crc_3__c_col_loop

cblas_hgemm_crc_3__end_c_col_loop:
    addi s7, s7, -1
    mul s9, t0, a1
    sub s4, s4, s9
    li s9, 2
    add s4, s4, s9
    li s9, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_crc_3__c_row_loop

cblas_hgemm_crc_3__end_c_row_loop:

cblas_hgemm_crc_3__exit_gemm:

cblas_hgemm_crc_3_jexit:
    j exit_cblas_hgemm_crc

exit_cblas_hgemm_crc:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_crc, .-cblas_hgemm_crc

.text
.global cblas_hgemm_rcc
.type cblas_hgemm_rcc, @function

cblas_hgemm_rcc:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_rcc:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    j cblas_hgemm_rcc_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_hgemm_rcc_1
1:   
    j exit_cblas_hgemm_rcc

cblas_hgemm_rcc_0:

cblas_hgemm_rcc_0__enter:
    mv s10, a3
    mv a3, a5
    mv a5, s10
    mv s10, a4
    mv a4, a6
    mv a6, s10
    mv s10, a0
    mv a0, a1
    mv a1, s10
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 1
    mul s10, s10, s5
    remu s10, a1, s10
    sub a1, a1, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcc_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcc_0__exit_gemm
    beqz a1, cblas_hgemm_rcc_0__exit_gemm

cblas_hgemm_rcc_0__loop_kk:
    mv s8, a1

cblas_hgemm_rcc_0__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rcc_0__post_scale

cblas_hgemm_rcc_0__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcc_0__epilog_scale
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    vfmul.vf v0, v0, fa1
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    vfmacc.vf v0, ft0, v8
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    vfmul.vf v6, v6, fa1
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    vfmacc.vf v4, ft8, v8
    flh ft11, 6(s10)
    mv s10, s11
    flh fs0, 0(s10)
    vfmacc.vf v6, fs0, v8
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v4, ft10, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmul.vf v2, v2, fa1
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    vfmacc.vf v4, ft11, v14
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v6, fs3, v14

cblas_hgemm_rcc_0__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    vfmul.vf v4, v4, fa1
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    vfmul.vf v6, v6, fa1
    flh fs3, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v4, ft8, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v6, fs0, v8
    vse16.v v0, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v4, ft9, v10
    add s0, s0, s10
    vse16.v v2, 0(s11)
    mv s11, s0
    vfmacc.vf v6, fs1, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v4, ft10, v12
    add s11, s11, t0
    vfmacc.vf v6, fs2, v12
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v4, ft11, v14
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmacc.vf v6, fs3, v14
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmul.vf v0, v0, fa1
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    vfmul.vf v2, v2, fa1
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcc_0__loop_ii_scale

cblas_hgemm_rcc_0__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)
    j cblas_hgemm_rcc_0__end_loop_ii

cblas_hgemm_rcc_0__post_scale:

cblas_hgemm_rcc_0__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcc_0__epilog
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    vfmacc.vf v0, ft0, v8
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    vfmacc.vf v4, ft8, v8
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    flh fs0, 0(s10)
    vfmacc.vf v6, fs0, v8
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft10, v12
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmacc.vf v4, ft11, v14
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    vfmacc.vf v6, fs3, v14
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcc_0__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    mv s10, s11
    vfmacc.vf v4, ft8, v8
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    flh fs2, 4(s10)
    vfmacc.vf v6, fs0, v8
    flh fs3, 6(s10)
    add t1, t1, a4
    add t1, t1, a4
    vfmacc.vf v4, ft9, v10
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v6, fs1, v10
    vse16.v v0, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v4, ft10, v12
    add s0, s0, s10
    vse16.v v2, 0(s11)
    mv s11, s0
    vfmacc.vf v6, fs2, v12
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    vfmacc.vf v6, fs3, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcc_0__loop_ii

cblas_hgemm_rcc_0__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcc_0__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcc_0__loop_jj

cblas_hgemm_rcc_0__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcc_0__loop_kk

cblas_hgemm_rcc_0__end_loop_kk:

cblas_hgemm_rcc_0__exit_gemm:

cblas_hgemm_rcc_0_jexit:
    j exit_cblas_hgemm_rcc

cblas_hgemm_rcc_1:

cblas_hgemm_rcc_1__enter:
    mv s10, a3
    mv a3, a5
    mv a5, s10
    mv s10, a4
    mv a4, a6
    mv a6, s10
    mv s10, a0
    mv a0, a1
    mv a1, s10
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m2
    li s10, 4
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 1
    mul s10, s10, s5
    remu s10, a1, s10
    sub a1, a1, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rcc_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a1, 0(s7)
    sd a0, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rcc_1__exit_gemm
    beqz a1, cblas_hgemm_rcc_1__exit_gemm

cblas_hgemm_rcc_1__loop_kk:
    mv s8, a1

cblas_hgemm_rcc_1__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rcc_1__post_scale

cblas_hgemm_rcc_1__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcc_1__epilog_scale
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    vfmul.vf v0, v0, fa1
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    vfmul.vf v6, v6, fa1
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    vfmul.vf v2, v2, fa1
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v4, ft11, v14
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v6, fs3, v14
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcc_1__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmul.vf v4, v4, fa1
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    vfmul.vf v6, v6, fa1
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft8, v8
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft9, v10
    add t1, t1, a4
    add t1, t1, a4
    slli s10, t0, 2
    vfmacc.vf v6, fs1, v10
    sub s0, s0, s10
    mv s11, s0
    vse16.v v0, 0(s11)
    vfmacc.vf v4, ft10, v12
    add s11, s11, t0
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v6, fs2, v12
    vse16.v v2, 0(s11)
    mv s11, s0
    add s0, s0, t0
    vfmacc.vf v4, ft11, v14
    add s0, s0, t0
    vle16.v v0, 0(s11)
    add s11, s11, t0
    vfmacc.vf v6, fs3, v14
    vle16.v v2, 0(s11)
    vfmul.vf v0, v0, fa1
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    vfmul.vf v2, v2, fa1
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcc_1__loop_ii_scale

cblas_hgemm_rcc_1__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)
    j cblas_hgemm_rcc_1__end_loop_ii

cblas_hgemm_rcc_1__post_scale:

cblas_hgemm_rcc_1__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rcc_1__epilog
    mv s11, s3
    vlsseg4e16.v v8, 0(s11), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    mv s11, t1
    add t1, t1, a4
    flh ft0, 0(s11)
    flh ft1, 2(s11)
    flh ft2, 4(s11)
    flh ft3, 6(s11)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v0, ft1, v10
    vfmacc.vf v0, ft2, v12
    vfmacc.vf v0, ft3, v14
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    mv s11, s0
    vle16.v v4, 0(s11)
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    mv s11, s0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs1, v10
    add s11, s11, t0
    add s0, s0, t0
    add s0, s0, t0
    vfmacc.vf v4, ft11, v14
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v6, fs2, v12
    add s11, s11, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v6, fs3, v14
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    add t1, t1, a4

cblas_hgemm_rcc_1__loop_ii:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    mv s11, s0
    vfmacc.vf v2, ft5, v10
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v4, 0(s11)
    vfmacc.vf v0, ft2, v12
    add s11, s11, t0
    vfmacc.vf v2, ft6, v12
    vle16.v v6, 0(s11)
    mv s11, t1
    mv s10, s11
    vfmacc.vf v0, ft3, v14
    add s11, s11, a4
    flh ft8, 0(s10)
    flh ft9, 2(s10)
    vfmacc.vf v2, ft7, v14
    flh ft10, 4(s10)
    flh ft11, 6(s10)
    fmul.h ft8, ft8, fa0
    vfmacc.vf v4, ft8, v8
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    mv s10, s11
    flh fs0, 0(s10)
    flh fs1, 2(s10)
    vfmacc.vf v4, ft9, v10
    flh fs2, 4(s10)
    flh fs3, 6(s10)
    fmul.h fs0, fs0, fa0
    vfmacc.vf v6, fs0, v8
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    vfmacc.vf v4, ft10, v12
    add t1, t1, a4
    add t1, t1, a4
    slli s10, t0, 2
    vfmacc.vf v6, fs1, v10
    sub s0, s0, s10
    mv s11, s0
    vse16.v v0, 0(s11)
    vfmacc.vf v4, ft11, v14
    add s11, s11, t0
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v6, fs2, v12
    vse16.v v2, 0(s11)
    mv s11, s0
    add s0, s0, t0
    add s0, s0, t0
    vle16.v v0, 0(s11)
    vfmacc.vf v6, fs3, v14
    add s11, s11, t0
    vle16.v v2, 0(s11)
    mv s11, t1
    mv s10, s11
    add s11, s11, a4
    add t1, t1, a4
    flh ft0, 0(s10)
    flh ft1, 2(s10)
    flh ft2, 4(s10)
    flh ft3, 6(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    mv s10, s11
    flh ft4, 0(s10)
    flh ft5, 2(s10)
    flh ft6, 4(s10)
    flh ft7, 6(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rcc_1__loop_ii

cblas_hgemm_rcc_1__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft4, v8
    vse16.v v4, 0(s11)
    add s11, s11, t0
    slli s10, t0, 2
    vfmacc.vf v0, ft1, v10
    add s0, s0, s10
    vse16.v v6, 0(s11)
    add s0, s0, t0
    vfmacc.vf v2, ft5, v10
    add t1, t1, a4
    add s0, s0, t0
    add t1, t1, a4
    vfmacc.vf v0, ft2, v12
    slli s10, t0, 2
    sub s0, s0, s10
    mv s11, s0
    vfmacc.vf v2, ft6, v12
    slli s10, t0, 2
    add s0, s0, s10
    vfmacc.vf v0, ft3, v14
    vfmacc.vf v2, ft7, v14
    vse16.v v0, 0(s11)
    add s11, s11, t0
    vse16.v v2, 0(s11)

cblas_hgemm_rcc_1__end_loop_ii:
    srai s10, s5, 1
    mul s10, s10, a6
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rcc_1__loop_jj

cblas_hgemm_rcc_1__end_loop_jj:
    li s10, 8
    add s1, s1, s10
    mul s10, a1, a6
    sub s3, s3, s10
    slli s10, a1, 1
    sub s4, s4, s10
    li s10, 8
    add s3, s3, s10
    addi s9, s9, -4
    bnez s9, cblas_hgemm_rcc_1__loop_kk

cblas_hgemm_rcc_1__end_loop_kk:

cblas_hgemm_rcc_1__exit_gemm:

cblas_hgemm_rcc_1_jexit:
    j exit_cblas_hgemm_rcc

exit_cblas_hgemm_rcc:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_rcc, .-cblas_hgemm_rcc

.text
.global cblas_hgemm_rrr
.type cblas_hgemm_rrr, @function

cblas_hgemm_rrr:
    addi sp, sp, -96
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)
    sd s4, 32(sp)
    sd s5, 40(sp)
    sd s6, 48(sp)
    sd s7, 56(sp)
    sd s8, 64(sp)
    sd s9, 72(sp)
    sd s10, 80(sp)
    sd s11, 88(sp)
    addi sp, sp, -96
    fsd fs0, 0(sp)
    fsd fs1, 8(sp)
    fsd fs2, 16(sp)
    fsd fs3, 24(sp)
    fsd fs4, 32(sp)
    fsd fs5, 40(sp)
    fsd fs6, 48(sp)
    fsd fs7, 56(sp)
    fsd fs8, 64(sp)
    fsd fs9, 72(sp)
    fsd fs10, 80(sp)
    fsd fs11, 88(sp)
    addi fp, sp, 192

dispatch_cblas_hgemm_rrr:
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rrr_0
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rrr_1
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_2
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_3
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rrr_4
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_5
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rrr_6
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_7
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 0
    fcvt.h.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_hgemm_rrr_8
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_9
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_10
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_hgemm_rrr_11
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_hgemm_rrr_12
1:   
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_0:

cblas_hgemm_rrr_0__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 16
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_0__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_0__exit_gemm

cblas_hgemm_rrr_0__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_0__exit_gemm

cblas_hgemm_rrr_0__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_0__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_0__epilog
    vsetvli s5, s8, e16,m1
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    vfmul.vf v0, v16, ft0
    add s10, s10, a4
    flh ft1, 0(s10)
    vfmul.vf v1, v16, ft1
    add s10, s10, a4
    flh ft2, 0(s10)
    vfmul.vf v2, v16, ft2
    add s10, s10, a4
    flh ft3, 0(s10)
    vfmul.vf v3, v16, ft3
    add s10, s10, a4
    flh ft4, 0(s10)
    vfmul.vf v4, v16, ft4
    add s10, s10, a4
    flh ft5, 0(s10)
    vfmul.vf v5, v16, ft5
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmul.vf v6, v16, ft6
    add s10, s10, a4
    flh ft7, 0(s10)
    vfmul.vf v7, v16, ft7
    add s10, s10, a4
    flh ft8, 0(s10)
    vfmul.vf v8, v16, ft8
    add s10, s10, a4
    flh ft9, 0(s10)
    vfmul.vf v9, v16, ft9
    add s10, s10, a4
    flh ft10, 0(s10)
    vfmul.vf v10, v16, ft10
    add s10, s10, a4
    flh ft11, 0(s10)
    vfmul.vf v11, v16, ft11
    add s10, s10, a4
    flh fs0, 0(s10)
    vfmul.vf v12, v16, fs0
    add s10, s10, a4
    flh fs1, 0(s10)
    vfmul.vf v13, v16, fs1
    add s10, s10, a4
    flh fs2, 0(s10)
    vfmul.vf v14, v16, fs2
    add s10, s10, a4
    flh fs3, 0(s10)
    vfmul.vf v15, v16, fs3
    add t2, t2, a6
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    vfmacc.vf v0, ft0, v16
    add s10, s10, a4
    flh ft1, 0(s10)
    vfmacc.vf v1, ft1, v16
    add s10, s10, a4
    flh ft2, 0(s10)
    vfmacc.vf v2, ft2, v16
    add s10, s10, a4
    flh ft3, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    flh ft4, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, a4
    flh ft5, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, a4
    flh ft7, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    flh ft8, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, a4
    flh ft9, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    flh ft10, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, a4
    flh ft11, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    flh fs0, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, a4
    flh fs1, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    flh fs2, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, a4
    flh fs3, 0(s10)
    vfmacc.vf v15, fs3, v16
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_0__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_0__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v17, 0(t2)
    vfmacc.vf v1, ft1, v16
    mv s10, t1
    vfmacc.vf v2, ft2, v16
    flh ft0, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    vfmacc.vf v4, ft4, v16
    flh ft1, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    vfmacc.vf v6, ft6, v16
    flh ft2, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    vfmacc.vf v8, ft8, v16
    flh ft3, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    vfmacc.vf v10, ft10, v16
    flh ft4, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    vfmacc.vf v12, fs0, v16
    flh ft5, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    vfmacc.vf v14, fs2, v16
    flh ft6, 0(s10)
    vfmacc.vf v15, fs3, v16
    add s10, s10, a4
    vfmacc.vf v0, ft0, v17
    flh ft7, 0(s10)
    vfmacc.vf v1, ft1, v17
    add s10, s10, a4
    vfmacc.vf v2, ft2, v17
    flh ft8, 0(s10)
    vfmacc.vf v3, ft3, v17
    add s10, s10, a4
    vfmacc.vf v4, ft4, v17
    flh ft9, 0(s10)
    vfmacc.vf v5, ft5, v17
    add s10, s10, a4
    vfmacc.vf v6, ft6, v17
    flh ft10, 0(s10)
    vfmacc.vf v7, ft7, v17
    add s10, s10, a4
    vfmacc.vf v8, ft8, v17
    flh ft11, 0(s10)
    vfmacc.vf v9, ft9, v17
    add s10, s10, a4
    vfmacc.vf v10, ft10, v17
    flh fs0, 0(s10)
    vfmacc.vf v11, ft11, v17
    add s10, s10, a4
    vfmacc.vf v12, fs0, v17
    flh fs1, 0(s10)
    vfmacc.vf v13, fs1, v17
    add s10, s10, a4
    flh fs2, 0(s10)
    vfmacc.vf v14, fs2, v17
    add s10, s10, a4
    flh fs3, 0(s10)
    vfmacc.vf v15, fs3, v17
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_rrr_0__inner_loop

cblas_hgemm_rrr_0__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v1, ft1, v16
    vfmacc.vf v2, ft2, v16
    vfmacc.vf v3, ft3, v16
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, t0
    vfmacc.vf v5, ft5, v16
    vse16.v v1, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, t0
    vfmacc.vf v7, ft7, v16
    vse16.v v2, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, t0
    vfmacc.vf v9, ft9, v16
    vse16.v v3, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, t0
    vfmacc.vf v11, ft11, v16
    vse16.v v4, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, t0
    vfmacc.vf v13, fs1, v16
    vse16.v v5, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, t0
    vfmacc.vf v15, fs3, v16
    vse16.v v6, 0(s10)
    add s10, s10, t0
    vse16.v v7, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v9, 0(s10)
    add s10, s10, t0
    vse16.v v10, 0(s10)
    add s10, s10, t0
    vse16.v v11, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)
    add s10, s10, t0
    vse16.v v13, 0(s10)
    add s10, s10, t0
    vse16.v v14, 0(s10)
    add s10, s10, t0
    vse16.v v15, 0(s10)

cblas_hgemm_rrr_0__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_0__c_col_loop

cblas_hgemm_rrr_0__end_c_col_loop:
    addi s7, s7, -16
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 4
    add s4, s4, s9
    slli s9, a4, 4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_0__c_row_loop

cblas_hgemm_rrr_0__end_c_row_loop:

cblas_hgemm_rrr_0__exit_gemm:

cblas_hgemm_rrr_0_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_1:

cblas_hgemm_rrr_1__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 16
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_1__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_1__exit_gemm

cblas_hgemm_rrr_1__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_1__exit_gemm

cblas_hgemm_rrr_1__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_1__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_1__epilog
    vsetvli s5, s8, e16,m1
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v16, ft0
    fmul.h ft1, ft1, fa0
    vfmul.vf v1, v16, ft1
    fmul.h ft2, ft2, fa0
    vfmul.vf v2, v16, ft2
    fmul.h ft3, ft3, fa0
    vfmul.vf v3, v16, ft3
    fmul.h ft4, ft4, fa0
    vfmul.vf v4, v16, ft4
    fmul.h ft5, ft5, fa0
    vfmul.vf v5, v16, ft5
    fmul.h ft6, ft6, fa0
    vfmul.vf v6, v16, ft6
    fmul.h ft7, ft7, fa0
    vfmul.vf v7, v16, ft7
    fmul.h ft8, ft8, fa0
    vfmul.vf v8, v16, ft8
    fmul.h ft9, ft9, fa0
    vfmul.vf v9, v16, ft9
    fmul.h ft10, ft10, fa0
    vfmul.vf v10, v16, ft10
    fmul.h ft11, ft11, fa0
    vfmul.vf v11, v16, ft11
    fmul.h fs0, fs0, fa0
    vfmul.vf v12, v16, fs0
    fmul.h fs1, fs1, fa0
    vfmul.vf v13, v16, fs1
    fmul.h fs2, fs2, fa0
    vfmul.vf v14, v16, fs2
    fmul.h fs3, fs3, fa0
    vfmul.vf v15, v16, fs3
    add t2, t2, a6
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v16
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v16
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v16
    fmul.h ft4, ft4, fa0
    vfmacc.vf v4, ft4, v16
    fmul.h ft5, ft5, fa0
    vfmacc.vf v5, ft5, v16
    fmul.h ft6, ft6, fa0
    vfmacc.vf v6, ft6, v16
    fmul.h ft7, ft7, fa0
    vfmacc.vf v7, ft7, v16
    fmul.h ft8, ft8, fa0
    vfmacc.vf v8, ft8, v16
    fmul.h ft9, ft9, fa0
    vfmacc.vf v9, ft9, v16
    fmul.h ft10, ft10, fa0
    vfmacc.vf v10, ft10, v16
    fmul.h ft11, ft11, fa0
    vfmacc.vf v11, ft11, v16
    fmul.h fs0, fs0, fa0
    vfmacc.vf v12, fs0, v16
    fmul.h fs1, fs1, fa0
    vfmacc.vf v13, fs1, v16
    fmul.h fs2, fs2, fa0
    vfmacc.vf v14, fs2, v16
    fmul.h fs3, fs3, fa0
    vfmacc.vf v15, fs3, v16
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_1__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    fmul.h ft8, ft8, fa0
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    fmul.h fs0, fs0, fa0
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_1__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v17, 0(t2)
    vfmacc.vf v1, ft1, v16
    mv s10, t1
    vfmacc.vf v2, ft2, v16
    flh ft0, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    vfmacc.vf v4, ft4, v16
    flh ft1, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    vfmacc.vf v6, ft6, v16
    flh ft2, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    vfmacc.vf v8, ft8, v16
    flh ft3, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    vfmacc.vf v10, ft10, v16
    flh ft4, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    vfmacc.vf v12, fs0, v16
    flh ft5, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    vfmacc.vf v14, fs2, v16
    flh ft6, 0(s10)
    vfmacc.vf v15, fs3, v16
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v17
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v17
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v17
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v17
    fmul.h ft4, ft4, fa0
    vfmacc.vf v4, ft4, v17
    fmul.h ft5, ft5, fa0
    vfmacc.vf v5, ft5, v17
    fmul.h ft6, ft6, fa0
    vfmacc.vf v6, ft6, v17
    fmul.h ft7, ft7, fa0
    vfmacc.vf v7, ft7, v17
    fmul.h ft8, ft8, fa0
    vfmacc.vf v8, ft8, v17
    fmul.h ft9, ft9, fa0
    vfmacc.vf v9, ft9, v17
    fmul.h ft10, ft10, fa0
    vfmacc.vf v10, ft10, v17
    fmul.h ft11, ft11, fa0
    vfmacc.vf v11, ft11, v17
    fmul.h fs0, fs0, fa0
    vfmacc.vf v12, fs0, v17
    fmul.h fs1, fs1, fa0
    vfmacc.vf v13, fs1, v17
    fmul.h fs2, fs2, fa0
    vfmacc.vf v14, fs2, v17
    fmul.h fs3, fs3, fa0
    vfmacc.vf v15, fs3, v17
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    fmul.h ft8, ft8, fa0
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    fmul.h fs0, fs0, fa0
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_rrr_1__inner_loop

cblas_hgemm_rrr_1__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v1, ft1, v16
    vfmacc.vf v2, ft2, v16
    vfmacc.vf v3, ft3, v16
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, t0
    vfmacc.vf v5, ft5, v16
    vse16.v v1, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, t0
    vfmacc.vf v7, ft7, v16
    vse16.v v2, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, t0
    vfmacc.vf v9, ft9, v16
    vse16.v v3, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, t0
    vfmacc.vf v11, ft11, v16
    vse16.v v4, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, t0
    vfmacc.vf v13, fs1, v16
    vse16.v v5, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, t0
    vfmacc.vf v15, fs3, v16
    vse16.v v6, 0(s10)
    add s10, s10, t0
    vse16.v v7, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v9, 0(s10)
    add s10, s10, t0
    vse16.v v10, 0(s10)
    add s10, s10, t0
    vse16.v v11, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)
    add s10, s10, t0
    vse16.v v13, 0(s10)
    add s10, s10, t0
    vse16.v v14, 0(s10)
    add s10, s10, t0
    vse16.v v15, 0(s10)

cblas_hgemm_rrr_1__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_1__c_col_loop

cblas_hgemm_rrr_1__end_c_col_loop:
    addi s7, s7, -16
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 4
    add s4, s4, s9
    slli s9, a4, 4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_1__c_row_loop

cblas_hgemm_rrr_1__end_c_row_loop:

cblas_hgemm_rrr_1__exit_gemm:

cblas_hgemm_rrr_1_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_2:

cblas_hgemm_rrr_2__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 16
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_2__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_2__exit_gemm

cblas_hgemm_rrr_2__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_2__exit_gemm

cblas_hgemm_rrr_2__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_2__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_2__epilog
    vsetvli s5, s8, e16,m1
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v1, 0(s10)
    add s10, s10, t0
    vfmul.vf v1, v1, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v3, 0(s10)
    add s10, s10, t0
    vfmul.vf v3, v3, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v5, 0(s10)
    add s10, s10, t0
    vfmul.vf v5, v5, fa1
    vle16.v v6, 0(s10)
    add s10, s10, t0
    vfmul.vf v6, v6, fa1
    vle16.v v7, 0(s10)
    add s10, s10, t0
    vfmul.vf v7, v7, fa1
    vle16.v v8, 0(s10)
    add s10, s10, t0
    vfmul.vf v8, v8, fa1
    vle16.v v9, 0(s10)
    add s10, s10, t0
    vfmul.vf v9, v9, fa1
    vle16.v v10, 0(s10)
    add s10, s10, t0
    vfmul.vf v10, v10, fa1
    vle16.v v11, 0(s10)
    add s10, s10, t0
    vfmul.vf v11, v11, fa1
    vle16.v v12, 0(s10)
    add s10, s10, t0
    vfmul.vf v12, v12, fa1
    vle16.v v13, 0(s10)
    add s10, s10, t0
    vfmul.vf v13, v13, fa1
    vle16.v v14, 0(s10)
    add s10, s10, t0
    vfmul.vf v14, v14, fa1
    vle16.v v15, 0(s10)
    vfmul.vf v15, v15, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    vfmacc.vf v0, ft0, v16
    add s10, s10, a4
    flh ft1, 0(s10)
    vfmacc.vf v1, ft1, v16
    add s10, s10, a4
    flh ft2, 0(s10)
    vfmacc.vf v2, ft2, v16
    add s10, s10, a4
    flh ft3, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    flh ft4, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, a4
    flh ft5, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, a4
    flh ft7, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    flh ft8, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, a4
    flh ft9, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    flh ft10, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, a4
    flh ft11, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    flh fs0, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, a4
    flh fs1, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    flh fs2, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, a4
    flh fs3, 0(s10)
    vfmacc.vf v15, fs3, v16
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_2__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_2__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v17, 0(t2)
    vfmacc.vf v1, ft1, v16
    mv s10, t1
    vfmacc.vf v2, ft2, v16
    flh ft0, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    vfmacc.vf v4, ft4, v16
    flh ft1, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    vfmacc.vf v6, ft6, v16
    flh ft2, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    vfmacc.vf v8, ft8, v16
    flh ft3, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    vfmacc.vf v10, ft10, v16
    flh ft4, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    vfmacc.vf v12, fs0, v16
    flh ft5, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    vfmacc.vf v14, fs2, v16
    flh ft6, 0(s10)
    vfmacc.vf v15, fs3, v16
    add s10, s10, a4
    vfmacc.vf v0, ft0, v17
    flh ft7, 0(s10)
    vfmacc.vf v1, ft1, v17
    add s10, s10, a4
    vfmacc.vf v2, ft2, v17
    flh ft8, 0(s10)
    vfmacc.vf v3, ft3, v17
    add s10, s10, a4
    vfmacc.vf v4, ft4, v17
    flh ft9, 0(s10)
    vfmacc.vf v5, ft5, v17
    add s10, s10, a4
    vfmacc.vf v6, ft6, v17
    flh ft10, 0(s10)
    vfmacc.vf v7, ft7, v17
    add s10, s10, a4
    vfmacc.vf v8, ft8, v17
    flh ft11, 0(s10)
    vfmacc.vf v9, ft9, v17
    add s10, s10, a4
    vfmacc.vf v10, ft10, v17
    flh fs0, 0(s10)
    vfmacc.vf v11, ft11, v17
    add s10, s10, a4
    vfmacc.vf v12, fs0, v17
    flh fs1, 0(s10)
    vfmacc.vf v13, fs1, v17
    add s10, s10, a4
    flh fs2, 0(s10)
    vfmacc.vf v14, fs2, v17
    add s10, s10, a4
    flh fs3, 0(s10)
    vfmacc.vf v15, fs3, v17
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_rrr_2__inner_loop

cblas_hgemm_rrr_2__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v1, ft1, v16
    vfmacc.vf v2, ft2, v16
    vfmacc.vf v3, ft3, v16
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, t0
    vfmacc.vf v5, ft5, v16
    vse16.v v1, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, t0
    vfmacc.vf v7, ft7, v16
    vse16.v v2, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, t0
    vfmacc.vf v9, ft9, v16
    vse16.v v3, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, t0
    vfmacc.vf v11, ft11, v16
    vse16.v v4, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, t0
    vfmacc.vf v13, fs1, v16
    vse16.v v5, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, t0
    vfmacc.vf v15, fs3, v16
    vse16.v v6, 0(s10)
    add s10, s10, t0
    vse16.v v7, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v9, 0(s10)
    add s10, s10, t0
    vse16.v v10, 0(s10)
    add s10, s10, t0
    vse16.v v11, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)
    add s10, s10, t0
    vse16.v v13, 0(s10)
    add s10, s10, t0
    vse16.v v14, 0(s10)
    add s10, s10, t0
    vse16.v v15, 0(s10)

cblas_hgemm_rrr_2__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_2__c_col_loop

cblas_hgemm_rrr_2__end_c_col_loop:
    addi s7, s7, -16
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 4
    add s4, s4, s9
    slli s9, a4, 4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_2__c_row_loop

cblas_hgemm_rrr_2__end_c_row_loop:

cblas_hgemm_rrr_2__exit_gemm:

cblas_hgemm_rrr_2_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_3:

cblas_hgemm_rrr_3__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m1
    li s9, 16
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_3__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_3__exit_gemm

cblas_hgemm_rrr_3__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_3__exit_gemm

cblas_hgemm_rrr_3__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_3__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_3__epilog
    vsetvli s5, s8, e16,m1
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v1, 0(s10)
    add s10, s10, t0
    vfmul.vf v1, v1, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v3, 0(s10)
    add s10, s10, t0
    vfmul.vf v3, v3, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v5, 0(s10)
    add s10, s10, t0
    vfmul.vf v5, v5, fa1
    vle16.v v6, 0(s10)
    add s10, s10, t0
    vfmul.vf v6, v6, fa1
    vle16.v v7, 0(s10)
    add s10, s10, t0
    vfmul.vf v7, v7, fa1
    vle16.v v8, 0(s10)
    add s10, s10, t0
    vfmul.vf v8, v8, fa1
    vle16.v v9, 0(s10)
    add s10, s10, t0
    vfmul.vf v9, v9, fa1
    vle16.v v10, 0(s10)
    add s10, s10, t0
    vfmul.vf v10, v10, fa1
    vle16.v v11, 0(s10)
    add s10, s10, t0
    vfmul.vf v11, v11, fa1
    vle16.v v12, 0(s10)
    add s10, s10, t0
    vfmul.vf v12, v12, fa1
    vle16.v v13, 0(s10)
    add s10, s10, t0
    vfmul.vf v13, v13, fa1
    vle16.v v14, 0(s10)
    add s10, s10, t0
    vfmul.vf v14, v14, fa1
    vle16.v v15, 0(s10)
    vfmul.vf v15, v15, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v16
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v16
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v16
    fmul.h ft4, ft4, fa0
    vfmacc.vf v4, ft4, v16
    fmul.h ft5, ft5, fa0
    vfmacc.vf v5, ft5, v16
    fmul.h ft6, ft6, fa0
    vfmacc.vf v6, ft6, v16
    fmul.h ft7, ft7, fa0
    vfmacc.vf v7, ft7, v16
    fmul.h ft8, ft8, fa0
    vfmacc.vf v8, ft8, v16
    fmul.h ft9, ft9, fa0
    vfmacc.vf v9, ft9, v16
    fmul.h ft10, ft10, fa0
    vfmacc.vf v10, ft10, v16
    fmul.h ft11, ft11, fa0
    vfmacc.vf v11, ft11, v16
    fmul.h fs0, fs0, fa0
    vfmacc.vf v12, fs0, v16
    fmul.h fs1, fs1, fa0
    vfmacc.vf v13, fs1, v16
    fmul.h fs2, fs2, fa0
    vfmacc.vf v14, fs2, v16
    fmul.h fs3, fs3, fa0
    vfmacc.vf v15, fs3, v16
    add t2, t2, a6
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_3__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    fmul.h ft8, ft8, fa0
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    fmul.h fs0, fs0, fa0
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_3__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v17, 0(t2)
    vfmacc.vf v1, ft1, v16
    mv s10, t1
    vfmacc.vf v2, ft2, v16
    flh ft0, 0(s10)
    vfmacc.vf v3, ft3, v16
    add s10, s10, a4
    vfmacc.vf v4, ft4, v16
    flh ft1, 0(s10)
    vfmacc.vf v5, ft5, v16
    add s10, s10, a4
    vfmacc.vf v6, ft6, v16
    flh ft2, 0(s10)
    vfmacc.vf v7, ft7, v16
    add s10, s10, a4
    vfmacc.vf v8, ft8, v16
    flh ft3, 0(s10)
    vfmacc.vf v9, ft9, v16
    add s10, s10, a4
    vfmacc.vf v10, ft10, v16
    flh ft4, 0(s10)
    vfmacc.vf v11, ft11, v16
    add s10, s10, a4
    vfmacc.vf v12, fs0, v16
    flh ft5, 0(s10)
    vfmacc.vf v13, fs1, v16
    add s10, s10, a4
    vfmacc.vf v14, fs2, v16
    flh ft6, 0(s10)
    vfmacc.vf v15, fs3, v16
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v17
    fmul.h ft1, ft1, fa0
    vfmacc.vf v1, ft1, v17
    fmul.h ft2, ft2, fa0
    vfmacc.vf v2, ft2, v17
    fmul.h ft3, ft3, fa0
    vfmacc.vf v3, ft3, v17
    fmul.h ft4, ft4, fa0
    vfmacc.vf v4, ft4, v17
    fmul.h ft5, ft5, fa0
    vfmacc.vf v5, ft5, v17
    fmul.h ft6, ft6, fa0
    vfmacc.vf v6, ft6, v17
    fmul.h ft7, ft7, fa0
    vfmacc.vf v7, ft7, v17
    fmul.h ft8, ft8, fa0
    vfmacc.vf v8, ft8, v17
    fmul.h ft9, ft9, fa0
    vfmacc.vf v9, ft9, v17
    fmul.h ft10, ft10, fa0
    vfmacc.vf v10, ft10, v17
    fmul.h ft11, ft11, fa0
    vfmacc.vf v11, ft11, v17
    fmul.h fs0, fs0, fa0
    vfmacc.vf v12, fs0, v17
    fmul.h fs1, fs1, fa0
    vfmacc.vf v13, fs1, v17
    fmul.h fs2, fs2, fa0
    vfmacc.vf v14, fs2, v17
    fmul.h fs3, fs3, fa0
    vfmacc.vf v15, fs3, v17
    addi t1, t1, 2
    add t2, t2, a6
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    add s10, s10, a4
    flh ft8, 0(s10)
    add s10, s10, a4
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    flh fs3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    fmul.h ft8, ft8, fa0
    fmul.h ft9, ft9, fa0
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    fmul.h fs0, fs0, fa0
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    fmul.h fs3, fs3, fa0
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_rrr_3__inner_loop

cblas_hgemm_rrr_3__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v1, ft1, v16
    vfmacc.vf v2, ft2, v16
    vfmacc.vf v3, ft3, v16
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft4, v16
    add s10, s10, t0
    vfmacc.vf v5, ft5, v16
    vse16.v v1, 0(s10)
    vfmacc.vf v6, ft6, v16
    add s10, s10, t0
    vfmacc.vf v7, ft7, v16
    vse16.v v2, 0(s10)
    vfmacc.vf v8, ft8, v16
    add s10, s10, t0
    vfmacc.vf v9, ft9, v16
    vse16.v v3, 0(s10)
    vfmacc.vf v10, ft10, v16
    add s10, s10, t0
    vfmacc.vf v11, ft11, v16
    vse16.v v4, 0(s10)
    vfmacc.vf v12, fs0, v16
    add s10, s10, t0
    vfmacc.vf v13, fs1, v16
    vse16.v v5, 0(s10)
    vfmacc.vf v14, fs2, v16
    add s10, s10, t0
    vfmacc.vf v15, fs3, v16
    vse16.v v6, 0(s10)
    add s10, s10, t0
    vse16.v v7, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v9, 0(s10)
    add s10, s10, t0
    vse16.v v10, 0(s10)
    add s10, s10, t0
    vse16.v v11, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)
    add s10, s10, t0
    vse16.v v13, 0(s10)
    add s10, s10, t0
    vse16.v v14, 0(s10)
    add s10, s10, t0
    vse16.v v15, 0(s10)

cblas_hgemm_rrr_3__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_3__c_col_loop

cblas_hgemm_rrr_3__end_c_col_loop:
    addi s7, s7, -16
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 4
    add s4, s4, s9
    slli s9, a4, 4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_3__c_row_loop

cblas_hgemm_rrr_3__end_c_row_loop:

cblas_hgemm_rrr_3__exit_gemm:

cblas_hgemm_rrr_3_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_4:

cblas_hgemm_rrr_4__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_4__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_4__exit_gemm

cblas_hgemm_rrr_4__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_4__exit_gemm

cblas_hgemm_rrr_4__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_4__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_4__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v16, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmul.vf v4, v16, ft1
    vfmul.vf v8, v16, ft2
    vfmul.vf v12, v16, ft3
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vfmacc.vf v12, ft3, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_4__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_4__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v20, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v16
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    vfmacc.vf v8, ft2, v16
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v12, ft3, v16
    vle16.v v16, 0(t2)
    add s10, s10, a4
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft4, v20
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft5, v20
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft6, v20
    vfmacc.vf v12, ft7, v20
    blt t1, s2, cblas_hgemm_rrr_4__inner_loop

cblas_hgemm_rrr_4__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v4, ft1, v16
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v16
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vfmacc.vf v12, ft3, v16
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)

cblas_hgemm_rrr_4__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_4__c_col_loop

cblas_hgemm_rrr_4__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_4__c_row_loop

cblas_hgemm_rrr_4__end_c_row_loop:

cblas_hgemm_rrr_4__exit_gemm:

cblas_hgemm_rrr_4_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_5:

cblas_hgemm_rrr_5__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 4
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_5__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_5__exit_gemm

cblas_hgemm_rrr_5__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_5__exit_gemm

cblas_hgemm_rrr_5__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_5__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_5__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v8, 0(s10)
    add s10, s10, t0
    vfmul.vf v8, v8, fa1
    vle16.v v12, 0(s10)
    vfmul.vf v12, v12, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v4, ft1, v16
    vfmacc.vf v8, ft2, v16
    vfmacc.vf v12, ft3, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_5__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_5__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v20, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v16
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    vfmacc.vf v8, ft2, v16
    flh ft7, 0(s10)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v12, ft3, v16
    vle16.v v16, 0(t2)
    add s10, s10, a4
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft4, v20
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft5, v20
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft6, v20
    vfmacc.vf v12, ft7, v20
    blt t1, s2, cblas_hgemm_rrr_5__inner_loop

cblas_hgemm_rrr_5__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v4, ft1, v16
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v16
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vfmacc.vf v12, ft3, v16
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)

cblas_hgemm_rrr_5__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_5__c_col_loop

cblas_hgemm_rrr_5__end_c_col_loop:
    addi s7, s7, -4
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 2
    add s4, s4, s9
    slli s9, a4, 2
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_5__c_row_loop

cblas_hgemm_rrr_5__end_c_row_loop:

cblas_hgemm_rrr_5__exit_gemm:

cblas_hgemm_rrr_5_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_6:

cblas_hgemm_rrr_6__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_6__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_6__exit_gemm

cblas_hgemm_rrr_6__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_6__exit_gemm

cblas_hgemm_rrr_6__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_6__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_6__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v12, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v12, ft0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmul.vf v4, v12, ft1
    vfmul.vf v8, v12, ft2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v12, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v12
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_6__startup:
    vle16.v v12, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_6__inner_loop:
    vfmacc.vf v0, ft0, v12
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v12
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft2, v12
    vle16.v v12, 0(t2)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft3, v16
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v4, ft4, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v8, ft5, v16
    blt t1, s2, cblas_hgemm_rrr_6__inner_loop

cblas_hgemm_rrr_6__epilog:
    vfmacc.vf v0, ft0, v12
    mv s10, s0
    vfmacc.vf v4, ft1, v12
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v12
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)

cblas_hgemm_rrr_6__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_6__c_col_loop

cblas_hgemm_rrr_6__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_6__c_row_loop

cblas_hgemm_rrr_6__end_c_row_loop:

cblas_hgemm_rrr_6__exit_gemm:

cblas_hgemm_rrr_6_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_7:

cblas_hgemm_rrr_7__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 3
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_7__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_7__exit_gemm

cblas_hgemm_rrr_7__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_7__exit_gemm

cblas_hgemm_rrr_7__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_7__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_7__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v8, 0(s10)
    vfmul.vf v8, v8, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v12, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v12
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v4, ft1, v12
    vfmacc.vf v8, ft2, v12
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_7__startup:
    vle16.v v12, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_7__inner_loop:
    vfmacc.vf v0, ft0, v12
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v4, ft1, v12
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    fmul.h ft3, ft3, fa0
    vfmacc.vf v8, ft2, v12
    vle16.v v12, 0(t2)
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    vfmacc.vf v0, ft3, v16
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v4, ft4, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    vfmacc.vf v8, ft5, v16
    blt t1, s2, cblas_hgemm_rrr_7__inner_loop

cblas_hgemm_rrr_7__epilog:
    vfmacc.vf v0, ft0, v12
    mv s10, s0
    vfmacc.vf v4, ft1, v12
    vse16.v v0, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft2, v12
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vse16.v v8, 0(s10)

cblas_hgemm_rrr_7__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_7__c_col_loop

cblas_hgemm_rrr_7__end_c_col_loop:
    addi s7, s7, -3
    slli s9, a1, 1
    sub s4, s4, s9
    li s9, 3
    mul s9, s9, t0
    add s4, s4, s9
    li s9, 3
    mul s9, s9, a4
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_7__c_row_loop

cblas_hgemm_rrr_7__end_c_row_loop:

cblas_hgemm_rrr_7__exit_gemm:

cblas_hgemm_rrr_7_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_8:

cblas_hgemm_rrr_8__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_8__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_8__exit_gemm

cblas_hgemm_rrr_8__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_8__exit_gemm

cblas_hgemm_rrr_8__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_8__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_8__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmul.vf v0, v4, ft0
    addi t1, t1, 2
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -2
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_8__startup:
    vle16.v v4, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_8__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v4, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v8
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_rrr_8__inner_loop

cblas_hgemm_rrr_8__epilog:
    vfmacc.vf v0, ft0, v4
    vse16.v v0, 0(s0)

cblas_hgemm_rrr_8__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_8__c_col_loop

cblas_hgemm_rrr_8__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_8__c_row_loop

cblas_hgemm_rrr_8__end_c_row_loop:

cblas_hgemm_rrr_8__exit_gemm:

cblas_hgemm_rrr_8_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_9:

cblas_hgemm_rrr_9__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m4
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_9__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_9__exit_gemm

cblas_hgemm_rrr_9__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_9__exit_gemm

cblas_hgemm_rrr_9__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_9__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_9__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v4, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v4
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_9__startup:
    vle16.v v4, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_9__inner_loop:
    vfmacc.vf v0, ft0, v4
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v4, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v8
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_rrr_9__inner_loop

cblas_hgemm_rrr_9__epilog:
    vfmacc.vf v0, ft0, v4
    vse16.v v0, 0(s0)

cblas_hgemm_rrr_9__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_9__c_col_loop

cblas_hgemm_rrr_9__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_9__c_row_loop

cblas_hgemm_rrr_9__end_c_row_loop:

cblas_hgemm_rrr_9__exit_gemm:

cblas_hgemm_rrr_9_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_10:

cblas_hgemm_rrr_10__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m2
    li s9, 8
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_10__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_10__exit_gemm

cblas_hgemm_rrr_10__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_10__exit_gemm

cblas_hgemm_rrr_10__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_10__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_10__epilog
    vsetvli s5, s8, e16,m2
    slli s6, s5, 1
    slli s5, s5, 1
    mv s10, s4
    vle16.v v0, 0(s10)
    add s10, s10, t0
    vfmul.vf v0, v0, fa1
    vle16.v v2, 0(s10)
    add s10, s10, t0
    vfmul.vf v2, v2, fa1
    vle16.v v4, 0(s10)
    add s10, s10, t0
    vfmul.vf v4, v4, fa1
    vle16.v v6, 0(s10)
    add s10, s10, t0
    vfmul.vf v6, v6, fa1
    vle16.v v8, 0(s10)
    add s10, s10, t0
    vfmul.vf v8, v8, fa1
    vle16.v v10, 0(s10)
    add s10, s10, t0
    vfmul.vf v10, v10, fa1
    vle16.v v12, 0(s10)
    add s10, s10, t0
    vfmul.vf v12, v12, fa1
    vle16.v v14, 0(s10)
    vfmul.vf v14, v14, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v16, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v16
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    vfmacc.vf v2, ft1, v16
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    vfmacc.vf v4, ft2, v16
    fmul.h ft7, ft7, fa0
    vfmacc.vf v6, ft3, v16
    vfmacc.vf v8, ft4, v16
    vfmacc.vf v10, ft5, v16
    vfmacc.vf v12, ft6, v16
    vfmacc.vf v14, ft7, v16
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_10__startup:
    vle16.v v16, 0(t2)
    mv s10, t1
    flh ft0, 0(s10)
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft0, ft0, fa0
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_10__inner_loop:
    vfmacc.vf v0, ft0, v16
    vle16.v v18, 0(t2)
    mv s10, t1
    addi t1, t1, 2
    vfmacc.vf v2, ft1, v16
    add t2, t2, a6
    flh ft8, 0(s10)
    add s10, s10, a4
    vfmacc.vf v4, ft2, v16
    flh ft9, 0(s10)
    add s10, s10, a4
    flh ft10, 0(s10)
    vfmacc.vf v6, ft3, v16
    add s10, s10, a4
    flh ft11, 0(s10)
    add s10, s10, a4
    vfmacc.vf v8, ft4, v16
    flh fs0, 0(s10)
    add s10, s10, a4
    flh fs1, 0(s10)
    vfmacc.vf v10, ft5, v16
    add s10, s10, a4
    flh fs2, 0(s10)
    add s10, s10, a4
    vfmacc.vf v12, ft6, v16
    flh fs3, 0(s10)
    fmul.h ft8, ft8, fa0
    fmul.h ft9, ft9, fa0
    vfmacc.vf v14, ft7, v16
    vle16.v v16, 0(t2)
    fmul.h ft10, ft10, fa0
    fmul.h ft11, ft11, fa0
    vfmacc.vf v0, ft8, v18
    fmul.h fs0, fs0, fa0
    fmul.h fs1, fs1, fa0
    fmul.h fs2, fs2, fa0
    vfmacc.vf v2, ft9, v18
    fmul.h fs3, fs3, fa0
    mv s10, t1
    flh ft0, 0(s10)
    vfmacc.vf v4, ft10, v18
    add s10, s10, a4
    flh ft1, 0(s10)
    add s10, s10, a4
    vfmacc.vf v6, ft11, v18
    flh ft2, 0(s10)
    add s10, s10, a4
    flh ft3, 0(s10)
    vfmacc.vf v8, fs0, v18
    add s10, s10, a4
    flh ft4, 0(s10)
    add s10, s10, a4
    vfmacc.vf v10, fs1, v18
    flh ft5, 0(s10)
    add s10, s10, a4
    flh ft6, 0(s10)
    vfmacc.vf v12, fs2, v18
    add s10, s10, a4
    flh ft7, 0(s10)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v14, fs3, v18
    fmul.h ft1, ft1, fa0
    fmul.h ft2, ft2, fa0
    fmul.h ft3, ft3, fa0
    fmul.h ft4, ft4, fa0
    fmul.h ft5, ft5, fa0
    fmul.h ft6, ft6, fa0
    fmul.h ft7, ft7, fa0
    addi t1, t1, 2
    add t2, t2, a6
    blt t1, s2, cblas_hgemm_rrr_10__inner_loop

cblas_hgemm_rrr_10__epilog:
    vfmacc.vf v0, ft0, v16
    mv s10, s0
    vfmacc.vf v2, ft1, v16
    vse16.v v0, 0(s10)
    vfmacc.vf v4, ft2, v16
    add s10, s10, t0
    vfmacc.vf v6, ft3, v16
    vse16.v v2, 0(s10)
    add s10, s10, t0
    vfmacc.vf v8, ft4, v16
    vse16.v v4, 0(s10)
    add s10, s10, t0
    vfmacc.vf v10, ft5, v16
    vse16.v v6, 0(s10)
    vfmacc.vf v12, ft6, v16
    add s10, s10, t0
    vfmacc.vf v14, ft7, v16
    vse16.v v8, 0(s10)
    add s10, s10, t0
    vse16.v v10, 0(s10)
    add s10, s10, t0
    vse16.v v12, 0(s10)
    add s10, s10, t0
    vse16.v v14, 0(s10)

cblas_hgemm_rrr_10__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_10__c_col_loop

cblas_hgemm_rrr_10__end_c_col_loop:
    addi s7, s7, -8
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 3
    add s4, s4, s9
    slli s9, a4, 3
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_10__c_row_loop

cblas_hgemm_rrr_10__end_c_row_loop:

cblas_hgemm_rrr_10__exit_gemm:

cblas_hgemm_rrr_10_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_11:

cblas_hgemm_rrr_11__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s9, -1
    vsetvli s5, s9, e16, m8
    li s9, 1
    remu s9, a0, s9
    sub a0, a0, s9
    li s9, 1
    bltu s9, a2, 1f
    li a2, 0
    j cblas_hgemm_rrr_11__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s7, a0
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li s0, 0
    beqz s7, cblas_hgemm_rrr_11__exit_gemm

cblas_hgemm_rrr_11__c_row_loop:
    mv s8, a1
    beqz s8, cblas_hgemm_rrr_11__exit_gemm

cblas_hgemm_rrr_11__c_col_loop:
    mv t2, s3
    mv t1, s1

cblas_hgemm_rrr_11__prolog:
    slli s2, a2, 1
    add s2, s2, s1
    bge t1, s2, cblas_hgemm_rrr_11__epilog
    vsetvli s5, s8, e16,m8
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v0, 0(s4)
    vfmul.vf v0, v0, fa1
    addi sp, sp, -8
    sd a2, 0(sp)
    addi a2, a2, -1
    andi a2, a2, 1
1:   
    beqz a2, 1f
    vle16.v v8, 0(t2)
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    addi t1, t1, 2
    addi a2, a2, -1
    j 1b
1:   
    ld a2, 0(sp)
    addi sp, sp, 8

cblas_hgemm_rrr_11__startup:
    vle16.v v8, 0(t2)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    add t2, t2, a6
    mv s0, s4

cblas_hgemm_rrr_11__inner_loop:
    vfmacc.vf v0, ft0, v8
    vle16.v v16, 0(t2)
    add t2, t2, a6
    flh ft1, 0(t1)
    vle16.v v8, 0(t2)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v0, ft1, v16
    addi t1, t1, 2
    add t2, t2, a6
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    addi t1, t1, 2
    blt t1, s2, cblas_hgemm_rrr_11__inner_loop

cblas_hgemm_rrr_11__epilog:
    vfmacc.vf v0, ft0, v8
    vse16.v v0, 0(s0)

cblas_hgemm_rrr_11__end_inner_loop:
    slli s9, s6, 0
    add s4, s4, s9
    slli s9, s5, 0
    add s3, s3, s9
    slli s9, s5, 0
    srai s9, s9, 1
    sub s8, s8, s9
    bnez s8, cblas_hgemm_rrr_11__c_col_loop

cblas_hgemm_rrr_11__end_c_col_loop:
    addi s7, s7, -1
    slli s9, a1, 1
    sub s4, s4, s9
    slli s9, t0, 0
    add s4, s4, s9
    slli s9, a4, 0
    add s1, s1, s9
    mv s3, a5
    bnez s7, cblas_hgemm_rrr_11__c_row_loop

cblas_hgemm_rrr_11__end_c_row_loop:

cblas_hgemm_rrr_11__exit_gemm:

cblas_hgemm_rrr_11_jexit:
    j exit_cblas_hgemm_rrr

cblas_hgemm_rrr_12:

cblas_hgemm_rrr_12__enter:
    slli a4, a4, 1
    slli a6, a6, 1
    ld t0, 0(fp)
    slli t0, t0, 1
    li s10, -1
    vsetvli s5, s10, e16 , m4
    li s10, 1
    remu s10, a2, s10
    sub a2, a2, s10
    li s10, 3
    bltu s10, a0, 1f
    li a0, 0
    j cblas_hgemm_rrr_12__exit_gemm
1:   
    ld s7, 8(fp)
    sd a0, 0(s7)
    sd a1, 8(s7)
    sd a2, 16(s7)
    slli s6, s5, 1
    slli s5, s5, 1
    mv s4, a7
    mv s1, a3
    mv s3, a5
    li t2, 0
    mv s9, a2
    beqz s9, cblas_hgemm_rrr_12__exit_gemm
    beqz a1, cblas_hgemm_rrr_12__exit_gemm

cblas_hgemm_rrr_12__loop_kk:
    mv s8, a1

cblas_hgemm_rrr_12__loop_jj:
    mv s0, s4
    mv t1, s1
    bltu s9, a2, cblas_hgemm_rrr_12__post_scale

cblas_hgemm_rrr_12__prolog_scale:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rrr_12__epilog_scale
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v8, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    vfmacc.vf v0, ft0, v8
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    vfmul.vf v4, v4, fa1
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    add s0, s0, t0
    vfmacc.vf v4, ft1, v8
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    vfmul.vf v0, v0, fa1

cblas_hgemm_rrr_12__loop_ii_scale:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmul.vf v4, v4, fa1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vfmacc.vf v4, ft1, v8
    vle16.v v0, 0(s0)
    add s0, s0, t0
    vfmul.vf v0, v0, fa1
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rrr_12__loop_ii_scale

cblas_hgemm_rrr_12__epilog_scale:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    add t1, t1, a4
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10
    j cblas_hgemm_rrr_12__end_loop_ii

cblas_hgemm_rrr_12__post_scale:

cblas_hgemm_rrr_12__prolog:
    mul s2, a0, t0
    add s2, s2, s4
    bge s0, s2, cblas_hgemm_rrr_12__epilog
    vsetvli s5, s8, e16,m4
    slli s6, s5, 1
    slli s5, s5, 1
    vle16.v v8, 0(s3)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle16.v v0, 0(s0)
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    vfmacc.vf v0, ft0, v8
    add t1, t1, a4
    vse16.v v0, 0(s0)
    add s0, s0, t0
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle16.v v4, 0(s0)
    add s0, s0, t0
    flh ft1, 0(t1)
    vle16.v v0, 0(s0)
    fmul.h ft1, ft1, fa0
    vfmacc.vf v4, ft1, v8
    add t1, t1, a4
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4

cblas_hgemm_rrr_12__loop_ii:
    vfmacc.vf v0, ft0, v8
    flh ft1, 0(t1)
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    fmul.h ft1, ft1, fa0
    add t1, t1, a4
    slli s10, t0, 1
    vle16.v v4, 0(s0)
    add s0, s0, t0
    sub s0, s0, s10
    slli s10, t0, 1
    vfmacc.vf v4, ft1, v8
    vse16.v v0, 0(s0)
    add s0, s0, s10
    vle16.v v0, 0(s0)
    add s0, s0, t0
    flh ft0, 0(t1)
    fmul.h ft0, ft0, fa0
    add t1, t1, a4
    blt s0, s2, cblas_hgemm_rrr_12__loop_ii

cblas_hgemm_rrr_12__epilog:
    vfmacc.vf v0, ft0, v8
    slli s10, t0, 1
    sub s0, s0, s10
    vse16.v v4, 0(s0)
    slli s10, t0, 1
    add s0, s0, s10
    add s0, s0, t0
    add t1, t1, a4
    slli s10, t0, 1
    sub s0, s0, s10
    slli s10, t0, 1
    vse16.v v0, 0(s0)
    add s0, s0, s10

cblas_hgemm_rrr_12__end_loop_ii:
    slli s10, s5, 0
    add s3, s3, s10
    slli s10, s5, 0
    add s4, s4, s10
    slli s10, s5, 0
    srai s10, s10, 1
    sub s8, s8, s10
    bnez s8, cblas_hgemm_rrr_12__loop_jj

cblas_hgemm_rrr_12__end_loop_jj:
    li s10, 2
    add s1, s1, s10
    slli s10, a1, 1
    sub s3, s3, s10
    sub s4, s4, s10
    slli s10, a6, 0
    add s3, s3, s10
    addi s9, s9, -1
    bnez s9, cblas_hgemm_rrr_12__loop_kk

cblas_hgemm_rrr_12__end_loop_kk:

cblas_hgemm_rrr_12__exit_gemm:

cblas_hgemm_rrr_12_jexit:
    j exit_cblas_hgemm_rrr

exit_cblas_hgemm_rrr:
    fld fs0, 0(sp)
    fld fs1, 8(sp)
    fld fs2, 16(sp)
    fld fs3, 24(sp)
    fld fs4, 32(sp)
    fld fs5, 40(sp)
    fld fs6, 48(sp)
    fld fs7, 56(sp)
    fld fs8, 64(sp)
    fld fs9, 72(sp)
    fld fs10, 80(sp)
    fld fs11, 88(sp)
    addi sp, sp, 96
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    ld s3, 24(sp)
    ld s4, 32(sp)
    ld s5, 40(sp)
    ld s6, 48(sp)
    ld s7, 56(sp)
    ld s8, 64(sp)
    ld s9, 72(sp)
    ld s10, 80(sp)
    ld s11, 88(sp)
    addi sp, sp, 96
	ret
.size cblas_hgemm_rrr, .-cblas_hgemm_rrr
