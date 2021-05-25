/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

.text
.global cblas_dgemm_ccc
.type cblas_dgemm_ccc, @function

cblas_dgemm_ccc:
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

dispatch_cblas_dgemm_ccc:
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccc_0
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_dgemm_ccc_1
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccc_2
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_dgemm_ccc_3
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccc_4
1:   
    li s1, 32
    blt a0, s1, 1f
    j cblas_dgemm_ccc_5
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_dgemm_ccc_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_dgemm_ccc_7
1:   
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_0:

cblas_dgemm_ccc_0__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_0__exit_gemm

cblas_dgemm_ccc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_0__exit_gemm

cblas_dgemm_ccc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_0__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_0__epilog

cblas_dgemm_ccc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_0__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_0__first_kk_0

cblas_dgemm_ccc_0__first_kk_0:
    vfmul.vf v28, v12, fa6
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v12, fa5
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmul.vf v20, v12, fa4
    add s9, s9, a6
    vfmul.vf v16, v12, fa3
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    j cblas_dgemm_ccc_0__loop_kk_0

cblas_dgemm_ccc_0__first_kk_1:
    vfmul.vf v28, v8, fa2
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v8, fs11
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmul.vf v20, v8, fs10
    add s9, s9, a6
    vfmul.vf v16, v8, fs9

cblas_dgemm_ccc_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa5, v12
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fa4, v12
    add s9, s9, a6
    vfmacc.vf v16, fa3, v12

cblas_dgemm_ccc_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_ccc_0__loop_kk_0

cblas_dgemm_ccc_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_ccc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_0__c_col_loop

cblas_dgemm_ccc_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_0__c_row_loop

cblas_dgemm_ccc_0__end_c_row_loop:

cblas_dgemm_ccc_0__exit_gemm:

cblas_dgemm_ccc_0_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_1:

cblas_dgemm_ccc_1__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_1__exit_gemm

cblas_dgemm_ccc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_1__exit_gemm

cblas_dgemm_ccc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_1__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_1__epilog

cblas_dgemm_ccc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_ccc_1__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_ccc_1__loop_kk_0

cblas_dgemm_ccc_1__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa5, v12
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fa4, v12
    add s9, s9, a6
    vfmacc.vf v16, fa3, v12

cblas_dgemm_ccc_1__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_ccc_1__loop_kk_0

cblas_dgemm_ccc_1__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_ccc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_1__c_col_loop

cblas_dgemm_ccc_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_1__c_row_loop

cblas_dgemm_ccc_1__end_c_row_loop:

cblas_dgemm_ccc_1__exit_gemm:

cblas_dgemm_ccc_1_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_2:

cblas_dgemm_ccc_2__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_2__exit_gemm

cblas_dgemm_ccc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_2__exit_gemm

cblas_dgemm_ccc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_2__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_2__epilog

cblas_dgemm_ccc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_2__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_2__first_kk_0

cblas_dgemm_ccc_2__first_kk_0:
    vfmul.vf v28, v16, fa6
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmul.vf v24, v16, fa5
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v20, v16, fa4
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    j cblas_dgemm_ccc_2__loop_kk_0

cblas_dgemm_ccc_2__first_kk_1:
    vfmul.vf v28, v12, fa3
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmul.vf v24, v12, fa2
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v20, v12, fs11

cblas_dgemm_ccc_2__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fa5, v16
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_ccc_2__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_ccc_2__loop_kk_0

cblas_dgemm_ccc_2__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_ccc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_2__c_col_loop

cblas_dgemm_ccc_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_2__c_row_loop

cblas_dgemm_ccc_2__end_c_row_loop:

cblas_dgemm_ccc_2__exit_gemm:

cblas_dgemm_ccc_2_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_3:

cblas_dgemm_ccc_3__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_3__exit_gemm

cblas_dgemm_ccc_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_3__exit_gemm

cblas_dgemm_ccc_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_3__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_3__epilog

cblas_dgemm_ccc_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_3__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_3__loop_kk_0

cblas_dgemm_ccc_3__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fa5, v16
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_ccc_3__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_ccc_3__loop_kk_0

cblas_dgemm_ccc_3__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_ccc_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_3__c_col_loop

cblas_dgemm_ccc_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_3__c_row_loop

cblas_dgemm_ccc_3__end_c_row_loop:

cblas_dgemm_ccc_3__exit_gemm:

cblas_dgemm_ccc_3_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_4:

cblas_dgemm_ccc_4__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_4__exit_gemm

cblas_dgemm_ccc_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_4__exit_gemm

cblas_dgemm_ccc_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_4__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_4__epilog

cblas_dgemm_ccc_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_4__first_kk_1
1:   
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_4__first_kk_0

cblas_dgemm_ccc_4__first_kk_0:
    vfmul.vf v28, v24, fa6
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    j cblas_dgemm_ccc_4__loop_kk_0

cblas_dgemm_ccc_4__first_kk_1:
    vfmul.vf v28, v20, fa5
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccc_4__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccc_4__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccc_4__loop_kk_0

cblas_dgemm_ccc_4__epilog:
    vfmacc.vf v28, fa6, v24
    vse64.v v28, 0(s8)

cblas_dgemm_ccc_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_4__c_col_loop

cblas_dgemm_ccc_4__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_4__c_row_loop

cblas_dgemm_ccc_4__end_c_row_loop:

cblas_dgemm_ccc_4__exit_gemm:

cblas_dgemm_ccc_4_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_5:

cblas_dgemm_ccc_5__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_5__exit_gemm

cblas_dgemm_ccc_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_5__exit_gemm

cblas_dgemm_ccc_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_5__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_5__epilog

cblas_dgemm_ccc_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle64.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_5__loop_kk_1
1:   
    vle64.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_5__loop_kk_0

cblas_dgemm_ccc_5__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccc_5__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccc_5__loop_kk_0

cblas_dgemm_ccc_5__epilog:
    vfmacc.vf v28, fa6, v24
    vse64.v v28, 0(s8)

cblas_dgemm_ccc_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_5__c_col_loop

cblas_dgemm_ccc_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_5__c_row_loop

cblas_dgemm_ccc_5__end_c_row_loop:

cblas_dgemm_ccc_5__exit_gemm:

cblas_dgemm_ccc_5_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_6:

cblas_dgemm_ccc_6__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m2
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccc_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccc_6__exit_gemm

cblas_dgemm_ccc_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccc_6__exit_gemm

cblas_dgemm_ccc_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccc_6__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccc_6__epilog

cblas_dgemm_ccc_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_6__loop_kk_1
1:   
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v22, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccc_6__loop_kk_0

cblas_dgemm_ccc_6__loop_kk_0:
    vfmacc.vf v30, fa6, v22
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    vfmacc.vf v28, fa5, v22
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    vfmacc.vf v26, fa4, v22
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    vfmacc.vf v24, fa3, v22
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccc_6__loop_kk_1:
    vfmacc.vf v30, fa2, v20
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmacc.vf v28, fs11, v20
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    vfmacc.vf v26, fs10, v20
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fs9, v20
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v22, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccc_6__loop_kk_0

cblas_dgemm_ccc_6__epilog:
    vfmacc.vf v30, fa6, v22
    mv t1, s8
    vfmacc.vf v28, fa5, v22
    vse64.v v30, 0(t1)
    vfmacc.vf v26, fa4, v22
    add t1, t1, s11
    vse64.v v28, 0(t1)
    vfmacc.vf v24, fa3, v22
    add t1, t1, s11
    vse64.v v26, 0(t1)
    add t1, t1, s11
    vse64.v v24, 0(t1)

cblas_dgemm_ccc_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccc_6__c_col_loop

cblas_dgemm_ccc_6__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccc_6__c_row_loop

cblas_dgemm_ccc_6__end_c_row_loop:

cblas_dgemm_ccc_6__exit_gemm:

cblas_dgemm_ccc_6_jexit:
    j exit_cblas_dgemm_ccc

cblas_dgemm_ccc_7:

cblas_dgemm_ccc_7__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_ccc_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_ccc_7__exit_gemm
    beqz a1, cblas_dgemm_ccc_7__exit_gemm

cblas_dgemm_ccc_7__loop_kk:
    mv s0, a1

cblas_dgemm_ccc_7__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_ccc_7__post_scale

cblas_dgemm_ccc_7__prolog_scale:
    slli s6, a0, 3
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_ccc_7__epilog_scale
    vsetvli s3, s0, e64,m4
    mul s2, s3, s11
    slli s3, s3, 3
    vlse64.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse64.v v28, 0(s8), s11
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vsse64.v v28, 0(s8), s11
    addi s8, s8, 8
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse64.v v24, 0(s8), s11
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    addi s8, s8, 8
    addi s10, s10, 8
    vlse64.v v28, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmul.vf v28, v28, fa1
    addi s8, s8, 8
    addi s10, s10, 8
    vfmacc.vf v24, fa5, v20

cblas_dgemm_ccc_7__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    li t1, 16
    sub s8, s8, t1
    vsse64.v v24, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v24, 0(s8), s11
    fld fa5, 0(s10)
    vfmul.vf v24, v24, fa1
    fmul.d fa5, fa5, fa0
    addi s8, s8, 8
    addi s10, s10, 8
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vlse64.v v28, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    addi s10, s10, 8
    vfmul.vf v28, v28, fa1
    blt s8, s6, cblas_dgemm_ccc_7__loop_ii_scale

cblas_dgemm_ccc_7__epilog_scale:
    li t1, 16
    sub s8, s8, t1
    vsse64.v v24, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    addi s8, s8, 8
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    j cblas_dgemm_ccc_7__end_loop_ii

cblas_dgemm_ccc_7__post_scale:

cblas_dgemm_ccc_7__prolog:
    slli s6, a0, 3
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_ccc_7__epilog
    vsetvli s3, s0, e64,m4
    mul s2, s3, s11
    slli s3, s3, 3
    vlse64.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse64.v v28, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vsse64.v v28, 0(s8), s11
    addi s8, s8, 8
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse64.v v24, 0(s8), s11
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    addi s8, s8, 8
    addi s10, s10, 8
    vlse64.v v28, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    addi s10, s10, 8

cblas_dgemm_ccc_7__loop_ii:
    vfmacc.vf v28, fa6, v20
    li t1, 16
    sub s8, s8, t1
    vsse64.v v24, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v24, 0(s8), s11
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    addi s8, s8, 8
    addi s10, s10, 8
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v28, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    addi s10, s10, 8
    blt s8, s6, cblas_dgemm_ccc_7__loop_ii

cblas_dgemm_ccc_7__epilog:
    li t1, 16
    sub s8, s8, t1
    vsse64.v v24, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    addi s8, s8, 8
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1

cblas_dgemm_ccc_7__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s2, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_ccc_7__loop_jj

cblas_dgemm_ccc_7__end_loop_jj:
    li t1, 1
    mul t1, t1, a4
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    mul t1, a1, s11
    sub s4, s4, t1
    li t1, 8
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_dgemm_ccc_7__loop_kk

cblas_dgemm_ccc_7__end_loop_kk:

cblas_dgemm_ccc_7__exit_gemm:

cblas_dgemm_ccc_7_jexit:
    j exit_cblas_dgemm_ccc

exit_cblas_dgemm_ccc:
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
.size cblas_dgemm_ccc, .-cblas_dgemm_ccc

.text
.global cblas_dgemm_crr
.type cblas_dgemm_crr, @function

cblas_dgemm_crr:
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

dispatch_cblas_dgemm_crr:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_crr_0
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_dgemm_crr_1
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_crr_2
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_dgemm_crr_3
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_crr_4
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_dgemm_crr_5
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_crr_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_dgemm_crr_7
1:   
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_0:

cblas_dgemm_crr_0__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_0__exit_gemm

cblas_dgemm_crr_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_0__exit_gemm

cblas_dgemm_crr_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_0__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_0__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_0__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_0__first_kk_0

cblas_dgemm_crr_0__first_kk_0:
    vfmul.vf v28, v12, fa6
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmul.vf v24, v12, fa5
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v12, fa4
    vfmul.vf v16, v12, fa3
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fs11, v8
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs10, v8
    vfmacc.vf v16, fs9, v8
    j cblas_dgemm_crr_0__loop_kk_0

cblas_dgemm_crr_0__first_kk_1:
    vfmul.vf v28, v8, fa2
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmul.vf v24, v8, fs11
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v8, fs10
    vfmul.vf v16, v8, fs9

cblas_dgemm_crr_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmacc.vf v24, fa5, v12
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fa4, v12
    vfmacc.vf v16, fa3, v12

cblas_dgemm_crr_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fs11, v8
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs10, v8
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_crr_0__loop_kk_0

cblas_dgemm_crr_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_crr_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_0__c_col_loop

cblas_dgemm_crr_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 32
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_0__c_row_loop

cblas_dgemm_crr_0__end_c_row_loop:

cblas_dgemm_crr_0__exit_gemm:

cblas_dgemm_crr_0_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_1:

cblas_dgemm_crr_1__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_1__exit_gemm

cblas_dgemm_crr_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_1__exit_gemm

cblas_dgemm_crr_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_1__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_1__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    vfmul.vf v20, v20, fa1
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_crr_1__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vfmul.vf v20, v20, fa1
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_crr_1__loop_kk_0

cblas_dgemm_crr_1__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmacc.vf v24, fa5, v12
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fa4, v12
    vfmacc.vf v16, fa3, v12

cblas_dgemm_crr_1__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fs11, v8
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs10, v8
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_crr_1__loop_kk_0

cblas_dgemm_crr_1__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_crr_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_1__c_col_loop

cblas_dgemm_crr_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 32
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_1__c_row_loop

cblas_dgemm_crr_1__end_c_row_loop:

cblas_dgemm_crr_1__exit_gemm:

cblas_dgemm_crr_1_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_2:

cblas_dgemm_crr_2__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_2__exit_gemm

cblas_dgemm_crr_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_2__exit_gemm

cblas_dgemm_crr_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_2__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_2__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_2__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_2__first_kk_0

cblas_dgemm_crr_2__first_kk_0:
    vfmul.vf v28, v16, fa6
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmul.vf v24, v16, fa5
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v16, fa4
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vfmacc.vf v24, fa2, v12
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    j cblas_dgemm_crr_2__loop_kk_0

cblas_dgemm_crr_2__first_kk_1:
    vfmul.vf v28, v12, fa3
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vfmul.vf v24, v12, fa2
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v12, fs11

cblas_dgemm_crr_2__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmacc.vf v24, fa5, v16
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_crr_2__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vfmacc.vf v24, fa2, v12
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_crr_2__loop_kk_0

cblas_dgemm_crr_2__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_crr_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_2__c_col_loop

cblas_dgemm_crr_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 24
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_2__c_row_loop

cblas_dgemm_crr_2__end_c_row_loop:

cblas_dgemm_crr_2__exit_gemm:

cblas_dgemm_crr_2_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_3:

cblas_dgemm_crr_3__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_3__exit_gemm

cblas_dgemm_crr_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_3__exit_gemm

cblas_dgemm_crr_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_3__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_3__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    vfmul.vf v24, v24, fa1
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v20, fa1
    mv s8, s4
    j cblas_dgemm_crr_3__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    vfmul.vf v24, v24, fa1
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v20, v20, fa1
    mv s8, s4
    j cblas_dgemm_crr_3__loop_kk_0

cblas_dgemm_crr_3__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vfmacc.vf v24, fa5, v16
    vle64.v v12, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_crr_3__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vfmacc.vf v24, fa2, v12
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_crr_3__loop_kk_0

cblas_dgemm_crr_3__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_crr_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_3__c_col_loop

cblas_dgemm_crr_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 24
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_3__c_row_loop

cblas_dgemm_crr_3__end_c_row_loop:

cblas_dgemm_crr_3__exit_gemm:

cblas_dgemm_crr_3_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_4:

cblas_dgemm_crr_4__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_4__exit_gemm

cblas_dgemm_crr_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_4__exit_gemm

cblas_dgemm_crr_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_4__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_4__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_4__first_kk_1
1:   
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_4__first_kk_0

cblas_dgemm_crr_4__first_kk_0:
    vfmul.vf v28, v24, fa6
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    j cblas_dgemm_crr_4__loop_kk_0

cblas_dgemm_crr_4__first_kk_1:
    vfmul.vf v28, v20, fa5
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crr_4__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crr_4__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crr_4__loop_kk_0

cblas_dgemm_crr_4__epilog:
    vfmacc.vf v28, fa6, v24
    vse64.v v28, 0(s8)

cblas_dgemm_crr_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_4__c_col_loop

cblas_dgemm_crr_4__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 8
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_4__c_row_loop

cblas_dgemm_crr_4__end_c_row_loop:

cblas_dgemm_crr_4__exit_gemm:

cblas_dgemm_crr_4_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_5:

cblas_dgemm_crr_5__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_5__exit_gemm

cblas_dgemm_crr_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_5__exit_gemm

cblas_dgemm_crr_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_5__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_5__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle64.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_5__loop_kk_1
1:   
    vle64.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_5__loop_kk_0

cblas_dgemm_crr_5__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crr_5__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crr_5__loop_kk_0

cblas_dgemm_crr_5__epilog:
    vfmacc.vf v28, fa6, v24
    vse64.v v28, 0(s8)

cblas_dgemm_crr_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_5__c_col_loop

cblas_dgemm_crr_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 8
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_5__c_row_loop

cblas_dgemm_crr_5__end_c_row_loop:

cblas_dgemm_crr_5__exit_gemm:

cblas_dgemm_crr_5_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_6:

cblas_dgemm_crr_6__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crr_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crr_6__exit_gemm

cblas_dgemm_crr_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crr_6__exit_gemm

cblas_dgemm_crr_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crr_6__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crr_6__epilog
    vsetvli s3, s0, e64,m8
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_crr_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle64.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_6__loop_kk_1
1:   
    vle64.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crr_6__loop_kk_0

cblas_dgemm_crr_6__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crr_6__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crr_6__loop_kk_0

cblas_dgemm_crr_6__epilog:
    vfmacc.vf v24, fa6, v16
    vse64.v v24, 0(s8)

cblas_dgemm_crr_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crr_6__c_col_loop

cblas_dgemm_crr_6__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 8
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crr_6__c_row_loop

cblas_dgemm_crr_6__end_c_row_loop:

cblas_dgemm_crr_6__exit_gemm:

cblas_dgemm_crr_6_jexit:
    j exit_cblas_dgemm_crr

cblas_dgemm_crr_7:

cblas_dgemm_crr_7__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_crr_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_crr_7__exit_gemm
    beqz a1, cblas_dgemm_crr_7__exit_gemm

cblas_dgemm_crr_7__loop_kk:
    mv s0, a1

cblas_dgemm_crr_7__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_crr_7__post_scale

cblas_dgemm_crr_7__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_crr_7__epilog_scale
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vle64.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    addi s10, s10, 8
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmul.vf v28, v28, fa1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v24, fa5, v20

cblas_dgemm_crr_7__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    vfmul.vf v24, v24, fa1
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    addi s10, s10, 8
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8
    vfmul.vf v28, v28, fa1
    blt s8, s6, cblas_dgemm_crr_7__loop_ii_scale

cblas_dgemm_crr_7__epilog_scale:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    j cblas_dgemm_crr_7__end_loop_ii

cblas_dgemm_crr_7__post_scale:

cblas_dgemm_crr_7__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_crr_7__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vle64.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    addi s10, s10, 8
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8

cblas_dgemm_crr_7__loop_ii:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    addi s10, s10, 8
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8
    blt s8, s6, cblas_dgemm_crr_7__loop_ii

cblas_dgemm_crr_7__epilog:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1

cblas_dgemm_crr_7__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_crr_7__loop_jj

cblas_dgemm_crr_7__end_loop_jj:
    li t1, 1
    mul t1, t1, a4
    add s7, s7, t1
    slli t1, a1, 3
    sub s5, s5, t1
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_dgemm_crr_7__loop_kk

cblas_dgemm_crr_7__end_loop_kk:

cblas_dgemm_crr_7__exit_gemm:

cblas_dgemm_crr_7_jexit:
    j exit_cblas_dgemm_crr

exit_cblas_dgemm_crr:
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
.size cblas_dgemm_crr, .-cblas_dgemm_crr

.text
.global cblas_dgemm_rcr
.type cblas_dgemm_rcr, @function

cblas_dgemm_rcr:
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

dispatch_cblas_dgemm_rcr:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa0
    beqz s1, 1f
    li s1, 1
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_rcr_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_rcr_1
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa0
    beqz s1, 1f
    j cblas_dgemm_rcr_2
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_dgemm_rcr_3
1:   
    j exit_cblas_dgemm_rcr

cblas_dgemm_rcr_0:

cblas_dgemm_rcr_0__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcr_0__exit_gemm
    beqz a1, cblas_dgemm_rcr_0__exit_gemm

cblas_dgemm_rcr_0__loop_kk:
    mv s0, a1

cblas_dgemm_rcr_0__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_dgemm_rcr_0__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_0__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    vfmacc.vf v20, fs8, v12
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v20, fs7, v8
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    vfmacc.vf v16, fs4, v12
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    vfmacc.vf v20, fs6, v4
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_0__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fs11, v8
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    vfmacc.vf v28, fa4, v4
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    vfmacc.vf v24, fs10, v4
    fld fa4, 16(t0)
    add s10, s10, a4
    vfmacc.vf v28, fa3, v0
    fld fa3, 24(t0)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    add s10, s10, a4
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    vle64.v v24, 0(s8)
    vfmacc.vf v16, fs4, v12
    fld fs9, 24(t0)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_dgemm_rcr_0__loop_ii

cblas_dgemm_rcr_0__epilog:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcr_0__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcr_0__loop_jj

cblas_dgemm_rcr_0__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcr_0__loop_kk

cblas_dgemm_rcr_0__end_loop_kk:

cblas_dgemm_rcr_0__exit_gemm:

cblas_dgemm_rcr_0_jexit:
    j exit_cblas_dgemm_rcr

cblas_dgemm_rcr_1:

cblas_dgemm_rcr_1__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcr_1__exit_gemm
    beqz a1, cblas_dgemm_rcr_1__exit_gemm

cblas_dgemm_rcr_1__loop_kk:
    mv s0, a1

cblas_dgemm_rcr_1__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_dgemm_rcr_1__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_1__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    vfmacc.vf v16, fs4, v12
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    vfmacc.vf v20, fs6, v4
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    vfmacc.vf v16, fs3, v8
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    vfmacc.vf v20, fs5, v0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    vfmacc.vf v16, fs2, v4
    add s10, s10, a4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_1__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    vfmacc.vf v24, fs11, v8
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v28, fa4, v4
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v24, fs10, v4
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    vfmacc.vf v20, fs7, v8
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_dgemm_rcr_1__loop_ii

cblas_dgemm_rcr_1__epilog:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcr_1__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcr_1__loop_jj

cblas_dgemm_rcr_1__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcr_1__loop_kk

cblas_dgemm_rcr_1__end_loop_kk:

cblas_dgemm_rcr_1__exit_gemm:

cblas_dgemm_rcr_1_jexit:
    j exit_cblas_dgemm_rcr

cblas_dgemm_rcr_2:

cblas_dgemm_rcr_2__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcr_2__exit_gemm
    beqz a1, cblas_dgemm_rcr_2__exit_gemm

cblas_dgemm_rcr_2__loop_kk:
    mv s0, a1

cblas_dgemm_rcr_2__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rcr_2__post_scale

cblas_dgemm_rcr_2__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_2__epilog_scale
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    vfmul.vf v20, v20, fa1
    mv t0, s10
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    vfmul.vf v16, v16, fa1
    mv t0, s10
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs8, v12
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    add s8, s8, s11
    vfmul.vf v28, v28, fa1
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    vfmul.vf v24, v24, fa1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_2__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fs11, v8
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    vfmacc.vf v28, fa4, v4
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    vfmacc.vf v24, fs10, v4
    fld fa4, 16(t0)
    add s10, s10, a4
    vfmacc.vf v28, fa3, v0
    fld fa3, 24(t0)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    add s10, s10, a4
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmul.vf v20, v20, fa1
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    vle64.v v24, 0(s8)
    vfmul.vf v16, v16, fa1
    fld fs9, 24(t0)
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs7, v8
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_dgemm_rcr_2__loop_ii_scale

cblas_dgemm_rcr_2__epilog_scale:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_dgemm_rcr_2__end_loop_ii

cblas_dgemm_rcr_2__post_scale:

cblas_dgemm_rcr_2__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_2__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    vfmacc.vf v20, fs8, v12
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v20, fs7, v8
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    vfmacc.vf v16, fs4, v12
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    vfmacc.vf v20, fs6, v4
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_2__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fs11, v8
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    vfmacc.vf v28, fa4, v4
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    vfmacc.vf v24, fs10, v4
    fld fa4, 16(t0)
    add s10, s10, a4
    vfmacc.vf v28, fa3, v0
    fld fa3, 24(t0)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    add s10, s10, a4
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    vle64.v v24, 0(s8)
    vfmacc.vf v16, fs4, v12
    fld fs9, 24(t0)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_dgemm_rcr_2__loop_ii

cblas_dgemm_rcr_2__epilog:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcr_2__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcr_2__loop_jj

cblas_dgemm_rcr_2__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcr_2__loop_kk

cblas_dgemm_rcr_2__end_loop_kk:

cblas_dgemm_rcr_2__exit_gemm:

cblas_dgemm_rcr_2_jexit:
    j exit_cblas_dgemm_rcr

cblas_dgemm_rcr_3:

cblas_dgemm_rcr_3__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcr_3__exit_gemm
    beqz a1, cblas_dgemm_rcr_3__exit_gemm

cblas_dgemm_rcr_3__loop_kk:
    mv s0, a1

cblas_dgemm_rcr_3__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rcr_3__post_scale

cblas_dgemm_rcr_3__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_3__epilog_scale
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    vfmul.vf v20, v20, fa1
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    fld fs5, 24(t0)
    vfmacc.vf v20, fs8, v12
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    vfmul.vf v16, v16, fa1
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    vfmul.vf v28, v28, fa1
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    vfmul.vf v24, v24, fa1
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    vfmacc.vf v20, fs6, v4
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_3__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    vfmacc.vf v24, fs11, v8
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v28, fa4, v4
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v24, fs10, v4
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmul.vf v20, v20, fa1
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v16, v16, fa1
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    vfmacc.vf v20, fs8, v12
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs7, v8
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_dgemm_rcr_3__loop_ii_scale

cblas_dgemm_rcr_3__epilog_scale:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_dgemm_rcr_3__end_loop_ii

cblas_dgemm_rcr_3__post_scale:

cblas_dgemm_rcr_3__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcr_3__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    mv t0, s5
    vlse64.v v12, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v8, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v4, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v20, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    vfmacc.vf v16, fs4, v12
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    vfmacc.vf v20, fs6, v4
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    vfmacc.vf v16, fs3, v8
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    vfmacc.vf v20, fs5, v0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    vfmacc.vf v16, fs2, v4
    add s10, s10, a4
    vfmacc.vf v16, fs1, v0

cblas_dgemm_rcr_3__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v20, 0(s8)
    vfmacc.vf v28, fa5, v8
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    vfmacc.vf v24, fs11, v8
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v16, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v28, fa4, v4
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v24, fs10, v4
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    fld fa6, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fs9, v0
    vse64.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    vse64.v v24, 0(s8)
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    vfmacc.vf v20, fs7, v8
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_dgemm_rcr_3__loop_ii

cblas_dgemm_rcr_3__epilog:
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vfmacc.vf v24, fa2, v12
    vfmacc.vf v24, fs11, v8
    vfmacc.vf v24, fs10, v4
    vfmacc.vf v24, fs9, v0
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcr_3__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcr_3__loop_jj

cblas_dgemm_rcr_3__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcr_3__loop_kk

cblas_dgemm_rcr_3__end_loop_kk:

cblas_dgemm_rcr_3__exit_gemm:

cblas_dgemm_rcr_3_jexit:
    j exit_cblas_dgemm_rcr

exit_cblas_dgemm_rcr:
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
.size cblas_dgemm_rcr, .-cblas_dgemm_rcr

.text
.global cblas_dgemm_rrc
.type cblas_dgemm_rrc, @function

cblas_dgemm_rrc:
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

dispatch_cblas_dgemm_rrc:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_rrc_0
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_rrc_1
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_rrc_2
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_dgemm_rrc_3
1:   
    j exit_cblas_dgemm_rrc

cblas_dgemm_rrc_0:

cblas_dgemm_rrc_0__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrc_0__exit_gemm

cblas_dgemm_rrc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrc_0__exit_gemm

cblas_dgemm_rrc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrc_0__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrc_0__epilog
    vsetvli s3, s0, e64,m4
    mul s2, s3, s11
    slli s3, s3, 3

cblas_dgemm_rrc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    addi t1, t1, 8
    vlse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v20, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v16, 0(t1), s11
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_rrc_0__loop_kk_1
1:   
    mv t1, s4
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    addi t1, t1, 8
    vlse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v20, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v16, 0(t1), s11
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_rrc_0__loop_kk_0

cblas_dgemm_rrc_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa5, v12
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fa4, v12
    add s9, s9, a6
    vfmacc.vf v16, fa3, v12

cblas_dgemm_rrc_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_rrc_0__loop_kk_0

cblas_dgemm_rrc_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vsse64.v v28, 0(t1), s11
    addi t1, t1, 8
    vfmacc.vf v20, fa4, v12
    vsse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vfmacc.vf v16, fa3, v12
    vsse64.v v20, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v16, 0(t1), s11

cblas_dgemm_rrc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrc_0__c_col_loop

cblas_dgemm_rrc_0__end_c_col_loop:
    addi s1, s1, -4
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 32
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrc_0__c_row_loop

cblas_dgemm_rrc_0__end_c_row_loop:

cblas_dgemm_rrc_0__exit_gemm:

cblas_dgemm_rrc_0_jexit:
    j exit_cblas_dgemm_rrc

cblas_dgemm_rrc_1:

cblas_dgemm_rrc_1__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrc_1__exit_gemm

cblas_dgemm_rrc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrc_1__exit_gemm

cblas_dgemm_rrc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrc_1__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrc_1__epilog
    vsetvli s3, s0, e64,m4
    mul s2, s3, s11
    slli s3, s3, 3

cblas_dgemm_rrc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    addi t1, t1, 8
    vlse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v20, 0(t1), s11
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrc_1__loop_kk_1
1:   
    mv t1, s4
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    addi t1, t1, 8
    vlse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vlse64.v v20, 0(t1), s11
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrc_1__loop_kk_0

cblas_dgemm_rrc_1__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fa5, v16
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_rrc_1__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_rrc_1__loop_kk_0

cblas_dgemm_rrc_1__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vsse64.v v28, 0(t1), s11
    addi t1, t1, 8
    vfmacc.vf v20, fa4, v16
    vsse64.v v24, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v20, 0(t1), s11

cblas_dgemm_rrc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrc_1__c_col_loop

cblas_dgemm_rrc_1__end_c_col_loop:
    addi s1, s1, -3
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 24
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrc_1__c_row_loop

cblas_dgemm_rrc_1__end_c_row_loop:

cblas_dgemm_rrc_1__exit_gemm:

cblas_dgemm_rrc_1_jexit:
    j exit_cblas_dgemm_rrc

cblas_dgemm_rrc_2:

cblas_dgemm_rrc_2__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrc_2__exit_gemm

cblas_dgemm_rrc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrc_2__exit_gemm

cblas_dgemm_rrc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrc_2__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrc_2__epilog
    vsetvli s3, s0, e64,m4
    mul s2, s3, s11
    slli s3, s3, 3

cblas_dgemm_rrc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vlse64.v v28, 0(s4), s11
    vfmul.vf v28, v28, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrc_2__loop_kk_1
1:   
    vlse64.v v28, 0(s4), s11
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrc_2__loop_kk_0

cblas_dgemm_rrc_2__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v20, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_rrc_2__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v24, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_rrc_2__loop_kk_0

cblas_dgemm_rrc_2__epilog:
    vfmacc.vf v28, fa6, v24
    vsse64.v v28, 0(s8), s11

cblas_dgemm_rrc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrc_2__c_col_loop

cblas_dgemm_rrc_2__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 8
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrc_2__c_row_loop

cblas_dgemm_rrc_2__end_c_row_loop:

cblas_dgemm_rrc_2__exit_gemm:

cblas_dgemm_rrc_2_jexit:
    j exit_cblas_dgemm_rrc

cblas_dgemm_rrc_3:

cblas_dgemm_rrc_3__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m2
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rrc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rrc_3__exit_gemm
    beqz a1, cblas_dgemm_rrc_3__exit_gemm

cblas_dgemm_rrc_3__loop_kk:
    mv s0, a1

cblas_dgemm_rrc_3__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rrc_3__post_scale

cblas_dgemm_rrc_3__prolog_scale:
    slli s6, a0, 3
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rrc_3__epilog_scale
    vsetvli s3, s0, e64,m2
    mul s2, s3, s11
    slli s3, s3, 3
    vle64.v v26, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse64.v v30, 0(s8), s11
    vfmul.vf v30, v30, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v30, fa6, v26
    vsse64.v v30, 0(s8), s11
    addi s8, s8, 8
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse64.v v28, 0(s8), s11
    vfmul.vf v28, v28, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    addi s8, s8, 8
    add s10, s10, a4
    vlse64.v v30, 0(s8), s11
    vfmul.vf v30, v30, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    vfmacc.vf v28, fa5, v26
    add s10, s10, a4

cblas_dgemm_rrc_3__loop_ii_scale:
    vfmacc.vf v30, fa6, v26
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v28, 0(s8), s11
    vfmul.vf v28, v28, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    addi s8, s8, 8
    add s10, s10, a4
    li t1, 16
    sub s8, s8, t1
    vfmacc.vf v28, fa5, v26
    vsse64.v v30, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v30, 0(s8), s11
    vfmul.vf v30, v30, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rrc_3__loop_ii_scale

cblas_dgemm_rrc_3__epilog_scale:
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    addi s8, s8, 8
    add s10, s10, a4
    vfmacc.vf v30, fa6, v26
    li t1, 16
    sub s8, s8, t1
    vsse64.v v30, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    j cblas_dgemm_rrc_3__end_loop_ii

cblas_dgemm_rrc_3__post_scale:

cblas_dgemm_rrc_3__prolog:
    slli s6, a0, 3
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rrc_3__epilog
    vsetvli s3, s0, e64,m2
    mul s2, s3, s11
    slli s3, s3, 3
    vle64.v v26, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse64.v v30, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v30, fa6, v26
    vsse64.v v30, 0(s8), s11
    addi s8, s8, 8
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse64.v v28, 0(s8), s11
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v28, fa5, v26
    addi s8, s8, 8
    add s10, s10, a4
    vlse64.v v30, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    add s10, s10, a4

cblas_dgemm_rrc_3__loop_ii:
    vfmacc.vf v30, fa6, v26
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v28, 0(s8), s11
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v28, fa5, v26
    addi s8, s8, 8
    add s10, s10, a4
    li t1, 16
    sub s8, s8, t1
    vsse64.v v30, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    vlse64.v v30, 0(s8), s11
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    addi s8, s8, 8
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rrc_3__loop_ii

cblas_dgemm_rrc_3__epilog:
    li t1, 16
    sub s8, s8, t1
    vsse64.v v28, 0(s8), s11
    li t1, 16
    add s8, s8, t1
    addi s8, s8, 8
    add s10, s10, a4
    vfmacc.vf v30, fa6, v26
    li t1, 16
    sub s8, s8, t1
    vsse64.v v30, 0(s8), s11
    li t1, 16
    add s8, s8, t1

cblas_dgemm_rrc_3__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s2, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rrc_3__loop_jj

cblas_dgemm_rrc_3__end_loop_jj:
    li t1, 8
    add s7, s7, t1
    slli t1, a1, 3
    sub s5, s5, t1
    mul t1, a1, s11
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_dgemm_rrc_3__loop_kk

cblas_dgemm_rrc_3__end_loop_kk:

cblas_dgemm_rrc_3__exit_gemm:

cblas_dgemm_rrc_3_jexit:
    j exit_cblas_dgemm_rrc

exit_cblas_dgemm_rrc:
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
.size cblas_dgemm_rrc, .-cblas_dgemm_rrc

.text
.global cblas_dgemm_ccr
.type cblas_dgemm_ccr, @function

cblas_dgemm_ccr:
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

dispatch_cblas_dgemm_ccr:
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccr_0
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_dgemm_ccr_1
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccr_2
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_dgemm_ccr_3
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_ccr_4
1:   
    li s1, 32
    blt a0, s1, 1f
    j cblas_dgemm_ccr_5
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_dgemm_ccr_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_dgemm_ccr_7
1:   
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_0:

cblas_dgemm_ccr_0__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_0__exit_gemm

cblas_dgemm_ccr_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_0__exit_gemm

cblas_dgemm_ccr_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_0__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_0__epilog

cblas_dgemm_ccr_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_0__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_0__first_kk_0

cblas_dgemm_ccr_0__first_kk_0:
    vfmul.vf v31, v27, fa6
    mv t1, s10
    vfmul.vf v30, v27, fa5
    fld fa2, 0(t1)
    vfmul.vf v29, v27, fa4
    add t1, t1, a4
    vfmul.vf v28, v27, fa3
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v31, fa2, v26
    mv t1, s10
    vfmacc.vf v30, fs11, v26
    fld fa6, 0(t1)
    vfmacc.vf v29, fs10, v26
    add t1, t1, a4
    vfmacc.vf v28, fs9, v26
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    j cblas_dgemm_ccr_0__loop_kk_0

cblas_dgemm_ccr_0__first_kk_1:
    vfmul.vf v31, v26, fa2
    mv t1, s10
    vfmul.vf v30, v26, fs11
    fld fa6, 0(t1)
    vfmul.vf v29, v26, fs10
    add t1, t1, a4
    vfmul.vf v28, v26, fs9
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_0__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    mv t1, s10
    vfmacc.vf v30, fa5, v27
    fld fa2, 0(t1)
    vfmacc.vf v29, fa4, v27
    add t1, t1, a4
    vfmacc.vf v28, fa3, v27
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_0__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    mv t1, s10
    vfmacc.vf v30, fs11, v26
    fld fa6, 0(t1)
    vfmacc.vf v29, fs10, v26
    add t1, t1, a4
    vfmacc.vf v28, fs9, v26
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_0__loop_kk_0

cblas_dgemm_ccr_0__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vsse64.v v31, 0(t1), s11
    vfmacc.vf v28, fa3, v27
    addi t1, t1, 8
    vsse64.v v30, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v29, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v28, 0(t1), s11

cblas_dgemm_ccr_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_0__c_col_loop

cblas_dgemm_ccr_0__end_c_col_loop:
    addi s1, s1, -4
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 32
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_0__c_row_loop

cblas_dgemm_ccr_0__end_c_row_loop:

cblas_dgemm_ccr_0__exit_gemm:

cblas_dgemm_ccr_0_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_1:

cblas_dgemm_ccr_1__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_1__exit_gemm

cblas_dgemm_ccr_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_1__exit_gemm

cblas_dgemm_ccr_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_1__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_1__epilog

cblas_dgemm_ccr_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    addi t1, t1, 8
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_1__loop_kk_1
1:   
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    addi t1, t1, 8
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_1__loop_kk_0

cblas_dgemm_ccr_1__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    mv t1, s10
    vfmacc.vf v30, fa5, v27
    fld fa2, 0(t1)
    vfmacc.vf v29, fa4, v27
    add t1, t1, a4
    vfmacc.vf v28, fa3, v27
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_1__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    mv t1, s10
    vfmacc.vf v30, fs11, v26
    fld fa6, 0(t1)
    vfmacc.vf v29, fs10, v26
    add t1, t1, a4
    vfmacc.vf v28, fs9, v26
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_1__loop_kk_0

cblas_dgemm_ccr_1__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vsse64.v v31, 0(t1), s11
    vfmacc.vf v28, fa3, v27
    addi t1, t1, 8
    vsse64.v v30, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v29, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v28, 0(t1), s11

cblas_dgemm_ccr_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_1__c_col_loop

cblas_dgemm_ccr_1__end_c_col_loop:
    addi s1, s1, -4
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 32
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_1__c_row_loop

cblas_dgemm_ccr_1__end_c_row_loop:

cblas_dgemm_ccr_1__exit_gemm:

cblas_dgemm_ccr_1_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_2:

cblas_dgemm_ccr_2__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_2__exit_gemm

cblas_dgemm_ccr_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_2__exit_gemm

cblas_dgemm_ccr_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_2__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_2__epilog

cblas_dgemm_ccr_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_2__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_2__first_kk_0

cblas_dgemm_ccr_2__first_kk_0:
    vfmul.vf v31, v28, fa6
    mv t1, s10
    vfmul.vf v30, v28, fa5
    fld fa3, 0(t1)
    vfmul.vf v29, v28, fa4
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v31, fa3, v27
    mv t1, s10
    vfmacc.vf v30, fa2, v27
    fld fa6, 0(t1)
    vfmacc.vf v29, fs11, v27
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    j cblas_dgemm_ccr_2__loop_kk_0

cblas_dgemm_ccr_2__first_kk_1:
    vfmul.vf v31, v27, fa3
    mv t1, s10
    vfmul.vf v30, v27, fa2
    fld fa6, 0(t1)
    vfmul.vf v29, v27, fs11
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_2__loop_kk_0:
    vfmacc.vf v31, fa6, v28
    mv t1, s10
    vfmacc.vf v30, fa5, v28
    fld fa3, 0(t1)
    vfmacc.vf v29, fa4, v28
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_2__loop_kk_1:
    vfmacc.vf v31, fa3, v27
    mv t1, s10
    vfmacc.vf v30, fa2, v27
    fld fa6, 0(t1)
    vfmacc.vf v29, fs11, v27
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_2__loop_kk_0

cblas_dgemm_ccr_2__epilog:
    vfmacc.vf v31, fa6, v28
    mv t1, s8
    vfmacc.vf v30, fa5, v28
    vfmacc.vf v29, fa4, v28
    vsse64.v v31, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v30, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v29, 0(t1), s11

cblas_dgemm_ccr_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_2__c_col_loop

cblas_dgemm_ccr_2__end_c_col_loop:
    addi s1, s1, -3
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 24
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_2__c_row_loop

cblas_dgemm_ccr_2__end_c_row_loop:

cblas_dgemm_ccr_2__exit_gemm:

cblas_dgemm_ccr_2_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_3:

cblas_dgemm_ccr_3__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_3__exit_gemm

cblas_dgemm_ccr_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_3__exit_gemm

cblas_dgemm_ccr_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_3__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_3__epilog

cblas_dgemm_ccr_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_3__loop_kk_1
1:   
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_3__loop_kk_0

cblas_dgemm_ccr_3__loop_kk_0:
    vfmacc.vf v31, fa6, v28
    mv t1, s10
    vfmacc.vf v30, fa5, v28
    fld fa3, 0(t1)
    vfmacc.vf v29, fa4, v28
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_3__loop_kk_1:
    vfmacc.vf v31, fa3, v27
    mv t1, s10
    vfmacc.vf v30, fa2, v27
    fld fa6, 0(t1)
    vfmacc.vf v29, fs11, v27
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v28, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_3__loop_kk_0

cblas_dgemm_ccr_3__epilog:
    vfmacc.vf v31, fa6, v28
    mv t1, s8
    vfmacc.vf v30, fa5, v28
    vfmacc.vf v29, fa4, v28
    vsse64.v v31, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v30, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v29, 0(t1), s11

cblas_dgemm_ccr_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_3__c_col_loop

cblas_dgemm_ccr_3__end_c_col_loop:
    addi s1, s1, -3
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 24
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_3__c_row_loop

cblas_dgemm_ccr_3__end_c_row_loop:

cblas_dgemm_ccr_3__exit_gemm:

cblas_dgemm_ccr_3_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_4:

cblas_dgemm_ccr_4__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_4__exit_gemm

cblas_dgemm_ccr_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_4__exit_gemm

cblas_dgemm_ccr_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_4__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_4__epilog

cblas_dgemm_ccr_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v29, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_4__first_kk_1
1:   
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_4__first_kk_0

cblas_dgemm_ccr_4__first_kk_0:
    vfmul.vf v31, v30, fa6
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v29, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v31, fa5, v29
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    j cblas_dgemm_ccr_4__loop_kk_0

cblas_dgemm_ccr_4__first_kk_1:
    vfmul.vf v31, v29, fa5
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_4__loop_kk_0:
    vfmacc.vf v31, fa6, v30
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v29, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_4__loop_kk_1:
    vfmacc.vf v31, fa5, v29
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_4__loop_kk_0

cblas_dgemm_ccr_4__epilog:
    vfmacc.vf v31, fa6, v30
    vsse64.v v31, 0(s8), s11

cblas_dgemm_ccr_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_4__c_col_loop

cblas_dgemm_ccr_4__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 8
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_4__c_row_loop

cblas_dgemm_ccr_4__end_c_row_loop:

cblas_dgemm_ccr_4__exit_gemm:

cblas_dgemm_ccr_4_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_5:

cblas_dgemm_ccr_5__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_5__exit_gemm

cblas_dgemm_ccr_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_5__exit_gemm

cblas_dgemm_ccr_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_5__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_5__epilog

cblas_dgemm_ccr_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vlse64.v v31, 0(s4), s11
    vfmul.vf v31, v31, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v29, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_5__loop_kk_1
1:   
    vlse64.v v31, 0(s4), s11
    vfmul.vf v31, v31, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_5__loop_kk_0

cblas_dgemm_ccr_5__loop_kk_0:
    vfmacc.vf v31, fa6, v30
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v29, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_5__loop_kk_1:
    vfmacc.vf v31, fa5, v29
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v30, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_5__loop_kk_0

cblas_dgemm_ccr_5__epilog:
    vfmacc.vf v31, fa6, v30
    vsse64.v v31, 0(s8), s11

cblas_dgemm_ccr_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_5__c_col_loop

cblas_dgemm_ccr_5__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 8
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_5__c_row_loop

cblas_dgemm_ccr_5__end_c_row_loop:

cblas_dgemm_ccr_5__exit_gemm:

cblas_dgemm_ccr_5_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_6:

cblas_dgemm_ccr_6__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m1
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_ccr_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_ccr_6__exit_gemm

cblas_dgemm_ccr_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_ccr_6__exit_gemm

cblas_dgemm_ccr_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_ccr_6__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_ccr_6__epilog

cblas_dgemm_ccr_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    addi t1, t1, 8
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_6__loop_kk_1
1:   
    mv t1, s4
    vlse64.v v31, 0(t1), s11
    vfmul.vf v31, v31, fa1
    addi t1, t1, 8
    vlse64.v v30, 0(t1), s11
    vfmul.vf v30, v30, fa1
    addi t1, t1, 8
    vlse64.v v29, 0(t1), s11
    vfmul.vf v29, v29, fa1
    addi t1, t1, 8
    vlse64.v v28, 0(t1), s11
    vfmul.vf v28, v28, fa1
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_ccr_6__loop_kk_0

cblas_dgemm_ccr_6__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    mv t1, s10
    vfmacc.vf v30, fa5, v27
    fld fa2, 0(t1)
    vfmacc.vf v29, fa4, v27
    add t1, t1, a4
    vfmacc.vf v28, fa3, v27
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v26, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_ccr_6__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    mv t1, s10
    vfmacc.vf v30, fs11, v26
    fld fa6, 0(t1)
    vfmacc.vf v29, fs10, v26
    add t1, t1, a4
    vfmacc.vf v28, fs9, v26
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v27, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_ccr_6__loop_kk_0

cblas_dgemm_ccr_6__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vsse64.v v31, 0(t1), s11
    vfmacc.vf v28, fa3, v27
    addi t1, t1, 8
    vsse64.v v30, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v29, 0(t1), s11
    addi t1, t1, 8
    vsse64.v v28, 0(t1), s11

cblas_dgemm_ccr_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_ccr_6__c_col_loop

cblas_dgemm_ccr_6__end_c_col_loop:
    addi s1, s1, -4
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 32
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_ccr_6__c_row_loop

cblas_dgemm_ccr_6__end_c_row_loop:

cblas_dgemm_ccr_6__exit_gemm:

cblas_dgemm_ccr_6_jexit:
    j exit_cblas_dgemm_ccr

cblas_dgemm_ccr_7:

cblas_dgemm_ccr_7__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_ccr_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_ccr_7__exit_gemm
    beqz a1, cblas_dgemm_ccr_7__exit_gemm

cblas_dgemm_ccr_7__loop_kk:
    mv s0, a1

cblas_dgemm_ccr_7__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_ccr_7__post_scale

cblas_dgemm_ccr_7__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_ccr_7__epilog_scale
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vlse64.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    addi s10, s10, 8
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmul.vf v28, v28, fa1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v24, fa5, v20

cblas_dgemm_ccr_7__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    vfmul.vf v24, v24, fa1
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    addi s10, s10, 8
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8
    vfmul.vf v28, v28, fa1
    blt s8, s6, cblas_dgemm_ccr_7__loop_ii_scale

cblas_dgemm_ccr_7__epilog_scale:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    j cblas_dgemm_ccr_7__end_loop_ii

cblas_dgemm_ccr_7__post_scale:

cblas_dgemm_ccr_7__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_ccr_7__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vlse64.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 8
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    addi s10, s10, 8
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8

cblas_dgemm_ccr_7__loop_ii:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    addi s10, s10, 8
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    addi s10, s10, 8
    blt s8, s6, cblas_dgemm_ccr_7__loop_ii

cblas_dgemm_ccr_7__epilog:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 8
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1

cblas_dgemm_ccr_7__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_ccr_7__loop_jj

cblas_dgemm_ccr_7__end_loop_jj:
    li t1, 1
    mul t1, t1, a4
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 8
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_dgemm_ccr_7__loop_kk

cblas_dgemm_ccr_7__end_loop_kk:

cblas_dgemm_ccr_7__exit_gemm:

cblas_dgemm_ccr_7_jexit:
    j exit_cblas_dgemm_ccr

exit_cblas_dgemm_ccr:
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
.size cblas_dgemm_ccr, .-cblas_dgemm_ccr

.text
.global cblas_dgemm_crc
.type cblas_dgemm_crc, @function

cblas_dgemm_crc:
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

dispatch_cblas_dgemm_crc:
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_dgemm_crc_0
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_dgemm_crc_1
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_crc_2
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_crc_3
1:   
    j exit_cblas_dgemm_crc

cblas_dgemm_crc_0:

cblas_dgemm_crc_0__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m2
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crc_0__exit_gemm

cblas_dgemm_crc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crc_0__exit_gemm

cblas_dgemm_crc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crc_0__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crc_0__epilog

cblas_dgemm_crc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    vfmul.vf v24, v24, fa1
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_0__loop_kk_1
1:   
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    vfmul.vf v24, v24, fa1
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v22, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_0__loop_kk_0

cblas_dgemm_crc_0__loop_kk_0:
    vfmacc.vf v30, fa6, v22
    mv t1, s10
    fld fa2, 0(t1)
    fld fs11, 8(t1)
    vfmacc.vf v28, fa5, v22
    fld fs10, 16(t1)
    fld fs9, 24(t1)
    fmul.d fa2, fa2, fa0
    vfmacc.vf v26, fa4, v22
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vfmacc.vf v24, fa3, v22
    vle64.v v20, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crc_0__loop_kk_1:
    vfmacc.vf v30, fa2, v20
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    vfmacc.vf v28, fs11, v20
    fld fa4, 16(t1)
    fld fa3, 24(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v26, fs10, v20
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fs9, v20
    vle64.v v22, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crc_0__loop_kk_0

cblas_dgemm_crc_0__epilog:
    vfmacc.vf v30, fa6, v22
    mv t1, s8
    vfmacc.vf v28, fa5, v22
    vse64.v v30, 0(t1)
    vfmacc.vf v26, fa4, v22
    add t1, t1, s11
    vse64.v v28, 0(t1)
    vfmacc.vf v24, fa3, v22
    add t1, t1, s11
    vse64.v v26, 0(t1)
    add t1, t1, s11
    vse64.v v24, 0(t1)

cblas_dgemm_crc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crc_0__c_col_loop

cblas_dgemm_crc_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 32
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crc_0__c_row_loop

cblas_dgemm_crc_0__end_c_row_loop:

cblas_dgemm_crc_0__exit_gemm:

cblas_dgemm_crc_0_jexit:
    j exit_cblas_dgemm_crc

cblas_dgemm_crc_1:

cblas_dgemm_crc_1__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m2
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crc_1__exit_gemm

cblas_dgemm_crc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crc_1__exit_gemm

cblas_dgemm_crc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crc_1__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crc_1__epilog

cblas_dgemm_crc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    mv t1, s10
    fld fa3, 0(t1)
    vfmul.vf v26, v26, fa1
    fld fa2, 8(t1)
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v22, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_1__loop_kk_1
1:   
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    mv t1, s10
    fld fa6, 0(t1)
    vfmul.vf v26, v26, fa1
    fld fa5, 8(t1)
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_1__loop_kk_0

cblas_dgemm_crc_1__loop_kk_0:
    vfmacc.vf v30, fa6, v24
    mv t1, s10
    fld fa3, 0(t1)
    fld fa2, 8(t1)
    vfmacc.vf v28, fa5, v24
    fld fs11, 16(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    vfmacc.vf v26, fa4, v24
    fmul.d fs11, fs11, fa0
    vle64.v v22, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crc_1__loop_kk_1:
    vfmacc.vf v30, fa3, v22
    mv t1, s10
    fld fa6, 0(t1)
    fld fa5, 8(t1)
    vfmacc.vf v28, fa2, v22
    fld fa4, 16(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmacc.vf v26, fs11, v22
    fmul.d fa4, fa4, fa0
    vle64.v v24, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crc_1__loop_kk_0

cblas_dgemm_crc_1__epilog:
    vfmacc.vf v30, fa6, v24
    mv t1, s8
    vfmacc.vf v28, fa5, v24
    vse64.v v30, 0(t1)
    vfmacc.vf v26, fa4, v24
    add t1, t1, s11
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vse64.v v26, 0(t1)

cblas_dgemm_crc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crc_1__c_col_loop

cblas_dgemm_crc_1__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 24
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crc_1__c_row_loop

cblas_dgemm_crc_1__end_c_row_loop:

cblas_dgemm_crc_1__exit_gemm:

cblas_dgemm_crc_1_jexit:
    j exit_cblas_dgemm_crc

cblas_dgemm_crc_2:

cblas_dgemm_crc_2__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m2
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    mul t2, t2, s3
    remu t2, a1, t2
    sub a1, a1, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crc_2__exit_gemm

cblas_dgemm_crc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crc_2__exit_gemm

cblas_dgemm_crc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crc_2__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crc_2__epilog

cblas_dgemm_crc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle64.v v30, 0(s4)
    vfmul.vf v30, v30, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v26, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_2__loop_kk_1
1:   
    vle64.v v30, 0(s4)
    vfmul.vf v30, v30, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v28, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_2__loop_kk_0

cblas_dgemm_crc_2__loop_kk_0:
    vfmacc.vf v30, fa6, v28
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v26, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crc_2__loop_kk_1:
    vfmacc.vf v30, fa5, v26
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v28, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crc_2__loop_kk_0

cblas_dgemm_crc_2__epilog:
    vfmacc.vf v30, fa6, v28
    vse64.v v30, 0(s8)

cblas_dgemm_crc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crc_2__c_col_loop

cblas_dgemm_crc_2__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 8
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crc_2__c_row_loop

cblas_dgemm_crc_2__end_c_row_loop:

cblas_dgemm_crc_2__exit_gemm:

cblas_dgemm_crc_2_jexit:
    j exit_cblas_dgemm_crc

cblas_dgemm_crc_3:

cblas_dgemm_crc_3__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_crc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_crc_3__exit_gemm

cblas_dgemm_crc_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_crc_3__exit_gemm

cblas_dgemm_crc_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_crc_3__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_crc_3__epilog
    vsetvli s3, s0, e64,m8
    mul s2, s3, s11
    slli s3, s3, 3

cblas_dgemm_crc_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vlse64.v v24, 0(s4), s11
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_3__loop_kk_1
1:   
    vlse64.v v24, 0(s4), s11
    vfmul.vf v24, v24, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_crc_3__loop_kk_0

cblas_dgemm_crc_3__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    add s10, s10, a4
    add s9, s9, a6

cblas_dgemm_crc_3__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_crc_3__loop_kk_0

cblas_dgemm_crc_3__epilog:
    vfmacc.vf v24, fa6, v16
    vsse64.v v24, 0(s8), s11

cblas_dgemm_crc_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_crc_3__c_col_loop

cblas_dgemm_crc_3__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 8
    add s4, s4, t2
    li t2, 8
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_crc_3__c_row_loop

cblas_dgemm_crc_3__end_c_row_loop:

cblas_dgemm_crc_3__exit_gemm:

cblas_dgemm_crc_3_jexit:
    j exit_cblas_dgemm_crc

exit_cblas_dgemm_crc:
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
.size cblas_dgemm_crc, .-cblas_dgemm_crc

.text
.global cblas_dgemm_rcc
.type cblas_dgemm_rcc, @function

cblas_dgemm_rcc:
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

dispatch_cblas_dgemm_rcc:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa0
    beqz s1, 1f
    j cblas_dgemm_rcc_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_dgemm_rcc_1
1:   
    j exit_cblas_dgemm_rcc

cblas_dgemm_rcc_0:

cblas_dgemm_rcc_0__enter:
    mv t1, a3
    mv a3, a5
    mv a5, t1
    mv t1, a4
    mv a4, a6
    mv a6, t1
    mv t1, a0
    mv a0, a1
    mv a1, t1
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m2
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 1
    mul t1, t1, s3
    remu t1, a1, t1
    sub a1, a1, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcc_0__exit_gemm
    beqz a1, cblas_dgemm_rcc_0__exit_gemm

cblas_dgemm_rcc_0__loop_kk:
    mv s0, a1

cblas_dgemm_rcc_0__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rcc_0__post_scale

cblas_dgemm_rcc_0__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcc_0__epilog_scale
    mv t0, s5
    vlse64.v v22, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v20, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v18, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v30, 0(s8)
    vfmul.vf v30, v30, fa1
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse64.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v26, 0(s8)
    vfmul.vf v26, v26, fa1
    mv t0, s10
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    vfmacc.vf v26, fs8, v22
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    vfmul.vf v24, v24, fa1
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    vfmacc.vf v26, fs7, v20
    fld fs1, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fs4, v22
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    vfmul.vf v30, v30, fa1
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v26, fs6, v18
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    vfmacc.vf v26, fs5, v16
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    add s8, s8, s11
    vfmacc.vf v24, fs3, v20
    add s10, s10, a4
    vfmacc.vf v24, fs2, v18
    vfmacc.vf v24, fs1, v16

cblas_dgemm_rcc_0__loop_ii_scale:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle64.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    vfmacc.vf v30, fa3, v16
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fs9, v16
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmul.vf v26, v26, fa1
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    vfmul.vf v24, v24, fa1
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    vfmacc.vf v26, fs8, v22
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 2
    vfmacc.vf v24, fs4, v22
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v26, fs7, v20
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v24, fs3, v20
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v26, fs6, v18
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    vfmacc.vf v24, fs2, v18
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v26, fs5, v16
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    vfmacc.vf v24, fs1, v16
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    vfmul.vf v30, v30, fa1
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    add s8, s8, s11
    vfmul.vf v28, v28, fa1
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rcc_0__loop_ii_scale

cblas_dgemm_rcc_0__epilog_scale:
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vfmacc.vf v28, fa2, v22
    vfmacc.vf v28, fs11, v20
    vfmacc.vf v28, fs10, v18
    vfmacc.vf v28, fs9, v16
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_dgemm_rcc_0__end_loop_ii

cblas_dgemm_rcc_0__post_scale:

cblas_dgemm_rcc_0__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcc_0__epilog
    mv t0, s5
    vlse64.v v22, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v20, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v18, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse64.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v26, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    vfmacc.vf v26, fs8, v22
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    vfmacc.vf v26, fs7, v20
    mv t0, s10
    fld fs4, 0(t0)
    fld fs3, 8(t0)
    vfmacc.vf v24, fs4, v22
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    add s8, s8, s11
    vfmacc.vf v26, fs6, v18
    add s10, s10, a4
    vle64.v v30, 0(s8)
    mv t0, s10
    vfmacc.vf v24, fs3, v20
    fld fa6, 0(t0)
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    vfmacc.vf v26, fs5, v16
    fld fa3, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fs2, v18
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    vfmacc.vf v24, fs1, v16
    add s8, s8, s11
    add s10, s10, a4

cblas_dgemm_rcc_0__loop_ii:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle64.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    fld fs8, 0(t0)
    fld fs7, 8(t0)
    fld fs6, 16(t0)
    vfmacc.vf v30, fa3, v16
    fld fs5, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fs9, v16
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    vfmacc.vf v26, fs8, v22
    fld fs3, 8(t0)
    fld fs2, 16(t0)
    fld fs1, 24(t0)
    vfmacc.vf v24, fs4, v22
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    vfmacc.vf v26, fs7, v20
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 2
    vfmacc.vf v24, fs3, v20
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v26, fs6, v18
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v24, fs2, v18
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v26, fs5, v16
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    vfmacc.vf v24, fs1, v16
    fld fa5, 8(t0)
    fld fa4, 16(t0)
    fld fa3, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fld fs11, 8(t0)
    fld fs10, 16(t0)
    fld fs9, 24(t0)
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rcc_0__loop_ii

cblas_dgemm_rcc_0__epilog:
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vfmacc.vf v28, fa2, v22
    vfmacc.vf v28, fs11, v20
    vfmacc.vf v28, fs10, v18
    vfmacc.vf v28, fs9, v16
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcc_0__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcc_0__loop_jj

cblas_dgemm_rcc_0__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcc_0__loop_kk

cblas_dgemm_rcc_0__end_loop_kk:

cblas_dgemm_rcc_0__exit_gemm:

cblas_dgemm_rcc_0_jexit:
    j exit_cblas_dgemm_rcc

cblas_dgemm_rcc_1:

cblas_dgemm_rcc_1__enter:
    mv t1, a3
    mv a3, a5
    mv a5, t1
    mv t1, a4
    mv a4, a6
    mv a6, t1
    mv t1, a0
    mv a0, a1
    mv a1, t1
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m2
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 1
    mul t1, t1, s3
    remu t1, a1, t1
    sub a1, a1, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rcc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rcc_1__exit_gemm
    beqz a1, cblas_dgemm_rcc_1__exit_gemm

cblas_dgemm_rcc_1__loop_kk:
    mv s0, a1

cblas_dgemm_rcc_1__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rcc_1__post_scale

cblas_dgemm_rcc_1__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcc_1__epilog_scale
    mv t0, s5
    vlse64.v v22, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v20, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v18, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v30, 0(s8)
    vfmul.vf v30, v30, fa1
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse64.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v26, 0(s8)
    vfmul.vf v26, v26, fa1
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    vfmacc.vf v26, fs8, v22
    fmul.d fs6, fs6, fa0
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    vfmul.vf v24, v24, fa1
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    vfmacc.vf v26, fs7, v20
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    vfmacc.vf v24, fs4, v22
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v26, fs6, v18
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v30, 0(s8)
    vfmul.vf v30, v30, fa1
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v26, fs5, v16
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    vfmacc.vf v24, fs3, v20
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    vfmacc.vf v24, fs2, v18
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    vfmacc.vf v24, fs1, v16
    add s8, s8, s11
    add s10, s10, a4

cblas_dgemm_rcc_1__loop_ii_scale:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle64.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    vfmacc.vf v30, fa3, v16
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    vfmacc.vf v28, fs9, v16
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    vfmul.vf v26, v26, fa1
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    vfmul.vf v24, v24, fa1
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    fld fs3, 8(t0)
    vfmacc.vf v26, fs8, v22
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    fmul.d fs2, fs2, fa0
    vfmacc.vf v24, fs4, v22
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    add s8, s8, s11
    vfmacc.vf v26, fs7, v20
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    vfmacc.vf v24, fs3, v20
    vse64.v v30, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    vfmacc.vf v26, fs6, v18
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fs2, v18
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v26, fs5, v16
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v24, fs1, v16
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    vfmul.vf v30, v30, fa1
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rcc_1__loop_ii_scale

cblas_dgemm_rcc_1__epilog_scale:
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vfmacc.vf v28, fa2, v22
    vfmacc.vf v28, fs11, v20
    vfmacc.vf v28, fs10, v18
    vfmacc.vf v28, fs9, v16
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_dgemm_rcc_1__end_loop_ii

cblas_dgemm_rcc_1__post_scale:

cblas_dgemm_rcc_1__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rcc_1__epilog
    mv t0, s5
    vlse64.v v22, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v20, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v18, 0(t0), a6
    addi t0, t0, 8
    vlse64.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse64.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v26, 0(s8)
    mv t0, s10
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    vfmacc.vf v26, fs8, v22
    fld fs7, 8(t0)
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    vfmacc.vf v26, fs7, v20
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    vfmacc.vf v26, fs6, v18
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    vfmacc.vf v24, fs4, v22
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v26, fs5, v16
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v30, 0(s8)
    vfmacc.vf v24, fs3, v20
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    vfmacc.vf v24, fs2, v18
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    vfmacc.vf v24, fs1, v16
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4

cblas_dgemm_rcc_1__loop_ii:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle64.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    fld fs8, 0(t0)
    fmul.d fs8, fs8, fa0
    fld fs7, 8(t0)
    vfmacc.vf v30, fa3, v16
    fmul.d fs7, fs7, fa0
    fld fs6, 16(t0)
    fmul.d fs6, fs6, fa0
    vfmacc.vf v28, fs9, v16
    fld fs5, 24(t0)
    fmul.d fs5, fs5, fa0
    add s8, s8, s11
    vfmacc.vf v26, fs8, v22
    add s10, s10, a4
    vle64.v v24, 0(s8)
    mv t0, s10
    fld fs4, 0(t0)
    fmul.d fs4, fs4, fa0
    vfmacc.vf v24, fs4, v22
    fld fs3, 8(t0)
    fmul.d fs3, fs3, fa0
    fld fs2, 16(t0)
    vfmacc.vf v26, fs7, v20
    fmul.d fs2, fs2, fa0
    fld fs1, 24(t0)
    fmul.d fs1, fs1, fa0
    vfmacc.vf v24, fs3, v20
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 2
    vfmacc.vf v26, fs6, v18
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 2
    vfmacc.vf v24, fs2, v18
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v26, fs5, v16
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v24, fs1, v16
    mul t1, t1, s11
    add s8, s8, t1
    vle64.v v30, 0(s8)
    mv t0, s10
    fld fa6, 0(t0)
    fmul.d fa6, fa6, fa0
    fld fa5, 8(t0)
    fmul.d fa5, fa5, fa0
    fld fa4, 16(t0)
    fmul.d fa4, fa4, fa0
    fld fa3, 24(t0)
    fmul.d fa3, fa3, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    mv t0, s10
    fld fa2, 0(t0)
    fmul.d fa2, fa2, fa0
    fld fs11, 8(t0)
    fmul.d fs11, fs11, fa0
    fld fs10, 16(t0)
    fmul.d fs10, fs10, fa0
    fld fs9, 24(t0)
    fmul.d fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rcc_1__loop_ii

cblas_dgemm_rcc_1__epilog:
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vfmacc.vf v28, fa2, v22
    vfmacc.vf v28, fs11, v20
    vfmacc.vf v28, fs10, v18
    vfmacc.vf v28, fs9, v16
    slli t1, s11, 2
    sub s8, s8, t1
    vse64.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_dgemm_rcc_1__end_loop_ii:
    srai t1, s3, 3
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rcc_1__loop_jj

cblas_dgemm_rcc_1__end_loop_jj:
    li t1, 32
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 3
    sub s4, s4, t1
    li t1, 32
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_dgemm_rcc_1__loop_kk

cblas_dgemm_rcc_1__end_loop_kk:

cblas_dgemm_rcc_1__exit_gemm:

cblas_dgemm_rcc_1_jexit:
    j exit_cblas_dgemm_rcc

exit_cblas_dgemm_rcc:
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
.size cblas_dgemm_rcc, .-cblas_dgemm_rcc

.text
.global cblas_dgemm_rrr
.type cblas_dgemm_rrr, @function

cblas_dgemm_rrr:
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

dispatch_cblas_dgemm_rrr:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 16
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_rrr_0
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 16
    blt a1, s1, 1f
    j cblas_dgemm_rrr_1
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 16
    blt a1, s1, 1f
    li s1, 0
    fcvt.d.l ft0, s1
    feq.d s1, ft0, fa1
    beqz s1, 1f
    j cblas_dgemm_rrr_2
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 16
    blt a1, s1, 1f
    j cblas_dgemm_rrr_3
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_rrr_4
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_dgemm_rrr_5
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_dgemm_rrr_6
1:   
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_0:

cblas_dgemm_rrr_0__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_0__exit_gemm

cblas_dgemm_rrr_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_0__exit_gemm

cblas_dgemm_rrr_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_0__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_0__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_0__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_0__first_kk_0

cblas_dgemm_rrr_0__first_kk_0:
    vfmul.vf v28, v12, fa6
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v12, fa5
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmul.vf v20, v12, fa4
    add s9, s9, a6
    vfmul.vf v16, v12, fa3
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    j cblas_dgemm_rrr_0__loop_kk_0

cblas_dgemm_rrr_0__first_kk_1:
    vfmul.vf v28, v8, fa2
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v8, fs11
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmul.vf v20, v8, fs10
    add s9, s9, a6
    vfmul.vf v16, v8, fs9

cblas_dgemm_rrr_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa5, v12
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fa4, v12
    add s9, s9, a6
    vfmacc.vf v16, fa3, v12

cblas_dgemm_rrr_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_rrr_0__loop_kk_0

cblas_dgemm_rrr_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_rrr_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_0__c_col_loop

cblas_dgemm_rrr_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_0__c_row_loop

cblas_dgemm_rrr_0__end_c_row_loop:

cblas_dgemm_rrr_0__exit_gemm:

cblas_dgemm_rrr_0_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_1:

cblas_dgemm_rrr_1__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_1__exit_gemm

cblas_dgemm_rrr_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_1__exit_gemm

cblas_dgemm_rrr_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_1__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_1__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_rrr_1__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v24, v24, fa1
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    fld fa3, 0(t1)
    vfmul.vf v20, v20, fa1
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v16, v16, fa1
    mv s8, s4
    j cblas_dgemm_rrr_1__loop_kk_0

cblas_dgemm_rrr_1__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    mv t1, s10
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa5, v12
    fld fs9, 0(t1)
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fa4, v12
    add s9, s9, a6
    vfmacc.vf v16, fa3, v12

cblas_dgemm_rrr_1__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs11, v8
    fld fa3, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    vfmacc.vf v20, fs10, v8
    add s9, s9, a6
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_dgemm_rrr_1__loop_kk_0

cblas_dgemm_rrr_1__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse64.v v20, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_rrr_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_1__c_col_loop

cblas_dgemm_rrr_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_1__c_row_loop

cblas_dgemm_rrr_1__end_c_row_loop:

cblas_dgemm_rrr_1__exit_gemm:

cblas_dgemm_rrr_1_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_2:

cblas_dgemm_rrr_2__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_2__exit_gemm

cblas_dgemm_rrr_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_2__exit_gemm

cblas_dgemm_rrr_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_2__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_2__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_2__first_kk_1
1:   
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_2__first_kk_0

cblas_dgemm_rrr_2__first_kk_0:
    vfmul.vf v28, v16, fa6
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmul.vf v24, v16, fa5
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v20, v16, fa4
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    j cblas_dgemm_rrr_2__loop_kk_0

cblas_dgemm_rrr_2__first_kk_1:
    vfmul.vf v28, v12, fa3
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmul.vf v24, v12, fa2
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmul.vf v20, v12, fs11

cblas_dgemm_rrr_2__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fa5, v16
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_rrr_2__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_rrr_2__loop_kk_0

cblas_dgemm_rrr_2__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_rrr_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_2__c_col_loop

cblas_dgemm_rrr_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_2__c_row_loop

cblas_dgemm_rrr_2__end_c_row_loop:

cblas_dgemm_rrr_2__exit_gemm:

cblas_dgemm_rrr_2_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_3:

cblas_dgemm_rrr_3__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_3__exit_gemm

cblas_dgemm_rrr_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_3__exit_gemm

cblas_dgemm_rrr_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_3__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_3__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_3__loop_kk_1
1:   
    mv t1, s4
    vle64.v v28, 0(t1)
    vfmul.vf v28, v28, fa1
    add t1, t1, s11
    vle64.v v24, 0(t1)
    add t1, t1, s11
    vle64.v v20, 0(t1)
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmul.vf v24, v24, fa1
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    vfmul.vf v20, v20, fa1
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_3__loop_kk_0

cblas_dgemm_rrr_3__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    mv t1, s10
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    fmul.d fa3, fa3, fa0
    vfmacc.vf v24, fa5, v16
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fa4, v16

cblas_dgemm_rrr_3__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v24, fa2, v12
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_dgemm_rrr_3__loop_kk_0

cblas_dgemm_rrr_3__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse64.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse64.v v24, 0(t1)
    add t1, t1, s11
    vse64.v v20, 0(t1)

cblas_dgemm_rrr_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_3__c_col_loop

cblas_dgemm_rrr_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 3
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_3__c_row_loop

cblas_dgemm_rrr_3__end_c_row_loop:

cblas_dgemm_rrr_3__exit_gemm:

cblas_dgemm_rrr_3_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_4:

cblas_dgemm_rrr_4__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m2
    li t2, 8
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_4__exit_gemm

cblas_dgemm_rrr_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_4__exit_gemm

cblas_dgemm_rrr_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_4__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_4__epilog
    vsetvli s3, s0, e64,m2
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    add t1, t1, s11
    vle64.v v22, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v18, 0(t1)
    vfmul.vf v22, v22, fa1
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v20, v20, fa1
    fld fs8, 0(t1)
    add t1, t1, a4
    fld fs7, 0(t1)
    vfmul.vf v18, v18, fa1
    add t1, t1, a4
    fld fs6, 0(t1)
    add t1, t1, a4
    vfmul.vf v16, v16, fa1
    fld fs5, 0(t1)
    add t1, t1, a4
    fld fs4, 0(t1)
    add t1, t1, a4
    fld fs3, 0(t1)
    add t1, t1, a4
    fld fs2, 0(t1)
    add t1, t1, a4
    fld fs1, 0(t1)
    fmul.d fs8, fs8, fa0
    fmul.d fs7, fs7, fa0
    fmul.d fs6, fs6, fa0
    fmul.d fs5, fs5, fa0
    fmul.d fs4, fs4, fa0
    fmul.d fs3, fs3, fa0
    fmul.d fs2, fs2, fa0
    fmul.d fs1, fs1, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_4__loop_kk_1
1:   
    mv t1, s4
    vle64.v v30, 0(t1)
    vfmul.vf v30, v30, fa1
    add t1, t1, s11
    vle64.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle64.v v26, 0(t1)
    add t1, t1, s11
    vle64.v v24, 0(t1)
    vfmul.vf v26, v26, fa1
    add t1, t1, s11
    vle64.v v22, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle64.v v20, 0(t1)
    add t1, t1, s11
    vle64.v v18, 0(t1)
    vfmul.vf v22, v22, fa1
    add t1, t1, s11
    vle64.v v16, 0(t1)
    mv t1, s10
    vfmul.vf v20, v20, fa1
    fld fa6, 0(t1)
    add t1, t1, a4
    fld fa5, 0(t1)
    vfmul.vf v18, v18, fa1
    add t1, t1, a4
    fld fa4, 0(t1)
    add t1, t1, a4
    vfmul.vf v16, v16, fa1
    fld fa3, 0(t1)
    add t1, t1, a4
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    fld fs9, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v14, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_4__loop_kk_0

cblas_dgemm_rrr_4__loop_kk_0:
    vfmacc.vf v30, fa6, v14
    mv t1, s10
    fld fs8, 0(t1)
    add t1, t1, a4
    vfmacc.vf v28, fa5, v14
    fld fs7, 0(t1)
    add t1, t1, a4
    fld fs6, 0(t1)
    vfmacc.vf v26, fa4, v14
    add t1, t1, a4
    fld fs5, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fa3, v14
    fld fs4, 0(t1)
    add t1, t1, a4
    fld fs3, 0(t1)
    vfmacc.vf v22, fa2, v14
    add t1, t1, a4
    fld fs2, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs11, v14
    fld fs1, 0(t1)
    fmul.d fs8, fs8, fa0
    fmul.d fs7, fs7, fa0
    vfmacc.vf v18, fs10, v14
    fmul.d fs6, fs6, fa0
    fmul.d fs5, fs5, fa0
    fmul.d fs4, fs4, fa0
    vfmacc.vf v16, fs9, v14
    fmul.d fs3, fs3, fa0
    fmul.d fs2, fs2, fa0
    fmul.d fs1, fs1, fa0
    vle64.v v12, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_rrr_4__loop_kk_1:
    vfmacc.vf v30, fs8, v12
    mv t1, s10
    fld fa6, 0(t1)
    add t1, t1, a4
    vfmacc.vf v28, fs7, v12
    fld fa5, 0(t1)
    add t1, t1, a4
    fld fa4, 0(t1)
    vfmacc.vf v26, fs6, v12
    add t1, t1, a4
    fld fa3, 0(t1)
    add t1, t1, a4
    vfmacc.vf v24, fs5, v12
    fld fa2, 0(t1)
    add t1, t1, a4
    fld fs11, 0(t1)
    vfmacc.vf v22, fs4, v12
    add t1, t1, a4
    fld fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs3, v12
    fld fs9, 0(t1)
    fmul.d fa6, fa6, fa0
    fmul.d fa5, fa5, fa0
    vfmacc.vf v18, fs2, v12
    fmul.d fa4, fa4, fa0
    fmul.d fa3, fa3, fa0
    fmul.d fa2, fa2, fa0
    vfmacc.vf v16, fs1, v12
    fmul.d fs11, fs11, fa0
    fmul.d fs10, fs10, fa0
    fmul.d fs9, fs9, fa0
    vle64.v v14, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_rrr_4__loop_kk_0

cblas_dgemm_rrr_4__epilog:
    vfmacc.vf v30, fa6, v14
    mv t1, s8
    vfmacc.vf v28, fa5, v14
    vse64.v v30, 0(t1)
    vfmacc.vf v26, fa4, v14
    add t1, t1, s11
    vse64.v v28, 0(t1)
    vfmacc.vf v24, fa3, v14
    add t1, t1, s11
    vse64.v v26, 0(t1)
    vfmacc.vf v22, fa2, v14
    add t1, t1, s11
    vse64.v v24, 0(t1)
    vfmacc.vf v20, fs11, v14
    add t1, t1, s11
    vse64.v v22, 0(t1)
    vfmacc.vf v18, fs10, v14
    add t1, t1, s11
    vse64.v v20, 0(t1)
    vfmacc.vf v16, fs9, v14
    add t1, t1, s11
    vse64.v v18, 0(t1)
    add t1, t1, s11
    vse64.v v16, 0(t1)

cblas_dgemm_rrr_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_4__c_col_loop

cblas_dgemm_rrr_4__end_c_col_loop:
    addi s1, s1, -8
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 3
    add s4, s4, t2
    slli t2, a4, 3
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_4__c_row_loop

cblas_dgemm_rrr_4__end_c_row_loop:

cblas_dgemm_rrr_4__exit_gemm:

cblas_dgemm_rrr_4_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_5:

cblas_dgemm_rrr_5__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t2, -1
    vsetvli s3, t2, e64, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_dgemm_rrr_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_dgemm_rrr_5__exit_gemm

cblas_dgemm_rrr_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_dgemm_rrr_5__exit_gemm

cblas_dgemm_rrr_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_dgemm_rrr_5__prolog:
    slli s6, a2, 3
    add s6, s6, s7
    bge s10, s6, cblas_dgemm_rrr_5__epilog
    vsetvli s3, s0, e64,m8
    slli s2, s3, 3
    slli s3, s3, 3

cblas_dgemm_rrr_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle64.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_5__loop_kk_1
1:   
    vle64.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    mv s8, s4
    j cblas_dgemm_rrr_5__loop_kk_0

cblas_dgemm_rrr_5__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vle64.v v8, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6

cblas_dgemm_rrr_5__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vle64.v v16, 0(s9)
    addi s10, s10, 8
    add s9, s9, a6
    blt s10, s6, cblas_dgemm_rrr_5__loop_kk_0

cblas_dgemm_rrr_5__epilog:
    vfmacc.vf v24, fa6, v16
    vse64.v v24, 0(s8)

cblas_dgemm_rrr_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 3
    sub s0, s0, t2
    bnez s0, cblas_dgemm_rrr_5__c_col_loop

cblas_dgemm_rrr_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 3
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_dgemm_rrr_5__c_row_loop

cblas_dgemm_rrr_5__end_c_row_loop:

cblas_dgemm_rrr_5__exit_gemm:

cblas_dgemm_rrr_5_jexit:
    j exit_cblas_dgemm_rrr

cblas_dgemm_rrr_6:

cblas_dgemm_rrr_6__enter:
    slli a4, a4, 3
    slli a6, a6, 3
    ld s11, 0(fp)
    slli s11, s11, 3
    li t1, -1
    vsetvli s3, t1, e64 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_dgemm_rrr_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 3
    slli s3, s3, 3
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_dgemm_rrr_6__exit_gemm
    beqz a1, cblas_dgemm_rrr_6__exit_gemm

cblas_dgemm_rrr_6__loop_kk:
    mv s0, a1

cblas_dgemm_rrr_6__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_dgemm_rrr_6__post_scale

cblas_dgemm_rrr_6__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rrr_6__epilog_scale
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vle64.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    vfmul.vf v24, v24, fa1
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmul.vf v28, v28, fa1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v24, fa5, v20

cblas_dgemm_rrr_6__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    vfmul.vf v24, v24, fa1
    fmul.d fa5, fa5, fa0
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v28, v28, fa1
    blt s8, s6, cblas_dgemm_rrr_6__loop_ii_scale

cblas_dgemm_rrr_6__epilog_scale:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    j cblas_dgemm_rrr_6__end_loop_ii

cblas_dgemm_rrr_6__post_scale:

cblas_dgemm_rrr_6__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_dgemm_rrr_6__epilog
    vsetvli s3, s0, e64,m4
    slli s2, s3, 3
    slli s3, s3, 3
    vle64.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse64.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    add s10, s10, a4
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    add s10, s10, a4

cblas_dgemm_rrr_6__loop_ii:
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v24, 0(s8)
    fld fa5, 0(s10)
    fmul.d fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s8, s8, s11
    add s10, s10, a4
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    vle64.v v28, 0(s8)
    fld fa6, 0(s10)
    fmul.d fa6, fa6, fa0
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_dgemm_rrr_6__loop_ii

cblas_dgemm_rrr_6__epilog:
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse64.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1

cblas_dgemm_rrr_6__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 3
    sub s0, s0, t1
    bnez s0, cblas_dgemm_rrr_6__loop_jj

cblas_dgemm_rrr_6__end_loop_jj:
    li t1, 8
    add s7, s7, t1
    slli t1, a1, 3
    sub s5, s5, t1
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_dgemm_rrr_6__loop_kk

cblas_dgemm_rrr_6__end_loop_kk:

cblas_dgemm_rrr_6__exit_gemm:

cblas_dgemm_rrr_6_jexit:
    j exit_cblas_dgemm_rrr

exit_cblas_dgemm_rrr:
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
.size cblas_dgemm_rrr, .-cblas_dgemm_rrr
