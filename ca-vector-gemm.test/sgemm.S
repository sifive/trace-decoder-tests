/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

.text
.global cblas_sgemm_crr
.type cblas_sgemm_crr, @function

cblas_sgemm_crr:
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

dispatch_cblas_sgemm_crr:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_crr_0
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_crr_1
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_crr_2
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_crr_3
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_crr_4
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_crr_5
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_crr_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_sgemm_crr_7
1:   
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_0:

cblas_sgemm_crr_0__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_0__exit_gemm

cblas_sgemm_crr_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_0__exit_gemm

cblas_sgemm_crr_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_0__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_0__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v8, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_crr_0__first_kk_1
1:   
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_crr_0__first_kk_0

cblas_sgemm_crr_0__first_kk_0:
    vfmul.vf v28, v12, fa6
    vle32.v v8, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v24, v12, fa5
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmul.vf v20, v12, fa4
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmul.vf v16, v12, fa3
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmacc.vf v20, fs10, v8
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    j cblas_sgemm_crr_0__loop_kk_0

cblas_sgemm_crr_0__first_kk_1:
    vfmul.vf v28, v8, fa2
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v24, v8, fs11
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmul.vf v20, v8, fs10
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmul.vf v16, v8, fs9

cblas_sgemm_crr_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    vle32.v v8, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v12
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fa4, v12
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fa3, v12

cblas_sgemm_crr_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmacc.vf v20, fs10, v8
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_sgemm_crr_0__loop_kk_0

cblas_sgemm_crr_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse32.v v20, 0(t1)
    add t1, t1, s11
    vse32.v v16, 0(t1)

cblas_sgemm_crr_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_0__c_col_loop

cblas_sgemm_crr_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 16
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_0__c_row_loop

cblas_sgemm_crr_0__end_c_row_loop:

cblas_sgemm_crr_0__exit_gemm:

cblas_sgemm_crr_0_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_1:

cblas_sgemm_crr_1__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_1__exit_gemm

cblas_sgemm_crr_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_1__exit_gemm

cblas_sgemm_crr_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_1__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_1__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v8, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v16, v16, fa1
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_crr_1__loop_kk_1
1:   
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v16, v16, fa1
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_crr_1__loop_kk_0

cblas_sgemm_crr_1__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    vle32.v v8, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v12
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fa4, v12
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fa3, v12

cblas_sgemm_crr_1__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmacc.vf v20, fs10, v8
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_sgemm_crr_1__loop_kk_0

cblas_sgemm_crr_1__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse32.v v20, 0(t1)
    add t1, t1, s11
    vse32.v v16, 0(t1)

cblas_sgemm_crr_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_1__c_col_loop

cblas_sgemm_crr_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 16
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_1__c_row_loop

cblas_sgemm_crr_1__end_c_row_loop:

cblas_sgemm_crr_1__exit_gemm:

cblas_sgemm_crr_1_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_2:

cblas_sgemm_crr_2__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_2__exit_gemm

cblas_sgemm_crr_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_2__exit_gemm

cblas_sgemm_crr_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_2__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_2__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_crr_2__first_kk_1
1:   
    vle32.v v16, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_crr_2__first_kk_0

cblas_sgemm_crr_2__first_kk_0:
    vfmul.vf v28, v16, fa6
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v24, v16, fa5
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmul.vf v20, v16, fa4
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    vfmacc.vf v20, fs11, v12
    j cblas_sgemm_crr_2__loop_kk_0

cblas_sgemm_crr_2__first_kk_1:
    vfmul.vf v28, v12, fa3
    vle32.v v16, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmul.vf v24, v12, fa2
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    vfmul.vf v20, v12, fs11

cblas_sgemm_crr_2__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v16
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fa4, v16

cblas_sgemm_crr_2__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_sgemm_crr_2__loop_kk_0

cblas_sgemm_crr_2__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vse32.v v20, 0(t1)

cblas_sgemm_crr_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_2__c_col_loop

cblas_sgemm_crr_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 12
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_2__c_row_loop

cblas_sgemm_crr_2__end_c_row_loop:

cblas_sgemm_crr_2__exit_gemm:

cblas_sgemm_crr_2_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_3:

cblas_sgemm_crr_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_3__exit_gemm

cblas_sgemm_crr_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_3__exit_gemm

cblas_sgemm_crr_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_3__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_3__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v20, v20, fa1
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_crr_3__loop_kk_1
1:   
    vle32.v v16, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v20, v20, fa1
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_crr_3__loop_kk_0

cblas_sgemm_crr_3__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    vle32.v v12, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v16
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fa4, v16

cblas_sgemm_crr_3__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    vfmacc.vf v20, fs11, v12
    blt s10, s6, cblas_sgemm_crr_3__loop_kk_0

cblas_sgemm_crr_3__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vse32.v v20, 0(t1)

cblas_sgemm_crr_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_3__c_col_loop

cblas_sgemm_crr_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 12
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_3__c_row_loop

cblas_sgemm_crr_3__end_c_row_loop:

cblas_sgemm_crr_3__exit_gemm:

cblas_sgemm_crr_3_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_4:

cblas_sgemm_crr_4__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_4__exit_gemm

cblas_sgemm_crr_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_4__exit_gemm

cblas_sgemm_crr_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_4__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_4__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_4__first_kk_1
1:   
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_4__first_kk_0

cblas_sgemm_crr_4__first_kk_0:
    vfmul.vf v28, v24, fa6
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    j cblas_sgemm_crr_4__loop_kk_0

cblas_sgemm_crr_4__first_kk_1:
    vfmul.vf v28, v20, fa5
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crr_4__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crr_4__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_crr_4__loop_kk_0

cblas_sgemm_crr_4__epilog:
    vfmacc.vf v28, fa6, v24
    vse32.v v28, 0(s8)

cblas_sgemm_crr_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_4__c_col_loop

cblas_sgemm_crr_4__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_4__c_row_loop

cblas_sgemm_crr_4__end_c_row_loop:

cblas_sgemm_crr_4__exit_gemm:

cblas_sgemm_crr_4_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_5:

cblas_sgemm_crr_5__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_5__exit_gemm

cblas_sgemm_crr_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_5__exit_gemm

cblas_sgemm_crr_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_5__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_5__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_5__loop_kk_1
1:   
    vle32.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_5__loop_kk_0

cblas_sgemm_crr_5__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crr_5__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_crr_5__loop_kk_0

cblas_sgemm_crr_5__epilog:
    vfmacc.vf v28, fa6, v24
    vse32.v v28, 0(s8)

cblas_sgemm_crr_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_5__c_col_loop

cblas_sgemm_crr_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_5__c_row_loop

cblas_sgemm_crr_5__end_c_row_loop:

cblas_sgemm_crr_5__exit_gemm:

cblas_sgemm_crr_5_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_6:

cblas_sgemm_crr_6__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crr_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crr_6__exit_gemm

cblas_sgemm_crr_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crr_6__exit_gemm

cblas_sgemm_crr_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crr_6__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crr_6__epilog
    vsetvli s3, s0, e32,m8
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_crr_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_6__loop_kk_1
1:   
    vle32.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crr_6__loop_kk_0

cblas_sgemm_crr_6__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crr_6__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_crr_6__loop_kk_0

cblas_sgemm_crr_6__epilog:
    vfmacc.vf v24, fa6, v16
    vse32.v v24, 0(s8)

cblas_sgemm_crr_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crr_6__c_col_loop

cblas_sgemm_crr_6__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crr_6__c_row_loop

cblas_sgemm_crr_6__end_c_row_loop:

cblas_sgemm_crr_6__exit_gemm:

cblas_sgemm_crr_6_jexit:
    j exit_cblas_sgemm_crr

cblas_sgemm_crr_7:

cblas_sgemm_crr_7__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_crr_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_crr_7__exit_gemm
    beqz a1, cblas_sgemm_crr_7__exit_gemm

cblas_sgemm_crr_7__loop_kk:
    mv s0, a1

cblas_sgemm_crr_7__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_crr_7__post_scale

cblas_sgemm_crr_7__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_crr_7__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    vle32.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vle32.v v28, 0(s8)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s8, s8, s11
    vfmacc.vf v24, fa5, v20
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0
    vfmul.vf v28, v28, fa1

cblas_sgemm_crr_7__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    slli t1, s11, 1
    vle32.v v24, 0(s8)
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 1
    vfmul.vf v24, v24, fa1
    vse32.v v28, 0(s8)
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_crr_7__loop_ii_scale

cblas_sgemm_crr_7__epilog_scale:
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    j cblas_sgemm_crr_7__end_loop_ii

cblas_sgemm_crr_7__post_scale:

cblas_sgemm_crr_7__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_crr_7__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    vle32.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    flw fa5, 0(s10)
    vle32.v v28, 0(s8)
    fmul.s fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    addi s10, s10, 4
    add s8, s8, s11
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0

cblas_sgemm_crr_7__loop_ii:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    slli t1, s11, 1
    vle32.v v24, 0(s8)
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 1
    vfmacc.vf v24, fa5, v20
    vse32.v v28, 0(s8)
    add s8, s8, t1
    vle32.v v28, 0(s8)
    add s8, s8, s11
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_crr_7__loop_ii

cblas_sgemm_crr_7__epilog:
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    addi s10, s10, 4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1

cblas_sgemm_crr_7__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_crr_7__loop_jj

cblas_sgemm_crr_7__end_loop_jj:
    li t1, 1
    mul t1, t1, a4
    add s7, s7, t1
    slli t1, a1, 2
    sub s5, s5, t1
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_sgemm_crr_7__loop_kk

cblas_sgemm_crr_7__end_loop_kk:

cblas_sgemm_crr_7__exit_gemm:

cblas_sgemm_crr_7_jexit:
    j exit_cblas_sgemm_crr

exit_cblas_sgemm_crr:
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
.size cblas_sgemm_crr, .-cblas_sgemm_crr

.text
.global cblas_sgemm_rrr
.type cblas_sgemm_rrr, @function

cblas_sgemm_rrr:
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

dispatch_cblas_sgemm_rrr:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_rrr_0
1:   
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_rrr_1
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_rrr_2
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_rrr_3
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_rrr_4
1:   
    li s1, 2
    blt a2, s1, 1f
    li s1, 17
    blt a1, s1, 1f
    j cblas_sgemm_rrr_5
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_rrr_6
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_rrr_7
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_sgemm_rrr_8
1:   
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_0:

cblas_sgemm_rrr_0__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_0__exit_gemm

cblas_sgemm_rrr_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_0__exit_gemm

cblas_sgemm_rrr_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_0__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_0__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v8, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_rrr_0__first_kk_1
1:   
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_rrr_0__first_kk_0

cblas_sgemm_rrr_0__first_kk_0:
    vfmul.vf v28, v12, fa6
    vle32.v v8, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmul.vf v24, v12, fa5
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    vfmul.vf v20, v12, fa4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmul.vf v16, v12, fa3
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs10, v8
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    j cblas_sgemm_rrr_0__loop_kk_0

cblas_sgemm_rrr_0__first_kk_1:
    vfmul.vf v28, v8, fa2
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmul.vf v24, v8, fs11
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    vfmul.vf v20, v8, fs10
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmul.vf v16, v8, fs9

cblas_sgemm_rrr_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    vle32.v v8, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v12
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fa4, v12
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fa3, v12

cblas_sgemm_rrr_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs10, v8
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_sgemm_rrr_0__loop_kk_0

cblas_sgemm_rrr_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse32.v v20, 0(t1)
    add t1, t1, s11
    vse32.v v16, 0(t1)

cblas_sgemm_rrr_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_0__c_col_loop

cblas_sgemm_rrr_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_0__c_row_loop

cblas_sgemm_rrr_0__end_c_row_loop:

cblas_sgemm_rrr_0__exit_gemm:

cblas_sgemm_rrr_0_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_1:

cblas_sgemm_rrr_1__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_1__exit_gemm

cblas_sgemm_rrr_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_1__exit_gemm

cblas_sgemm_rrr_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_1__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_1__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v8, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_rrr_1__loop_kk_1
1:   
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_rrr_1__loop_kk_0

cblas_sgemm_rrr_1__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    vle32.v v8, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v12
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fa4, v12
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fa3, v12

cblas_sgemm_rrr_1__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs10, v8
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_sgemm_rrr_1__loop_kk_0

cblas_sgemm_rrr_1__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v12
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vfmacc.vf v16, fa3, v12
    vse32.v v20, 0(t1)
    add t1, t1, s11
    vse32.v v16, 0(t1)

cblas_sgemm_rrr_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_1__c_col_loop

cblas_sgemm_rrr_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_1__c_row_loop

cblas_sgemm_rrr_1__end_c_row_loop:

cblas_sgemm_rrr_1__exit_gemm:

cblas_sgemm_rrr_1_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_2:

cblas_sgemm_rrr_2__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_2__exit_gemm

cblas_sgemm_rrr_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_2__exit_gemm

cblas_sgemm_rrr_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_2__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_2__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_rrr_2__first_kk_1
1:   
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_rrr_2__first_kk_0

cblas_sgemm_rrr_2__first_kk_0:
    vfmul.vf v28, v16, fa6
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmul.vf v24, v16, fa5
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    vfmul.vf v20, v16, fa4
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v20, fs11, v12
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    j cblas_sgemm_rrr_2__loop_kk_0

cblas_sgemm_rrr_2__first_kk_1:
    vfmul.vf v28, v12, fa3
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmul.vf v24, v12, fa2
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    vfmul.vf v20, v12, fs11
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0

cblas_sgemm_rrr_2__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v16
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v20, fa4, v16
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0

cblas_sgemm_rrr_2__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v20, fs11, v12
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    blt s10, s6, cblas_sgemm_rrr_2__loop_kk_0

cblas_sgemm_rrr_2__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vse32.v v20, 0(t1)

cblas_sgemm_rrr_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_2__c_col_loop

cblas_sgemm_rrr_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_2__c_row_loop

cblas_sgemm_rrr_2__end_c_row_loop:

cblas_sgemm_rrr_2__exit_gemm:

cblas_sgemm_rrr_2_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_3:

cblas_sgemm_rrr_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_3__exit_gemm

cblas_sgemm_rrr_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_3__exit_gemm

cblas_sgemm_rrr_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_3__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_3__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_rrr_3__loop_kk_1
1:   
    vle32.v v16, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v20, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_rrr_3__loop_kk_0

cblas_sgemm_rrr_3__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v16
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v20, fa4, v16
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0

cblas_sgemm_rrr_3__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v20, fs11, v12
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    blt s10, s6, cblas_sgemm_rrr_3__loop_kk_0

cblas_sgemm_rrr_3__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fa4, v16
    vse32.v v24, 0(t1)
    add t1, t1, s11
    vse32.v v20, 0(t1)

cblas_sgemm_rrr_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_3__c_col_loop

cblas_sgemm_rrr_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_3__c_row_loop

cblas_sgemm_rrr_3__end_c_row_loop:

cblas_sgemm_rrr_3__exit_gemm:

cblas_sgemm_rrr_3_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_4:

cblas_sgemm_rrr_4__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_4__exit_gemm

cblas_sgemm_rrr_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_4__exit_gemm

cblas_sgemm_rrr_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_4__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_4__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_4__first_kk_1
1:   
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_4__first_kk_0

cblas_sgemm_rrr_4__first_kk_0:
    vfmul.vf v28, v24, fa6
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    j cblas_sgemm_rrr_4__loop_kk_0

cblas_sgemm_rrr_4__first_kk_1:
    vfmul.vf v28, v20, fa5
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_rrr_4__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_rrr_4__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_rrr_4__loop_kk_0

cblas_sgemm_rrr_4__epilog:
    vfmacc.vf v28, fa6, v24
    vse32.v v28, 0(s8)

cblas_sgemm_rrr_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_4__c_col_loop

cblas_sgemm_rrr_4__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_4__c_row_loop

cblas_sgemm_rrr_4__end_c_row_loop:

cblas_sgemm_rrr_4__exit_gemm:

cblas_sgemm_rrr_4_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_5:

cblas_sgemm_rrr_5__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_5__exit_gemm

cblas_sgemm_rrr_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_5__exit_gemm

cblas_sgemm_rrr_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_5__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_5__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_5__loop_kk_1
1:   
    vle32.v v28, 0(s4)
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_5__loop_kk_0

cblas_sgemm_rrr_5__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_rrr_5__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_rrr_5__loop_kk_0

cblas_sgemm_rrr_5__epilog:
    vfmacc.vf v28, fa6, v24
    vse32.v v28, 0(s8)

cblas_sgemm_rrr_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_5__c_col_loop

cblas_sgemm_rrr_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_5__c_row_loop

cblas_sgemm_rrr_5__end_c_row_loop:

cblas_sgemm_rrr_5__exit_gemm:

cblas_sgemm_rrr_5_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_6:

cblas_sgemm_rrr_6__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m2
    li t2, 8
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_6__exit_gemm

cblas_sgemm_rrr_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_6__exit_gemm

cblas_sgemm_rrr_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_6__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_6__epilog
    vsetvli s3, s0, e32,m2
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    add t1, t1, s11
    vfmul.vf v26, v26, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v22, 0(t1)
    add t1, t1, s11
    vfmul.vf v22, v22, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v18, 0(t1)
    add t1, t1, s11
    vfmul.vf v18, v18, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fs8, 0(t1)
    add t1, t1, a4
    flw fs7, 0(t1)
    add t1, t1, a4
    flw fs6, 0(t1)
    add t1, t1, a4
    flw fs5, 0(t1)
    add t1, t1, a4
    flw fs4, 0(t1)
    add t1, t1, a4
    flw fs3, 0(t1)
    add t1, t1, a4
    flw fs2, 0(t1)
    add t1, t1, a4
    flw fs1, 0(t1)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    mv s8, s4
    j cblas_sgemm_rrr_6__loop_kk_1
1:   
    vle32.v v14, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    add t1, t1, s11
    vfmul.vf v26, v26, fa1
    vle32.v v24, 0(t1)
    add t1, t1, s11
    vfmul.vf v24, v24, fa1
    vle32.v v22, 0(t1)
    add t1, t1, s11
    vfmul.vf v22, v22, fa1
    vle32.v v20, 0(t1)
    add t1, t1, s11
    vfmul.vf v20, v20, fa1
    vle32.v v18, 0(t1)
    add t1, t1, s11
    vfmul.vf v18, v18, fa1
    vle32.v v16, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_rrr_6__loop_kk_0

cblas_sgemm_rrr_6__loop_kk_0:
    vfmacc.vf v30, fa6, v14
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v14
    add s9, s9, a6
    flw fs8, 0(t1)
    add t1, t1, a4
    vfmacc.vf v26, fa4, v14
    flw fs7, 0(t1)
    add t1, t1, a4
    flw fs6, 0(t1)
    vfmacc.vf v24, fa3, v14
    add t1, t1, a4
    flw fs5, 0(t1)
    add t1, t1, a4
    vfmacc.vf v22, fa2, v14
    flw fs4, 0(t1)
    add t1, t1, a4
    flw fs3, 0(t1)
    vfmacc.vf v20, fs11, v14
    add t1, t1, a4
    flw fs2, 0(t1)
    add t1, t1, a4
    vfmacc.vf v18, fs10, v14
    flw fs1, 0(t1)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    vfmacc.vf v16, fs9, v14
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0

cblas_sgemm_rrr_6__loop_kk_1:
    vfmacc.vf v30, fs8, v12
    vle32.v v14, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    vfmacc.vf v28, fs7, v12
    add s9, s9, a6
    flw fa6, 0(t1)
    add t1, t1, a4
    vfmacc.vf v26, fs6, v12
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    vfmacc.vf v24, fs5, v12
    add t1, t1, a4
    flw fa3, 0(t1)
    add t1, t1, a4
    vfmacc.vf v22, fs4, v12
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    vfmacc.vf v20, fs3, v12
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v18, fs2, v12
    flw fs9, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmacc.vf v16, fs1, v12
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    blt s10, s6, cblas_sgemm_rrr_6__loop_kk_0

cblas_sgemm_rrr_6__epilog:
    vfmacc.vf v30, fa6, v14
    mv t1, s8
    vfmacc.vf v28, fa5, v14
    vse32.v v30, 0(t1)
    vfmacc.vf v26, fa4, v14
    add t1, t1, s11
    vfmacc.vf v24, fa3, v14
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vfmacc.vf v22, fa2, v14
    vse32.v v26, 0(t1)
    add t1, t1, s11
    vfmacc.vf v20, fs11, v14
    vse32.v v24, 0(t1)
    vfmacc.vf v18, fs10, v14
    add t1, t1, s11
    vfmacc.vf v16, fs9, v14
    vse32.v v22, 0(t1)
    add t1, t1, s11
    vse32.v v20, 0(t1)
    add t1, t1, s11
    vse32.v v18, 0(t1)
    add t1, t1, s11
    vse32.v v16, 0(t1)

cblas_sgemm_rrr_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_6__c_col_loop

cblas_sgemm_rrr_6__end_c_col_loop:
    addi s1, s1, -8
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 3
    add s4, s4, t2
    slli t2, a4, 3
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_6__c_row_loop

cblas_sgemm_rrr_6__end_c_row_loop:

cblas_sgemm_rrr_6__exit_gemm:

cblas_sgemm_rrr_6_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_7:

cblas_sgemm_rrr_7__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrr_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrr_7__exit_gemm

cblas_sgemm_rrr_7__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrr_7__exit_gemm

cblas_sgemm_rrr_7__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrr_7__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrr_7__epilog
    vsetvli s3, s0, e32,m8
    slli s2, s3, 2
    slli s3, s3, 2

cblas_sgemm_rrr_7__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_7__loop_kk_1
1:   
    vle32.v v24, 0(s4)
    vfmul.vf v24, v24, fa1
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrr_7__loop_kk_0

cblas_sgemm_rrr_7__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_rrr_7__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_rrr_7__loop_kk_0

cblas_sgemm_rrr_7__epilog:
    vfmacc.vf v24, fa6, v16
    vse32.v v24, 0(s8)

cblas_sgemm_rrr_7__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrr_7__c_col_loop

cblas_sgemm_rrr_7__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrr_7__c_row_loop

cblas_sgemm_rrr_7__end_c_row_loop:

cblas_sgemm_rrr_7__exit_gemm:

cblas_sgemm_rrr_7_jexit:
    j exit_cblas_sgemm_rrr

cblas_sgemm_rrr_8:

cblas_sgemm_rrr_8__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rrr_8__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rrr_8__exit_gemm
    beqz a1, cblas_sgemm_rrr_8__exit_gemm

cblas_sgemm_rrr_8__loop_kk:
    mv s0, a1

cblas_sgemm_rrr_8__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rrr_8__post_scale

cblas_sgemm_rrr_8__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rrr_8__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    vle32.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vle32.v v28, 0(s8)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s8, s8, s11
    vfmacc.vf v24, fa5, v20
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0
    vfmul.vf v28, v28, fa1

cblas_sgemm_rrr_8__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    slli t1, s11, 1
    vle32.v v24, 0(s8)
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 1
    vfmul.vf v24, v24, fa1
    vse32.v v28, 0(s8)
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_rrr_8__loop_ii_scale

cblas_sgemm_rrr_8__epilog_scale:
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    j cblas_sgemm_rrr_8__end_loop_ii

cblas_sgemm_rrr_8__post_scale:

cblas_sgemm_rrr_8__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rrr_8__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    vle32.v v20, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    flw fa5, 0(s10)
    vle32.v v28, 0(s8)
    fmul.s fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    add s10, s10, a4
    add s8, s8, s11
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0

cblas_sgemm_rrr_8__loop_ii:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    slli t1, s11, 1
    vle32.v v24, 0(s8)
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 1
    vfmacc.vf v24, fa5, v20
    vse32.v v28, 0(s8)
    add s8, s8, t1
    vle32.v v28, 0(s8)
    add s8, s8, s11
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_rrr_8__loop_ii

cblas_sgemm_rrr_8__epilog:
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v28, fa6, v20
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1

cblas_sgemm_rrr_8__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rrr_8__loop_jj

cblas_sgemm_rrr_8__end_loop_jj:
    li t1, 4
    add s7, s7, t1
    slli t1, a1, 2
    sub s5, s5, t1
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_sgemm_rrr_8__loop_kk

cblas_sgemm_rrr_8__end_loop_kk:

cblas_sgemm_rrr_8__exit_gemm:

cblas_sgemm_rrr_8_jexit:
    j exit_cblas_sgemm_rrr

exit_cblas_sgemm_rrr:
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
.size cblas_sgemm_rrr, .-cblas_sgemm_rrr

.text
.global cblas_sgemm_ccc
.type cblas_sgemm_ccc, @function

cblas_sgemm_ccc:
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

dispatch_cblas_sgemm_ccc:
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_ccc_0
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_sgemm_ccc_1
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_ccc_2
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_sgemm_ccc_3
1:   
    li s1, 32
    blt a0, s1, 1f
    li s1, 0
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_ccc_4
1:   
    li s1, 32
    blt a0, s1, 1f
    j cblas_sgemm_ccc_5
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_sgemm_ccc_6
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_sgemm_ccc_7
1:   
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_0:

cblas_sgemm_ccc_0__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_0__exit_gemm

cblas_sgemm_ccc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_0__exit_gemm

cblas_sgemm_ccc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_0__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_0__epilog

cblas_sgemm_ccc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v26, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_0__first_kk_1
1:   
    vle32.v v27, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_0__first_kk_0

cblas_sgemm_ccc_0__first_kk_0:
    vfmul.vf v31, v27, fa6
    vle32.v v26, 0(s9)
    vfmul.vf v30, v27, fa5
    mv t1, s10
    vfmul.vf v29, v27, fa4
    flw fa2, 0(t1)
    vfmul.vf v28, v27, fa3
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v31, fa2, v26
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fs11, v26
    mv t1, s10
    vfmacc.vf v29, fs10, v26
    flw fa6, 0(t1)
    vfmacc.vf v28, fs9, v26
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    addi s10, s10, 4
    add s9, s9, a6
    j cblas_sgemm_ccc_0__loop_kk_0

cblas_sgemm_ccc_0__first_kk_1:
    vfmul.vf v31, v26, fa2
    vle32.v v27, 0(s9)
    vfmul.vf v30, v26, fs11
    mv t1, s10
    vfmul.vf v29, v26, fs10
    flw fa6, 0(t1)
    vfmul.vf v28, v26, fs9
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_0__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    vle32.v v26, 0(s9)
    vfmacc.vf v30, fa5, v27
    mv t1, s10
    vfmacc.vf v29, fa4, v27
    flw fa2, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_0__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fs11, v26
    mv t1, s10
    vfmacc.vf v29, fs10, v26
    flw fa6, 0(t1)
    vfmacc.vf v28, fs9, v26
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_0__loop_kk_0

cblas_sgemm_ccc_0__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vse32.v v31, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, s11
    vse32.v v30, 0(t1)
    add t1, t1, s11
    vse32.v v29, 0(t1)
    add t1, t1, s11
    vse32.v v28, 0(t1)

cblas_sgemm_ccc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_0__c_col_loop

cblas_sgemm_ccc_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_0__c_row_loop

cblas_sgemm_ccc_0__end_c_row_loop:

cblas_sgemm_ccc_0__exit_gemm:

cblas_sgemm_ccc_0_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_1:

cblas_sgemm_ccc_1__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_1__exit_gemm

cblas_sgemm_ccc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_1__exit_gemm

cblas_sgemm_ccc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_1__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_1__epilog

cblas_sgemm_ccc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v26, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    add t1, t1, s11
    vfmul.vf v29, v29, fa1
    vle32.v v28, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v28, v28, fa1
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_ccc_1__loop_kk_1
1:   
    vle32.v v27, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    add t1, t1, s11
    vfmul.vf v29, v29, fa1
    vle32.v v28, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v28, v28, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_ccc_1__loop_kk_0

cblas_sgemm_ccc_1__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    vle32.v v26, 0(s9)
    vfmacc.vf v30, fa5, v27
    mv t1, s10
    vfmacc.vf v29, fa4, v27
    flw fa2, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_1__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fs11, v26
    mv t1, s10
    vfmacc.vf v29, fs10, v26
    flw fa6, 0(t1)
    vfmacc.vf v28, fs9, v26
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_1__loop_kk_0

cblas_sgemm_ccc_1__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vse32.v v31, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, s11
    vse32.v v30, 0(t1)
    add t1, t1, s11
    vse32.v v29, 0(t1)
    add t1, t1, s11
    vse32.v v28, 0(t1)

cblas_sgemm_ccc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_1__c_col_loop

cblas_sgemm_ccc_1__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_1__c_row_loop

cblas_sgemm_ccc_1__end_c_row_loop:

cblas_sgemm_ccc_1__exit_gemm:

cblas_sgemm_ccc_1_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_2:

cblas_sgemm_ccc_2__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_2__exit_gemm

cblas_sgemm_ccc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_2__exit_gemm

cblas_sgemm_ccc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_2__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_2__epilog

cblas_sgemm_ccc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v27, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_2__first_kk_1
1:   
    vle32.v v28, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_2__first_kk_0

cblas_sgemm_ccc_2__first_kk_0:
    vfmul.vf v31, v28, fa6
    vle32.v v27, 0(s9)
    vfmul.vf v30, v28, fa5
    mv t1, s10
    vfmul.vf v29, v28, fa4
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v31, fa3, v27
    vle32.v v28, 0(s9)
    vfmacc.vf v30, fa2, v27
    mv t1, s10
    vfmacc.vf v29, fs11, v27
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    addi s10, s10, 4
    add s9, s9, a6
    j cblas_sgemm_ccc_2__loop_kk_0

cblas_sgemm_ccc_2__first_kk_1:
    vfmul.vf v31, v27, fa3
    vle32.v v28, 0(s9)
    vfmul.vf v30, v27, fa2
    mv t1, s10
    vfmul.vf v29, v27, fs11
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_2__loop_kk_0:
    vfmacc.vf v31, fa6, v28
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fa5, v28
    mv t1, s10
    vfmacc.vf v29, fa4, v28
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_2__loop_kk_1:
    vfmacc.vf v31, fa3, v27
    vle32.v v28, 0(s9)
    vfmacc.vf v30, fa2, v27
    mv t1, s10
    vfmacc.vf v29, fs11, v27
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_2__loop_kk_0

cblas_sgemm_ccc_2__epilog:
    vfmacc.vf v31, fa6, v28
    mv t1, s8
    vfmacc.vf v30, fa5, v28
    vfmacc.vf v29, fa4, v28
    vse32.v v31, 0(t1)
    add t1, t1, s11
    vse32.v v30, 0(t1)
    add t1, t1, s11
    vse32.v v29, 0(t1)

cblas_sgemm_ccc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_2__c_col_loop

cblas_sgemm_ccc_2__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_2__c_row_loop

cblas_sgemm_ccc_2__end_c_row_loop:

cblas_sgemm_ccc_2__exit_gemm:

cblas_sgemm_ccc_2_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_3:

cblas_sgemm_ccc_3__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_3__exit_gemm

cblas_sgemm_ccc_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_3__exit_gemm

cblas_sgemm_ccc_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_3__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_3__epilog

cblas_sgemm_ccc_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v27, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v29, v29, fa1
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_ccc_3__loop_kk_1
1:   
    vle32.v v28, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v29, v29, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_ccc_3__loop_kk_0

cblas_sgemm_ccc_3__loop_kk_0:
    vfmacc.vf v31, fa6, v28
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fa5, v28
    mv t1, s10
    vfmacc.vf v29, fa4, v28
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_3__loop_kk_1:
    vfmacc.vf v31, fa3, v27
    vle32.v v28, 0(s9)
    vfmacc.vf v30, fa2, v27
    mv t1, s10
    vfmacc.vf v29, fs11, v27
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_3__loop_kk_0

cblas_sgemm_ccc_3__epilog:
    vfmacc.vf v31, fa6, v28
    mv t1, s8
    vfmacc.vf v30, fa5, v28
    vfmacc.vf v29, fa4, v28
    vse32.v v31, 0(t1)
    add t1, t1, s11
    vse32.v v30, 0(t1)
    add t1, t1, s11
    vse32.v v29, 0(t1)

cblas_sgemm_ccc_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_3__c_col_loop

cblas_sgemm_ccc_3__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_3__c_row_loop

cblas_sgemm_ccc_3__end_c_row_loop:

cblas_sgemm_ccc_3__exit_gemm:

cblas_sgemm_ccc_3_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_4:

cblas_sgemm_ccc_4__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_4__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_4__exit_gemm

cblas_sgemm_ccc_4__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_4__exit_gemm

cblas_sgemm_ccc_4__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_4__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_4__epilog

cblas_sgemm_ccc_4__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    flw fa5, 0(s10)
    vle32.v v29, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_4__first_kk_1
1:   
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_4__first_kk_0

cblas_sgemm_ccc_4__first_kk_0:
    vfmul.vf v31, v30, fa6
    flw fa5, 0(s10)
    vle32.v v29, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v31, fa5, v29
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    j cblas_sgemm_ccc_4__loop_kk_0

cblas_sgemm_ccc_4__first_kk_1:
    vfmul.vf v31, v29, fa5
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_4__loop_kk_0:
    vfmacc.vf v31, fa6, v30
    flw fa5, 0(s10)
    vle32.v v29, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_4__loop_kk_1:
    vfmacc.vf v31, fa5, v29
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_4__loop_kk_0

cblas_sgemm_ccc_4__epilog:
    vfmacc.vf v31, fa6, v30
    vse32.v v31, 0(s8)

cblas_sgemm_ccc_4__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_4__c_col_loop

cblas_sgemm_ccc_4__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_4__c_row_loop

cblas_sgemm_ccc_4__end_c_row_loop:

cblas_sgemm_ccc_4__exit_gemm:

cblas_sgemm_ccc_4_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_5:

cblas_sgemm_ccc_5__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_5__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_5__exit_gemm

cblas_sgemm_ccc_5__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_5__exit_gemm

cblas_sgemm_ccc_5__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_5__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_5__epilog

cblas_sgemm_ccc_5__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v31, 0(s4)
    vfmul.vf v31, v31, fa1
    flw fa5, 0(s10)
    vle32.v v29, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_5__loop_kk_1
1:   
    vle32.v v31, 0(s4)
    vfmul.vf v31, v31, fa1
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_ccc_5__loop_kk_0

cblas_sgemm_ccc_5__loop_kk_0:
    vfmacc.vf v31, fa6, v30
    flw fa5, 0(s10)
    vle32.v v29, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_5__loop_kk_1:
    vfmacc.vf v31, fa5, v29
    flw fa6, 0(s10)
    vle32.v v30, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_5__loop_kk_0

cblas_sgemm_ccc_5__epilog:
    vfmacc.vf v31, fa6, v30
    vse32.v v31, 0(s8)

cblas_sgemm_ccc_5__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_5__c_col_loop

cblas_sgemm_ccc_5__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_5__c_row_loop

cblas_sgemm_ccc_5__end_c_row_loop:

cblas_sgemm_ccc_5__exit_gemm:

cblas_sgemm_ccc_5_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_6:

cblas_sgemm_ccc_6__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m1
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
    j cblas_sgemm_ccc_6__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_ccc_6__exit_gemm

cblas_sgemm_ccc_6__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_ccc_6__exit_gemm

cblas_sgemm_ccc_6__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_ccc_6__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_ccc_6__epilog

cblas_sgemm_ccc_6__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v26, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    add t1, t1, s11
    vfmul.vf v29, v29, fa1
    vle32.v v28, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v28, v28, fa1
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_ccc_6__loop_kk_1
1:   
    vle32.v v27, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v31, 0(t1)
    add t1, t1, s11
    vfmul.vf v31, v31, fa1
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v29, 0(t1)
    add t1, t1, s11
    vfmul.vf v29, v29, fa1
    vle32.v v28, 0(t1)
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v28, v28, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_ccc_6__loop_kk_0

cblas_sgemm_ccc_6__loop_kk_0:
    vfmacc.vf v31, fa6, v27
    vle32.v v26, 0(s9)
    vfmacc.vf v30, fa5, v27
    mv t1, s10
    vfmacc.vf v29, fa4, v27
    flw fa2, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_ccc_6__loop_kk_1:
    vfmacc.vf v31, fa2, v26
    vle32.v v27, 0(s9)
    vfmacc.vf v30, fs11, v26
    mv t1, s10
    vfmacc.vf v29, fs10, v26
    flw fa6, 0(t1)
    vfmacc.vf v28, fs9, v26
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_ccc_6__loop_kk_0

cblas_sgemm_ccc_6__epilog:
    vfmacc.vf v31, fa6, v27
    mv t1, s8
    vfmacc.vf v30, fa5, v27
    vfmacc.vf v29, fa4, v27
    vse32.v v31, 0(t1)
    vfmacc.vf v28, fa3, v27
    add t1, t1, s11
    vse32.v v30, 0(t1)
    add t1, t1, s11
    vse32.v v29, 0(t1)
    add t1, t1, s11
    vse32.v v28, 0(t1)

cblas_sgemm_ccc_6__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_ccc_6__c_col_loop

cblas_sgemm_ccc_6__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_ccc_6__c_row_loop

cblas_sgemm_ccc_6__end_c_row_loop:

cblas_sgemm_ccc_6__exit_gemm:

cblas_sgemm_ccc_6_jexit:
    j exit_cblas_sgemm_ccc

cblas_sgemm_ccc_7:

cblas_sgemm_ccc_7__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_ccc_7__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_ccc_7__exit_gemm
    beqz a1, cblas_sgemm_ccc_7__exit_gemm

cblas_sgemm_ccc_7__loop_kk:
    mv s0, a1

cblas_sgemm_ccc_7__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_ccc_7__post_scale

cblas_sgemm_ccc_7__prolog_scale:
    slli s6, a0, 2
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccc_7__epilog_scale
    vsetvli s3, s0, e32,m4
    mul s2, s3, s11
    slli s3, s3, 2
    vlse32.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse32.v v28, 0(s8), s11
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vsse32.v v28, 0(s8), s11
    addi s8, s8, 4
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse32.v v24, 0(s8), s11
    addi s8, s8, 4
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vlse32.v v28, 0(s8), s11
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    addi s8, s8, 4
    vfmacc.vf v24, fa5, v20
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0

cblas_sgemm_ccc_7__loop_ii_scale:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    li t1, 8
    sub s8, s8, t1
    vsse32.v v24, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    li t1, 8
    vlse32.v v24, 0(s8), s11
    addi s8, s8, 4
    sub s8, s8, t1
    li t1, 8
    vfmul.vf v24, v24, fa1
    vsse32.v v28, 0(s8), s11
    add s8, s8, t1
    vfmacc.vf v24, fa5, v20
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_ccc_7__loop_ii_scale

cblas_sgemm_ccc_7__epilog_scale:
    li t1, 8
    sub s8, s8, t1
    vsse32.v v24, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    addi s8, s8, 4
    addi s10, s10, 4
    vfmacc.vf v28, fa6, v20
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    j cblas_sgemm_ccc_7__end_loop_ii

cblas_sgemm_ccc_7__post_scale:

cblas_sgemm_ccc_7__prolog:
    slli s6, a0, 2
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccc_7__epilog
    vsetvli s3, s0, e32,m4
    mul s2, s3, s11
    slli s3, s3, 2
    vlse32.v v20, 0(s5), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse32.v v28, 0(s8), s11
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v28, fa6, v20
    vsse32.v v28, 0(s8), s11
    addi s8, s8, 4
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse32.v v24, 0(s8), s11
    addi s8, s8, 4
    flw fa5, 0(s10)
    vlse32.v v28, 0(s8), s11
    fmul.s fa5, fa5, fa0
    vfmacc.vf v24, fa5, v20
    addi s10, s10, 4
    addi s8, s8, 4
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0

cblas_sgemm_ccc_7__loop_ii:
    vfmacc.vf v28, fa6, v20
    flw fa5, 0(s10)
    li t1, 8
    sub s8, s8, t1
    vsse32.v v24, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    li t1, 8
    vlse32.v v24, 0(s8), s11
    addi s8, s8, 4
    sub s8, s8, t1
    li t1, 8
    vfmacc.vf v24, fa5, v20
    vsse32.v v28, 0(s8), s11
    add s8, s8, t1
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    flw fa6, 0(s10)
    addi s10, s10, 4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_ccc_7__loop_ii

cblas_sgemm_ccc_7__epilog:
    li t1, 8
    sub s8, s8, t1
    vsse32.v v24, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    addi s8, s8, 4
    addi s10, s10, 4
    vfmacc.vf v28, fa6, v20
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1

cblas_sgemm_ccc_7__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s2, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_ccc_7__loop_jj

cblas_sgemm_ccc_7__end_loop_jj:
    li t1, 1
    mul t1, t1, a4
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    mul t1, a1, s11
    sub s4, s4, t1
    li t1, 4
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_sgemm_ccc_7__loop_kk

cblas_sgemm_ccc_7__end_loop_kk:

cblas_sgemm_ccc_7__exit_gemm:

cblas_sgemm_ccc_7_jexit:
    j exit_cblas_sgemm_ccc

exit_cblas_sgemm_ccc:
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
.size cblas_sgemm_ccc, .-cblas_sgemm_ccc

.text
.global cblas_sgemm_rcc
.type cblas_sgemm_rcc, @function

cblas_sgemm_rcc:
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

dispatch_cblas_sgemm_rcc:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    j cblas_sgemm_rcc_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_sgemm_rcc_1
1:   
    j exit_cblas_sgemm_rcc

cblas_sgemm_rcc_0:

cblas_sgemm_rcc_0__enter:
    mv t1, a3
    mv a3, a5
    mv a5, t1
    mv t1, a4
    mv a4, a6
    mv a6, t1
    mv t1, a0
    mv a0, a1
    mv a1, t1
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m2
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
    j cblas_sgemm_rcc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcc_0__exit_gemm
    beqz a1, cblas_sgemm_rcc_0__exit_gemm

cblas_sgemm_rcc_0__loop_kk:
    mv s0, a1

cblas_sgemm_rcc_0__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rcc_0__post_scale

cblas_sgemm_rcc_0__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcc_0__epilog_scale
    mv t0, s5
    vlse32.v v22, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v20, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v18, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v30, 0(s8)
    vfmul.vf v30, v30, fa1
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse32.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v26, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v26, v26, fa1
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v24, 0(s8)
    mv t0, s10
    vfmacc.vf v26, fs8, v22
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    vfmul.vf v24, v24, fa1
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v26, fs7, v20
    vle32.v v30, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v24, fs4, v22
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    vfmul.vf v30, v30, fa1
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v26, fs6, v18
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v28, v28, fa1
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    vfmacc.vf v26, fs5, v16
    flw fs9, 12(t0)
    vfmacc.vf v24, fs3, v20
    vfmacc.vf v24, fs2, v18
    vfmacc.vf v24, fs1, v16

cblas_sgemm_rcc_0__loop_ii_scale:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle32.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    vfmacc.vf v30, fa3, v16
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vfmacc.vf v28, fs9, v16
    vle32.v v24, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmul.vf v26, v26, fa1
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmul.vf v24, v24, fa1
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    slli t1, s11, 2
    vfmacc.vf v26, fs8, v22
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 2
    vfmacc.vf v24, fs4, v22
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v26, fs7, v20
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v24, fs3, v20
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v26, fs6, v18
    vle32.v v30, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v24, fs2, v18
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    vfmacc.vf v26, fs5, v16
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v24, fs1, v16
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v30, v30, fa1
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    vfmul.vf v28, v28, fa1
    flw fs9, 12(t0)
    blt s8, s6, cblas_sgemm_rcc_0__loop_ii_scale

cblas_sgemm_rcc_0__epilog_scale:
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
    vse32.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_rcc_0__end_loop_ii

cblas_sgemm_rcc_0__post_scale:

cblas_sgemm_rcc_0__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcc_0__epilog
    mv t0, s5
    vlse32.v v22, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v20, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v18, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v30, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse32.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v26, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v26, fs8, v22
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v24, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v26, fs7, v20
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    vfmacc.vf v24, fs4, v22
    flw fs1, 12(t0)
    vle32.v v30, 0(s8)
    mv t0, s10
    vfmacc.vf v26, fs6, v18
    add s8, s8, s11
    add s10, s10, a4
    flw fa6, 0(t0)
    vfmacc.vf v24, fs3, v20
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v26, fs5, v16
    vle32.v v28, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v24, fs2, v18
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    vfmacc.vf v24, fs1, v16

cblas_sgemm_rcc_0__loop_ii:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle32.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    vfmacc.vf v30, fa3, v16
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vfmacc.vf v28, fs9, v16
    vle32.v v24, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v26, fs8, v22
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmacc.vf v24, fs4, v22
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    slli t1, s11, 2
    vfmacc.vf v26, fs7, v20
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 2
    vfmacc.vf v24, fs3, v20
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v26, fs6, v18
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v24, fs2, v18
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v26, fs5, v16
    vle32.v v30, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v24, fs1, v16
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v28, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    blt s8, s6, cblas_sgemm_rcc_0__loop_ii

cblas_sgemm_rcc_0__epilog:
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
    vse32.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcc_0__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcc_0__loop_jj

cblas_sgemm_rcc_0__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcc_0__loop_kk

cblas_sgemm_rcc_0__end_loop_kk:

cblas_sgemm_rcc_0__exit_gemm:

cblas_sgemm_rcc_0_jexit:
    j exit_cblas_sgemm_rcc

cblas_sgemm_rcc_1:

cblas_sgemm_rcc_1__enter:
    mv t1, a3
    mv a3, a5
    mv a5, t1
    mv t1, a4
    mv a4, a6
    mv a6, t1
    mv t1, a0
    mv a0, a1
    mv a1, t1
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m2
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
    j cblas_sgemm_rcc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcc_1__exit_gemm
    beqz a1, cblas_sgemm_rcc_1__exit_gemm

cblas_sgemm_rcc_1__loop_kk:
    mv s0, a1

cblas_sgemm_rcc_1__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rcc_1__post_scale

cblas_sgemm_rcc_1__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcc_1__epilog_scale
    mv t0, s5
    vlse32.v v22, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v20, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v18, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v30, 0(s8)
    vfmul.vf v30, v30, fa1
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    flw fa5, 4(t0)
    fmul.s fa5, fa5, fa0
    flw fa4, 8(t0)
    fmul.s fa4, fa4, fa0
    flw fa3, 12(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse32.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v26, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v26, v26, fa1
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v24, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v26, fs8, v22
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    vfmul.vf v24, v24, fa1
    mv t0, s10
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmacc.vf v26, fs7, v20
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    fmul.s fs4, fs4, fa0
    vfmacc.vf v24, fs4, v22
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    vfmacc.vf v26, fs6, v18
    add s8, s8, s11
    vle32.v v30, 0(s8)
    add s10, s10, a4
    vfmacc.vf v24, fs3, v20
    mv t0, s10
    add s8, s8, s11
    flw fa6, 0(t0)
    vfmul.vf v30, v30, fa1
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v26, fs5, v16
    vle32.v v28, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    vfmacc.vf v24, fs2, v18
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    add s10, s10, a4
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    vfmacc.vf v24, fs1, v16
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4

cblas_sgemm_rcc_1__loop_ii_scale:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle32.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    vfmacc.vf v30, fa3, v16
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vfmacc.vf v28, fs9, v16
    vle32.v v24, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    vfmul.vf v26, v26, fa1
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    vfmul.vf v24, v24, fa1
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    vfmacc.vf v26, fs8, v22
    flw fs1, 12(t0)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    vfmacc.vf v24, fs4, v22
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    add s8, s8, s11
    vfmacc.vf v26, fs7, v20
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    vfmacc.vf v24, fs3, v20
    vse32.v v30, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    vfmacc.vf v26, fs6, v18
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fs2, v18
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 3
    vfmacc.vf v26, fs5, v16
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v24, fs1, v16
    vle32.v v30, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v30, v30, fa1
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v28, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_sgemm_rcc_1__loop_ii_scale

cblas_sgemm_rcc_1__epilog_scale:
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
    vse32.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_rcc_1__end_loop_ii

cblas_sgemm_rcc_1__post_scale:

cblas_sgemm_rcc_1__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcc_1__epilog
    mv t0, s5
    vlse32.v v22, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v20, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v18, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v16, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v30, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    flw fa5, 4(t0)
    fmul.s fa5, fa5, fa0
    flw fa4, 8(t0)
    fmul.s fa4, fa4, fa0
    flw fa3, 12(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v30, fa6, v22
    vfmacc.vf v30, fa5, v20
    vfmacc.vf v30, fa4, v18
    vfmacc.vf v30, fa3, v16
    vse32.v v30, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v26, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v24, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v26, fs8, v22
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmacc.vf v26, fs7, v20
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    fmul.s fs4, fs4, fa0
    vfmacc.vf v24, fs4, v22
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    vfmacc.vf v26, fs6, v18
    add s8, s8, s11
    vle32.v v30, 0(s8)
    add s10, s10, a4
    vfmacc.vf v24, fs3, v20
    mv t0, s10
    add s8, s8, s11
    flw fa6, 0(t0)
    vfmacc.vf v26, fs5, v16
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v24, fs2, v18
    vle32.v v28, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    add s10, s10, a4
    vfmacc.vf v24, fs1, v16
    mv t0, s10
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4

cblas_sgemm_rcc_1__loop_ii:
    vfmacc.vf v30, fa6, v22
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v26, 0(s8)
    vfmacc.vf v28, fa2, v22
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    vfmacc.vf v30, fa5, v20
    mul t1, t1, s11
    sub s8, s8, t1
    vfmacc.vf v28, fs11, v20
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v30, fa4, v18
    add s8, s8, t1
    vle32.v v26, 0(s8)
    mv t0, s10
    vfmacc.vf v28, fs10, v18
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    vfmacc.vf v30, fa3, v16
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vfmacc.vf v28, fs9, v16
    vle32.v v24, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    vfmacc.vf v26, fs8, v22
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    vfmacc.vf v26, fs7, v20
    flw fs1, 12(t0)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    vfmacc.vf v24, fs4, v22
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    add s8, s8, s11
    vfmacc.vf v26, fs6, v18
    add s10, s10, a4
    slli t1, s11, 2
    sub s8, s8, t1
    vfmacc.vf v24, fs3, v20
    vse32.v v30, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    vfmacc.vf v26, fs5, v16
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fs2, v18
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    vfmacc.vf v24, fs1, v16
    vle32.v v30, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v28, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    add s8, s8, s11
    add s10, s10, a4
    blt s8, s6, cblas_sgemm_rcc_1__loop_ii

cblas_sgemm_rcc_1__epilog:
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
    vse32.v v26, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v30, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcc_1__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcc_1__loop_jj

cblas_sgemm_rcc_1__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcc_1__loop_kk

cblas_sgemm_rcc_1__end_loop_kk:

cblas_sgemm_rcc_1__exit_gemm:

cblas_sgemm_rcc_1_jexit:
    j exit_cblas_sgemm_rcc

exit_cblas_sgemm_rcc:
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
.size cblas_sgemm_rcc, .-cblas_sgemm_rcc

.text
.global cblas_sgemm_crc
.type cblas_sgemm_crc, @function

cblas_sgemm_crc:
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

dispatch_cblas_sgemm_crc:
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 4
    blt a1, s1, 1f
    j cblas_sgemm_crc_0
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    li s1, 3
    blt a1, s1, 1f
    j cblas_sgemm_crc_1
1:   
    li s1, 16
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_crc_2
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_crc_3
1:   
    j exit_cblas_sgemm_crc

cblas_sgemm_crc_0:

cblas_sgemm_crc_0__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m2
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
    j cblas_sgemm_crc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crc_0__exit_gemm

cblas_sgemm_crc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crc_0__exit_gemm

cblas_sgemm_crc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crc_0__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crc_0__epilog

cblas_sgemm_crc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v20, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    add t1, t1, s11
    vfmul.vf v26, v26, fa1
    vle32.v v24, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v24, v24, fa1
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_crc_0__loop_kk_1
1:   
    vle32.v v22, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    add t1, t1, s11
    vfmul.vf v26, v26, fa1
    vle32.v v24, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v24, v24, fa1
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_crc_0__loop_kk_0

cblas_sgemm_crc_0__loop_kk_0:
    vfmacc.vf v30, fa6, v22
    vle32.v v20, 0(s9)
    mv t1, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v22
    add s9, s9, a6
    flw fa2, 0(t1)
    flw fs11, 4(t1)
    vfmacc.vf v26, fa4, v22
    flw fs10, 8(t1)
    flw fs9, 12(t1)
    fmul.s fa2, fa2, fa0
    vfmacc.vf v24, fa3, v22
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0

cblas_sgemm_crc_0__loop_kk_1:
    vfmacc.vf v30, fa2, v20
    vle32.v v22, 0(s9)
    mv t1, s10
    add s10, s10, a4
    vfmacc.vf v28, fs11, v20
    add s9, s9, a6
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    vfmacc.vf v26, fs10, v20
    flw fa4, 8(t1)
    flw fa3, 12(t1)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v24, fs9, v20
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    blt s10, s6, cblas_sgemm_crc_0__loop_kk_0

cblas_sgemm_crc_0__epilog:
    vfmacc.vf v30, fa6, v22
    mv t1, s8
    vfmacc.vf v28, fa5, v22
    vse32.v v30, 0(t1)
    vfmacc.vf v26, fa4, v22
    add t1, t1, s11
    vfmacc.vf v24, fa3, v22
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vse32.v v26, 0(t1)
    add t1, t1, s11
    vse32.v v24, 0(t1)

cblas_sgemm_crc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crc_0__c_col_loop

cblas_sgemm_crc_0__end_c_col_loop:
    addi s1, s1, -4
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 2
    add s4, s4, t2
    li t2, 16
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crc_0__c_row_loop

cblas_sgemm_crc_0__end_c_row_loop:

cblas_sgemm_crc_0__exit_gemm:

cblas_sgemm_crc_0_jexit:
    j exit_cblas_sgemm_crc

cblas_sgemm_crc_1:

cblas_sgemm_crc_1__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m2
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
    j cblas_sgemm_crc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crc_1__exit_gemm

cblas_sgemm_crc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crc_1__exit_gemm

cblas_sgemm_crc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crc_1__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crc_1__epilog

cblas_sgemm_crc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v22, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v26, v26, fa1
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_crc_1__loop_kk_1
1:   
    vle32.v v24, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vle32.v v30, 0(t1)
    add t1, t1, s11
    vfmul.vf v30, v30, fa1
    vle32.v v28, 0(t1)
    add t1, t1, s11
    vfmul.vf v28, v28, fa1
    vle32.v v26, 0(t1)
    mv t1, s10
    add s10, s10, a4
    vfmul.vf v26, v26, fa1
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_crc_1__loop_kk_0

cblas_sgemm_crc_1__loop_kk_0:
    vfmacc.vf v30, fa6, v24
    vle32.v v22, 0(s9)
    mv t1, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v24
    add s9, s9, a6
    flw fa3, 0(t1)
    flw fa2, 4(t1)
    vfmacc.vf v26, fa4, v24
    flw fs11, 8(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0

cblas_sgemm_crc_1__loop_kk_1:
    vfmacc.vf v30, fa3, v22
    vle32.v v24, 0(s9)
    mv t1, s10
    add s10, s10, a4
    vfmacc.vf v28, fa2, v22
    add s9, s9, a6
    flw fa6, 0(t1)
    flw fa5, 4(t1)
    vfmacc.vf v26, fs11, v22
    flw fa4, 8(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    blt s10, s6, cblas_sgemm_crc_1__loop_kk_0

cblas_sgemm_crc_1__epilog:
    vfmacc.vf v30, fa6, v24
    mv t1, s8
    vfmacc.vf v28, fa5, v24
    vse32.v v30, 0(t1)
    vfmacc.vf v26, fa4, v24
    add t1, t1, s11
    vse32.v v28, 0(t1)
    add t1, t1, s11
    vse32.v v26, 0(t1)

cblas_sgemm_crc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crc_1__c_col_loop

cblas_sgemm_crc_1__end_c_col_loop:
    addi s1, s1, -3
    slli t2, a1, 2
    sub s4, s4, t2
    li t2, 3
    mul t2, t2, s11
    add s4, s4, t2
    li t2, 12
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crc_1__c_row_loop

cblas_sgemm_crc_1__end_c_row_loop:

cblas_sgemm_crc_1__exit_gemm:

cblas_sgemm_crc_1_jexit:
    j exit_cblas_sgemm_crc

cblas_sgemm_crc_2:

cblas_sgemm_crc_2__enter:
    mv t2, a3
    mv a3, a5
    mv a5, t2
    mv t2, a4
    mv a4, a6
    mv a6, t2
    mv t2, a0
    mv a0, a1
    mv a1, t2
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m2
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
    j cblas_sgemm_crc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a1, 0(s1)
    sd a0, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crc_2__exit_gemm

cblas_sgemm_crc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crc_2__exit_gemm

cblas_sgemm_crc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crc_2__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crc_2__epilog

cblas_sgemm_crc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v30, 0(s4)
    vfmul.vf v30, v30, fa1
    flw fa5, 0(s10)
    vle32.v v26, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crc_2__loop_kk_1
1:   
    vle32.v v30, 0(s4)
    vfmul.vf v30, v30, fa1
    flw fa6, 0(s10)
    vle32.v v28, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crc_2__loop_kk_0

cblas_sgemm_crc_2__loop_kk_0:
    vfmacc.vf v30, fa6, v28
    flw fa5, 0(s10)
    vle32.v v26, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crc_2__loop_kk_1:
    vfmacc.vf v30, fa5, v26
    flw fa6, 0(s10)
    vle32.v v28, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_crc_2__loop_kk_0

cblas_sgemm_crc_2__epilog:
    vfmacc.vf v30, fa6, v28
    vse32.v v30, 0(s8)

cblas_sgemm_crc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crc_2__c_col_loop

cblas_sgemm_crc_2__end_c_col_loop:
    addi s1, s1, -1
    slli t2, a1, 2
    sub s4, s4, t2
    slli t2, s11, 0
    add s4, s4, t2
    li t2, 4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crc_2__c_row_loop

cblas_sgemm_crc_2__end_c_row_loop:

cblas_sgemm_crc_2__exit_gemm:

cblas_sgemm_crc_2_jexit:
    j exit_cblas_sgemm_crc

cblas_sgemm_crc_3:

cblas_sgemm_crc_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m8
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_crc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_crc_3__exit_gemm

cblas_sgemm_crc_3__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_crc_3__exit_gemm

cblas_sgemm_crc_3__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_crc_3__prolog:
    mul s6, a2, a4
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_crc_3__epilog
    vsetvli s3, s0, e32,m8
    mul s2, s3, s11
    slli s3, s3, 2

cblas_sgemm_crc_3__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vlse32.v v24, 0(s4), s11
    vfmul.vf v24, v24, fa1
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crc_3__loop_kk_1
1:   
    vlse32.v v24, 0(s4), s11
    vfmul.vf v24, v24, fa1
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_crc_3__loop_kk_0

cblas_sgemm_crc_3__loop_kk_0:
    vfmacc.vf v24, fa6, v16
    flw fa5, 0(s10)
    vle32.v v8, 0(s9)
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    add s9, s9, a6

cblas_sgemm_crc_3__loop_kk_1:
    vfmacc.vf v24, fa5, v8
    flw fa6, 0(s10)
    vle32.v v16, 0(s9)
    fmul.s fa6, fa6, fa0
    add s10, s10, a4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_crc_3__loop_kk_0

cblas_sgemm_crc_3__epilog:
    vfmacc.vf v24, fa6, v16
    vsse32.v v24, 0(s8), s11

cblas_sgemm_crc_3__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_crc_3__c_col_loop

cblas_sgemm_crc_3__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 4
    add s4, s4, t2
    li t2, 4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_crc_3__c_row_loop

cblas_sgemm_crc_3__end_c_row_loop:

cblas_sgemm_crc_3__exit_gemm:

cblas_sgemm_crc_3_jexit:
    j exit_cblas_sgemm_crc

exit_cblas_sgemm_crc:
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
.size cblas_sgemm_crc, .-cblas_sgemm_crc

.text
.global cblas_sgemm_rrc
.type cblas_sgemm_rrc, @function

cblas_sgemm_rrc:
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

dispatch_cblas_sgemm_rrc:
    li s1, 4
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_rrc_0
1:   
    li s1, 3
    blt a0, s1, 1f
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_rrc_1
1:   
    li s1, 2
    blt a2, s1, 1f
    j cblas_sgemm_rrc_2
1:   
    li s1, 2
    blt a0, s1, 1f
    j cblas_sgemm_rrc_3
1:   
    j exit_cblas_sgemm_rrc

cblas_sgemm_rrc_0:

cblas_sgemm_rrc_0__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 4
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrc_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrc_0__exit_gemm

cblas_sgemm_rrc_0__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrc_0__exit_gemm

cblas_sgemm_rrc_0__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrc_0__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrc_0__epilog
    vsetvli s3, s0, e32,m4
    mul s2, s3, s11
    slli s3, s3, 2

cblas_sgemm_rrc_0__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v8, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vlse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v28, v28, fa1
    vlse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v24, v24, fa1
    vlse32.v v20, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v20, v20, fa1
    vlse32.v v16, 0(t1), s11
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    mv s8, s4
    j cblas_sgemm_rrc_0__loop_kk_1
1:   
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vlse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v28, v28, fa1
    vlse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v24, v24, fa1
    vlse32.v v20, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v20, v20, fa1
    vlse32.v v16, 0(t1), s11
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv s8, s4
    j cblas_sgemm_rrc_0__loop_kk_0

cblas_sgemm_rrc_0__loop_kk_0:
    vfmacc.vf v28, fa6, v12
    vle32.v v8, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v12
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    add t1, t1, a4
    flw fs10, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fa4, v12
    flw fs9, 0(t1)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fa3, v12

cblas_sgemm_rrc_0__loop_kk_1:
    vfmacc.vf v28, fa2, v8
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fs11, v8
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    add t1, t1, a4
    vfmacc.vf v20, fs10, v8
    flw fa3, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs9, v8
    blt s10, s6, cblas_sgemm_rrc_0__loop_kk_0

cblas_sgemm_rrc_0__epilog:
    vfmacc.vf v28, fa6, v12
    mv t1, s8
    vfmacc.vf v24, fa5, v12
    vsse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmacc.vf v20, fa4, v12
    vfmacc.vf v16, fa3, v12
    vsse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vsse32.v v20, 0(t1), s11
    addi t1, t1, 4
    vsse32.v v16, 0(t1), s11

cblas_sgemm_rrc_0__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrc_0__c_col_loop

cblas_sgemm_rrc_0__end_c_col_loop:
    addi s1, s1, -4
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 16
    add s4, s4, t2
    slli t2, a4, 2
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrc_0__c_row_loop

cblas_sgemm_rrc_0__end_c_row_loop:

cblas_sgemm_rrc_0__exit_gemm:

cblas_sgemm_rrc_0_jexit:
    j exit_cblas_sgemm_rrc

cblas_sgemm_rrc_1:

cblas_sgemm_rrc_1__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 3
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrc_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrc_1__exit_gemm

cblas_sgemm_rrc_1__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrc_1__exit_gemm

cblas_sgemm_rrc_1__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrc_1__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrc_1__epilog
    vsetvli s3, s0, e32,m4
    mul s2, s3, s11
    slli s3, s3, 2

cblas_sgemm_rrc_1__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vle32.v v12, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vlse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v28, v28, fa1
    vlse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v24, v24, fa1
    vlse32.v v20, 0(t1), s11
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    mv s8, s4
    j cblas_sgemm_rrc_1__loop_kk_1
1:   
    vle32.v v16, 0(s9)
    mv t1, s4
    add s9, s9, a6
    vlse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v28, v28, fa1
    vlse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vfmul.vf v24, v24, fa1
    vlse32.v v20, 0(t1), s11
    mv t1, s10
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    mv s8, s4
    j cblas_sgemm_rrc_1__loop_kk_0

cblas_sgemm_rrc_1__loop_kk_0:
    vfmacc.vf v28, fa6, v16
    vle32.v v12, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa5, v16
    flw fa3, 0(t1)
    add t1, t1, a4
    flw fa2, 0(t1)
    add t1, t1, a4
    flw fs11, 0(t1)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v20, fa4, v16
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0

cblas_sgemm_rrc_1__loop_kk_1:
    vfmacc.vf v28, fa3, v12
    vle32.v v16, 0(s9)
    mv t1, s10
    addi s10, s10, 4
    add s9, s9, a6
    vfmacc.vf v24, fa2, v12
    flw fa6, 0(t1)
    add t1, t1, a4
    flw fa5, 0(t1)
    add t1, t1, a4
    flw fa4, 0(t1)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v20, fs11, v12
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    blt s10, s6, cblas_sgemm_rrc_1__loop_kk_0

cblas_sgemm_rrc_1__epilog:
    vfmacc.vf v28, fa6, v16
    mv t1, s8
    vfmacc.vf v24, fa5, v16
    vsse32.v v28, 0(t1), s11
    addi t1, t1, 4
    vfmacc.vf v20, fa4, v16
    vsse32.v v24, 0(t1), s11
    addi t1, t1, 4
    vsse32.v v20, 0(t1), s11

cblas_sgemm_rrc_1__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrc_1__c_col_loop

cblas_sgemm_rrc_1__end_c_col_loop:
    addi s1, s1, -3
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 12
    add s4, s4, t2
    li t2, 3
    mul t2, t2, a4
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrc_1__c_row_loop

cblas_sgemm_rrc_1__end_c_row_loop:

cblas_sgemm_rrc_1__exit_gemm:

cblas_sgemm_rrc_1_jexit:
    j exit_cblas_sgemm_rrc

cblas_sgemm_rrc_2:

cblas_sgemm_rrc_2__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t2, -1
    vsetvli s3, t2, e32, m4
    li t2, 1
    remu t2, a0, t2
    sub a0, a0, t2
    li t2, 1
    bltu t2, a2, 1f
    li a2, 0
    j cblas_sgemm_rrc_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s1, a0
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s8, 0
    beqz s1, cblas_sgemm_rrc_2__exit_gemm

cblas_sgemm_rrc_2__c_row_loop:
    mv s0, a1
    beqz s0, cblas_sgemm_rrc_2__exit_gemm

cblas_sgemm_rrc_2__c_col_loop:
    mv s9, s5
    mv s10, s7

cblas_sgemm_rrc_2__prolog:
    slli s6, a2, 2
    add s6, s6, s7
    bge s10, s6, cblas_sgemm_rrc_2__epilog
    vsetvli s3, s0, e32,m4
    mul s2, s3, s11
    slli s3, s3, 2

cblas_sgemm_rrc_2__normal_startup:
    andi t2, a2, 1
    bnez t2, 1f
    vlse32.v v28, 0(s4), s11
    vfmul.vf v28, v28, fa1
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrc_2__loop_kk_1
1:   
    vlse32.v v28, 0(s4), s11
    vfmul.vf v28, v28, fa1
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    mv s8, s4
    j cblas_sgemm_rrc_2__loop_kk_0

cblas_sgemm_rrc_2__loop_kk_0:
    vfmacc.vf v28, fa6, v24
    flw fa5, 0(s10)
    vle32.v v20, 0(s9)
    fmul.s fa5, fa5, fa0
    addi s10, s10, 4
    add s9, s9, a6

cblas_sgemm_rrc_2__loop_kk_1:
    vfmacc.vf v28, fa5, v20
    flw fa6, 0(s10)
    vle32.v v24, 0(s9)
    fmul.s fa6, fa6, fa0
    addi s10, s10, 4
    add s9, s9, a6
    blt s10, s6, cblas_sgemm_rrc_2__loop_kk_0

cblas_sgemm_rrc_2__epilog:
    vfmacc.vf v28, fa6, v24
    vsse32.v v28, 0(s8), s11

cblas_sgemm_rrc_2__end_loop_kk:
    slli t2, s2, 0
    add s4, s4, t2
    slli t2, s3, 0
    add s5, s5, t2
    slli t2, s3, 0
    srai t2, t2, 2
    sub s0, s0, t2
    bnez s0, cblas_sgemm_rrc_2__c_col_loop

cblas_sgemm_rrc_2__end_c_col_loop:
    addi s1, s1, -1
    mul t2, s11, a1
    sub s4, s4, t2
    li t2, 4
    add s4, s4, t2
    slli t2, a4, 0
    add s7, s7, t2
    mv s5, a5
    bnez s1, cblas_sgemm_rrc_2__c_row_loop

cblas_sgemm_rrc_2__end_c_row_loop:

cblas_sgemm_rrc_2__exit_gemm:

cblas_sgemm_rrc_2_jexit:
    j exit_cblas_sgemm_rrc

cblas_sgemm_rrc_3:

cblas_sgemm_rrc_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m2
    li t1, 1
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 3
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rrc_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    mul s2, s3, s11
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rrc_3__exit_gemm
    beqz a1, cblas_sgemm_rrc_3__exit_gemm

cblas_sgemm_rrc_3__loop_kk:
    mv s0, a1

cblas_sgemm_rrc_3__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rrc_3__post_scale

cblas_sgemm_rrc_3__prolog_scale:
    slli s6, a0, 2
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rrc_3__epilog_scale
    vsetvli s3, s0, e32,m2
    mul s2, s3, s11
    slli s3, s3, 2
    vle32.v v26, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse32.v v30, 0(s8), s11
    vfmul.vf v30, v30, fa1
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v30, fa6, v26
    vsse32.v v30, 0(s8), s11
    addi s8, s8, 4
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    vfmul.vf v28, v28, fa1
    flw fa5, 0(s10)
    vlse32.v v30, 0(s8), s11
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    addi s8, s8, 4
    vfmacc.vf v28, fa5, v26
    vfmul.vf v30, v30, fa1
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0

cblas_sgemm_rrc_3__loop_ii_scale:
    vfmacc.vf v30, fa6, v26
    flw fa5, 0(s10)
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    li t1, 8
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    sub s8, s8, t1
    li t1, 8
    vfmul.vf v28, v28, fa1
    vsse32.v v30, 0(s8), s11
    add s8, s8, t1
    vfmacc.vf v28, fa5, v26
    vlse32.v v30, 0(s8), s11
    addi s8, s8, 4
    vfmul.vf v30, v30, fa1
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_rrc_3__loop_ii_scale

cblas_sgemm_rrc_3__epilog_scale:
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    addi s8, s8, 4
    add s10, s10, a4
    vfmacc.vf v30, fa6, v26
    li t1, 8
    sub s8, s8, t1
    vsse32.v v30, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    j cblas_sgemm_rrc_3__end_loop_ii

cblas_sgemm_rrc_3__post_scale:

cblas_sgemm_rrc_3__prolog:
    slli s6, a0, 2
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rrc_3__epilog
    vsetvli s3, s0, e32,m2
    mul s2, s3, s11
    slli s3, s3, 2
    vle32.v v26, 0(s5)
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 1
1:   
    beqz a0, 1f
    vlse32.v v30, 0(s8), s11
    flw fa6, 0(s10)
    fmul.s fa6, fa6, fa0
    vfmacc.vf v30, fa6, v26
    vsse32.v v30, 0(s8), s11
    addi s8, s8, 4
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    flw fa5, 0(s10)
    vlse32.v v30, 0(s8), s11
    fmul.s fa5, fa5, fa0
    vfmacc.vf v28, fa5, v26
    add s10, s10, a4
    addi s8, s8, 4
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0

cblas_sgemm_rrc_3__loop_ii:
    vfmacc.vf v30, fa6, v26
    flw fa5, 0(s10)
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    fmul.s fa5, fa5, fa0
    add s10, s10, a4
    li t1, 8
    vlse32.v v28, 0(s8), s11
    addi s8, s8, 4
    sub s8, s8, t1
    li t1, 8
    vfmacc.vf v28, fa5, v26
    vsse32.v v30, 0(s8), s11
    add s8, s8, t1
    vlse32.v v30, 0(s8), s11
    addi s8, s8, 4
    flw fa6, 0(s10)
    add s10, s10, a4
    fmul.s fa6, fa6, fa0
    blt s8, s6, cblas_sgemm_rrc_3__loop_ii

cblas_sgemm_rrc_3__epilog:
    li t1, 8
    sub s8, s8, t1
    vsse32.v v28, 0(s8), s11
    li t1, 8
    add s8, s8, t1
    addi s8, s8, 4
    add s10, s10, a4
    vfmacc.vf v30, fa6, v26
    li t1, 8
    sub s8, s8, t1
    vsse32.v v30, 0(s8), s11
    li t1, 8
    add s8, s8, t1

cblas_sgemm_rrc_3__end_loop_ii:
    slli t1, s3, 0
    add s5, s5, t1
    slli t1, s2, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rrc_3__loop_jj

cblas_sgemm_rrc_3__end_loop_jj:
    li t1, 4
    add s7, s7, t1
    slli t1, a1, 2
    sub s5, s5, t1
    mul t1, a1, s11
    sub s4, s4, t1
    slli t1, a6, 0
    add s5, s5, t1
    addi t2, t2, -1
    bnez t2, cblas_sgemm_rrc_3__loop_kk

cblas_sgemm_rrc_3__end_loop_kk:

cblas_sgemm_rrc_3__exit_gemm:

cblas_sgemm_rrc_3_jexit:
    j exit_cblas_sgemm_rrc

exit_cblas_sgemm_rrc:
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
.size cblas_sgemm_rrc, .-cblas_sgemm_rrc

.text
.global cblas_sgemm_rcr
.type cblas_sgemm_rcr, @function

cblas_sgemm_rcr:
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

dispatch_cblas_sgemm_rcr:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_rcr_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_rcr_1
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    j cblas_sgemm_rcr_2
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_sgemm_rcr_3
1:   
    j exit_cblas_sgemm_rcr

cblas_sgemm_rcr_0:

cblas_sgemm_rcr_0__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rcr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcr_0__exit_gemm
    beqz a1, cblas_sgemm_rcr_0__exit_gemm

cblas_sgemm_rcr_0__loop_kk:
    mv s0, a1

cblas_sgemm_rcr_0__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_sgemm_rcr_0__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_0__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v20, fs8, v12
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v16, fs4, v12
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs6, v4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v24, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    vfmacc.vf v20, fs5, v0
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_0__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    sub s8, s8, t1
    vfmacc.vf v24, fs10, v4
    slli t1, s11, 2
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    add s10, s10, a4
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    vfmacc.vf v20, fs6, v4
    flw fs9, 12(t0)
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_rcr_0__loop_ii

cblas_sgemm_rcr_0__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcr_0__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcr_0__loop_jj

cblas_sgemm_rcr_0__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcr_0__loop_kk

cblas_sgemm_rcr_0__end_loop_kk:

cblas_sgemm_rcr_0__exit_gemm:

cblas_sgemm_rcr_0_jexit:
    j exit_cblas_sgemm_rcr

cblas_sgemm_rcr_1:

cblas_sgemm_rcr_1__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rcr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcr_1__exit_gemm
    beqz a1, cblas_sgemm_rcr_1__exit_gemm

cblas_sgemm_rcr_1__loop_kk:
    mv s0, a1

cblas_sgemm_rcr_1__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_sgemm_rcr_1__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_1__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    flw fa5, 4(t0)
    fmul.s fa5, fa5, fa0
    flw fa4, 8(t0)
    fmul.s fa4, fa4, fa0
    flw fa3, 12(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmacc.vf v20, fs7, v8
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    vfmacc.vf v16, fs4, v12
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v20, fs6, v4
    vle32.v v24, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fs5, v0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_1__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    vfmacc.vf v24, fs10, v4
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v16, fs3, v8
    vle32.v v24, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v20, fs6, v4
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v16, fs2, v4
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_rcr_1__loop_ii

cblas_sgemm_rcr_1__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcr_1__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcr_1__loop_jj

cblas_sgemm_rcr_1__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcr_1__loop_kk

cblas_sgemm_rcr_1__end_loop_kk:

cblas_sgemm_rcr_1__exit_gemm:

cblas_sgemm_rcr_1_jexit:
    j exit_cblas_sgemm_rcr

cblas_sgemm_rcr_2:

cblas_sgemm_rcr_2__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rcr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcr_2__exit_gemm
    beqz a1, cblas_sgemm_rcr_2__exit_gemm

cblas_sgemm_rcr_2__loop_kk:
    mv s0, a1

cblas_sgemm_rcr_2__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rcr_2__post_scale

cblas_sgemm_rcr_2__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_2__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v20, v20, fa1
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs8, v12
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    vfmul.vf v16, v16, fa1
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v24, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v24, v24, fa1
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_2__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    sub s8, s8, t1
    vfmacc.vf v24, fs10, v4
    slli t1, s11, 2
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    add s10, s10, a4
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmul.vf v20, v20, fa1
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmul.vf v16, v16, fa1
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    vle32.v v24, 0(s8)
    add s8, s8, s11
    vfmacc.vf v16, fs4, v12
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    vfmacc.vf v20, fs7, v8
    flw fs9, 12(t0)
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_sgemm_rcr_2__loop_ii_scale

cblas_sgemm_rcr_2__epilog_scale:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_rcr_2__end_loop_ii

cblas_sgemm_rcr_2__post_scale:

cblas_sgemm_rcr_2__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_2__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v20, fs8, v12
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs7, v8
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v16, fs4, v12
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmacc.vf v20, fs6, v4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v24, 0(s8)
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    vfmacc.vf v20, fs5, v0
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_2__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    sub s8, s8, t1
    vfmacc.vf v24, fs10, v4
    slli t1, s11, 2
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    mv t0, s10
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    add s10, s10, a4
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    vle32.v v24, 0(s8)
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    vfmacc.vf v20, fs6, v4
    flw fs9, 12(t0)
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_rcr_2__loop_ii

cblas_sgemm_rcr_2__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcr_2__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcr_2__loop_jj

cblas_sgemm_rcr_2__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcr_2__loop_kk

cblas_sgemm_rcr_2__end_loop_kk:

cblas_sgemm_rcr_2__exit_gemm:

cblas_sgemm_rcr_2_jexit:
    j exit_cblas_sgemm_rcr

cblas_sgemm_rcr_3:

cblas_sgemm_rcr_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_rcr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_rcr_3__exit_gemm
    beqz a1, cblas_sgemm_rcr_3__exit_gemm

cblas_sgemm_rcr_3__loop_kk:
    mv s0, a1

cblas_sgemm_rcr_3__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_rcr_3__post_scale

cblas_sgemm_rcr_3__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_3__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    flw fa5, 4(t0)
    fmul.s fa5, fa5, fa0
    flw fa4, 8(t0)
    fmul.s fa4, fa4, fa0
    flw fa3, 12(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v20, v20, fa1
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    vfmacc.vf v20, fs8, v12
    fmul.s fs5, fs5, fa0
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    vfmul.vf v16, v16, fa1
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    mv t0, s10
    vfmacc.vf v20, fs7, v8
    add s8, s8, s11
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vle32.v v24, 0(s8)
    vfmul.vf v28, v28, fa1
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    vfmul.vf v24, v24, fa1
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    vfmacc.vf v20, fs6, v4
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fs4, v12
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_3__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    vfmacc.vf v24, fs10, v4
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmul.vf v20, v20, fa1
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmul.vf v16, v16, fa1
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v16, fs4, v12
    vle32.v v24, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v16, fs3, v8
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_sgemm_rcr_3__loop_ii_scale

cblas_sgemm_rcr_3__epilog_scale:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_rcr_3__end_loop_ii

cblas_sgemm_rcr_3__post_scale:

cblas_sgemm_rcr_3__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_rcr_3__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    flw fa5, 4(t0)
    fmul.s fa5, fa5, fa0
    flw fa4, 8(t0)
    fmul.s fa4, fa4, fa0
    flw fa3, 12(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    add s10, s10, a4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    vfmacc.vf v20, fs7, v8
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vle32.v v28, 0(s8)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    vfmacc.vf v16, fs4, v12
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v20, fs6, v4
    vle32.v v24, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fs5, v0
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_rcr_3__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    add s10, s10, a4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    flw fs7, 4(t0)
    vfmacc.vf v28, fa4, v4
    flw fs6, 8(t0)
    flw fs5, 12(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    fmul.s fs5, fs5, fa0
    vfmacc.vf v24, fs10, v4
    mv t0, s10
    add s8, s8, s11
    add s10, s10, a4
    flw fs4, 0(t0)
    flw fs3, 4(t0)
    flw fs2, 8(t0)
    flw fs1, 12(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    fmul.s fs1, fs1, fa0
    sub s8, s8, t1
    slli t1, s11, 2
    mv t0, s10
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    add s10, s10, a4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    flw fa6, 0(t0)
    flw fa5, 4(t0)
    flw fa4, 8(t0)
    flw fa3, 12(t0)
    vfmacc.vf v16, fs3, v8
    vle32.v v24, 0(s8)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    mv t0, s10
    add s8, s8, s11
    vfmacc.vf v20, fs6, v4
    add s10, s10, a4
    flw fa2, 0(t0)
    flw fs11, 4(t0)
    flw fs10, 8(t0)
    flw fs9, 12(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v16, fs2, v4
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_rcr_3__loop_ii

cblas_sgemm_rcr_3__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_rcr_3__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_rcr_3__loop_jj

cblas_sgemm_rcr_3__end_loop_jj:
    li t1, 16
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_rcr_3__loop_kk

cblas_sgemm_rcr_3__end_loop_kk:

cblas_sgemm_rcr_3__exit_gemm:

cblas_sgemm_rcr_3_jexit:
    j exit_cblas_sgemm_rcr

exit_cblas_sgemm_rcr:
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
.size cblas_sgemm_rcr, .-cblas_sgemm_rcr

.text
.global cblas_sgemm_ccr
.type cblas_sgemm_ccr, @function

cblas_sgemm_ccr:
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

dispatch_cblas_sgemm_ccr:
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_ccr_0
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa1
    beqz s1, 1f
    j cblas_sgemm_ccr_1
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    li s1, 1
    fcvt.s.w ft0, s1
    feq.s s1, ft0, fa0
    beqz s1, 1f
    j cblas_sgemm_ccr_2
1:   
    li s1, 8
    blt a0, s1, 1f
    li s1, 4
    blt a2, s1, 1f
    j cblas_sgemm_ccr_3
1:   
    j exit_cblas_sgemm_ccr

cblas_sgemm_ccr_0:

cblas_sgemm_ccr_0__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_ccr_0__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_ccr_0__exit_gemm
    beqz a1, cblas_sgemm_ccr_0__exit_gemm

cblas_sgemm_ccr_0__loop_kk:
    mv s0, a1

cblas_sgemm_ccr_0__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_sgemm_ccr_0__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_0__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v20, fs8, v12
    add t0, t0, a4
    add s8, s8, s11
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v20, fs7, v8
    add t0, t0, a4
    add s8, s8, s11
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    add s8, s8, s11
    flw fs5, 0(t0)
    mv t0, s10
    vfmacc.vf v20, fs5, v0
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    vfmacc.vf v16, fs4, v12
    addi s10, s10, 4
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    vfmacc.vf v16, fs3, v8
    flw fa3, 0(t0)
    addi s10, s10, 4
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    add t0, t0, a4
    flw fs10, 0(t0)
    vfmacc.vf v16, fs2, v4
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_ccr_0__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    add t0, t0, a4
    flw fs5, 0(t0)
    mv t0, s10
    flw fs4, 0(t0)
    vfmacc.vf v28, fa3, v0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    flw fa5, 0(t0)
    add t0, t0, a4
    vfmacc.vf v20, fs6, v4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    vfmacc.vf v16, fs2, v4
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_ccr_0__loop_ii

cblas_sgemm_ccr_0__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_ccr_0__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_ccr_0__loop_jj

cblas_sgemm_ccr_0__end_loop_jj:
    slli t1, a4, 2
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_ccr_0__loop_kk

cblas_sgemm_ccr_0__end_loop_kk:

cblas_sgemm_ccr_0__exit_gemm:

cblas_sgemm_ccr_0_jexit:
    j exit_cblas_sgemm_ccr

cblas_sgemm_ccr_1:

cblas_sgemm_ccr_1__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_ccr_1__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_ccr_1__exit_gemm
    beqz a1, cblas_sgemm_ccr_1__exit_gemm

cblas_sgemm_ccr_1__loop_kk:
    mv s0, a1

cblas_sgemm_ccr_1__loop_jj:
    mv s8, s4
    mv s10, s7

cblas_sgemm_ccr_1__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_1__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    flw fa5, 0(t0)
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    add t0, t0, a4
    add s8, s8, s11
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs7, fs7, fa0
    vfmacc.vf v20, fs7, v8
    add t0, t0, a4
    add s8, s8, s11
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    fmul.s fs6, fs6, fa0
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    add s8, s8, s11
    flw fs5, 0(t0)
    mv t0, s10
    flw fs4, 0(t0)
    fmul.s fs5, fs5, fa0
    vfmacc.vf v20, fs5, v0
    fmul.s fs4, fs4, fa0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    vfmacc.vf v16, fs4, v12
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    fmul.s fs1, fs1, fa0
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    vfmacc.vf v16, fs3, v8
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs2, v4
    addi s10, s10, 4
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    add t0, t0, a4
    vfmacc.vf v16, fs1, v0
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4

cblas_sgemm_ccr_1__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    fmul.s fs8, fs8, fa0
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    add t0, t0, a4
    flw fs5, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add t0, t0, a4
    addi s10, s10, 4
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v20, fs8, v12
    sub s8, s8, t1
    flw fs2, 0(t0)
    vse32.v v24, 0(s8)
    fmul.s fs2, fs2, fa0
    add t0, t0, a4
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v16, fs4, v12
    add s8, s8, t1
    flw fs1, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs1, fs1, fa0
    mv t0, s10
    vfmacc.vf v20, fs7, v8
    add s8, s8, s11
    addi s10, s10, 4
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    vfmacc.vf v16, fs3, v8
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v20, fs6, v4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v16, fs2, v4
    fmul.s fa3, fa3, fa0
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fs5, v0
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_ccr_1__loop_ii

cblas_sgemm_ccr_1__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_ccr_1__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_ccr_1__loop_jj

cblas_sgemm_ccr_1__end_loop_jj:
    slli t1, a4, 2
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_ccr_1__loop_kk

cblas_sgemm_ccr_1__end_loop_kk:

cblas_sgemm_ccr_1__exit_gemm:

cblas_sgemm_ccr_1_jexit:
    j exit_cblas_sgemm_ccr

cblas_sgemm_ccr_2:

cblas_sgemm_ccr_2__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_ccr_2__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_ccr_2__exit_gemm
    beqz a1, cblas_sgemm_ccr_2__exit_gemm

cblas_sgemm_ccr_2__loop_kk:
    mv s0, a1

cblas_sgemm_ccr_2__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_ccr_2__post_scale

cblas_sgemm_ccr_2__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_2__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmul.vf v16, v16, fa1
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmul.vf v28, v28, fa1
    flw fs5, 0(t0)
    mv t0, s10
    vfmul.vf v24, v24, fa1
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    vfmacc.vf v20, fs7, v8
    addi s10, s10, 4
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    vfmacc.vf v16, fs4, v12
    add t0, t0, a4
    flw fa3, 0(t0)
    addi s10, s10, 4
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v16, fs3, v8
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_ccr_2__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    add t0, t0, a4
    flw fs5, 0(t0)
    mv t0, s10
    flw fs4, 0(t0)
    vfmacc.vf v28, fa3, v0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmul.vf v20, v20, fa1
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmul.vf v16, v16, fa1
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v16, fs4, v12
    flw fa5, 0(t0)
    add t0, t0, a4
    vfmacc.vf v20, fs7, v8
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    vfmacc.vf v16, fs3, v8
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v20, fs6, v4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_sgemm_ccr_2__loop_ii_scale

cblas_sgemm_ccr_2__epilog_scale:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_ccr_2__end_loop_ii

cblas_sgemm_ccr_2__post_scale:

cblas_sgemm_ccr_2__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_2__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v20, fs8, v12
    add t0, t0, a4
    add s8, s8, s11
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    vfmacc.vf v20, fs7, v8
    add t0, t0, a4
    add s8, s8, s11
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    add s8, s8, s11
    flw fs5, 0(t0)
    mv t0, s10
    vfmacc.vf v20, fs5, v0
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    vfmacc.vf v16, fs4, v12
    addi s10, s10, 4
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    vfmacc.vf v16, fs3, v8
    flw fa3, 0(t0)
    addi s10, s10, 4
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    add t0, t0, a4
    flw fs10, 0(t0)
    vfmacc.vf v16, fs2, v4
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_ccr_2__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    add t0, t0, a4
    flw fs5, 0(t0)
    mv t0, s10
    flw fs4, 0(t0)
    vfmacc.vf v28, fa3, v0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    li t1, 3
    vfmacc.vf v20, fs8, v12
    mul t1, t1, s11
    vse32.v v24, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v16, fs4, v12
    vle32.v v28, 0(s8)
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v16, fs3, v8
    flw fa5, 0(t0)
    add t0, t0, a4
    vfmacc.vf v20, fs6, v4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    vfmacc.vf v16, fs2, v4
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_ccr_2__loop_ii

cblas_sgemm_ccr_2__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_ccr_2__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_ccr_2__loop_jj

cblas_sgemm_ccr_2__end_loop_jj:
    slli t1, a4, 2
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_ccr_2__loop_kk

cblas_sgemm_ccr_2__end_loop_kk:

cblas_sgemm_ccr_2__exit_gemm:

cblas_sgemm_ccr_2_jexit:
    j exit_cblas_sgemm_ccr

cblas_sgemm_ccr_3:

cblas_sgemm_ccr_3__enter:
    slli a4, a4, 2
    slli a6, a6, 2
    ld s11, 0(fp)
    slli s11, s11, 2
    li t1, -1
    vsetvli s3, t1, e32 , m4
    li t1, 4
    remu t1, a2, t1
    sub a2, a2, t1
    li t1, 7
    bltu t1, a0, 1f
    li a0, 0
    j cblas_sgemm_ccr_3__exit_gemm
1:   
    ld s1, 8(fp)
    sd a0, 0(s1)
    sd a1, 8(s1)
    sd a2, 16(s1)
    slli s2, s3, 2
    slli s3, s3, 2
    mv s4, a7
    mv s7, a3
    mv s5, a5
    li s9, 0
    mv t2, a2
    beqz t2, cblas_sgemm_ccr_3__exit_gemm
    beqz a1, cblas_sgemm_ccr_3__exit_gemm

cblas_sgemm_ccr_3__loop_kk:
    mv s0, a1

cblas_sgemm_ccr_3__loop_jj:
    mv s8, s4
    mv s10, s7
    bltu t2, a2, cblas_sgemm_ccr_3__post_scale

cblas_sgemm_ccr_3__prolog_scale:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_3__epilog_scale
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    vfmul.vf v28, v28, fa1
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    flw fa5, 0(t0)
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    vfmul.vf v20, v20, fa1
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v20, fs8, v12
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs7, fs7, fa0
    add t0, t0, a4
    add s8, s8, s11
    vfmul.vf v16, v16, fa1
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    fmul.s fs6, fs6, fa0
    add t0, t0, a4
    vfmul.vf v28, v28, fa1
    add s8, s8, s11
    flw fs5, 0(t0)
    mv t0, s10
    vfmul.vf v24, v24, fa1
    flw fs4, 0(t0)
    fmul.s fs5, fs5, fa0
    fmul.s fs4, fs4, fa0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    vfmacc.vf v20, fs7, v8
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    fmul.s fs1, fs1, fa0
    mv t0, s10
    vfmacc.vf v16, fs4, v12
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    vfmacc.vf v20, fs6, v4
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    addi s10, s10, 4
    fmul.s fa3, fa3, fa0
    mv t0, s10
    flw fa2, 0(t0)
    vfmacc.vf v16, fs3, v8
    fmul.s fa2, fa2, fa0
    add t0, t0, a4
    flw fs11, 0(t0)
    add t0, t0, a4
    flw fs10, 0(t0)
    fmul.s fs11, fs11, fa0
    fmul.s fs10, fs10, fa0
    vfmacc.vf v20, fs5, v0
    add t0, t0, a4
    flw fs9, 0(t0)
    addi s10, s10, 4
    fmul.s fs9, fs9, fa0
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v16, fs1, v0

cblas_sgemm_ccr_3__loop_ii_scale:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    fmul.s fs8, fs8, fa0
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    add t0, t0, a4
    flw fs5, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add t0, t0, a4
    addi s10, s10, 4
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmul.vf v20, v20, fa1
    sub s8, s8, t1
    flw fs2, 0(t0)
    vse32.v v24, 0(s8)
    fmul.s fs2, fs2, fa0
    add t0, t0, a4
    li t1, 3
    mul t1, t1, s11
    vfmul.vf v16, v16, fa1
    add s8, s8, t1
    flw fs1, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs1, fs1, fa0
    mv t0, s10
    vfmacc.vf v20, fs8, v12
    add s8, s8, s11
    addi s10, s10, 4
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    vfmacc.vf v16, fs4, v12
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v20, fs7, v8
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v16, fs3, v8
    fmul.s fa3, fa3, fa0
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    vfmacc.vf v16, fs2, v4
    vfmacc.vf v20, fs5, v0
    vfmacc.vf v16, fs1, v0
    vfmul.vf v28, v28, fa1
    vfmul.vf v24, v24, fa1
    blt s8, s6, cblas_sgemm_ccr_3__loop_ii_scale

cblas_sgemm_ccr_3__epilog_scale:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1
    j cblas_sgemm_ccr_3__end_loop_ii

cblas_sgemm_ccr_3__post_scale:

cblas_sgemm_ccr_3__prolog:
    mul s6, a0, s11
    add s6, s6, s4
    bge s8, s6, cblas_sgemm_ccr_3__epilog
    vsetvli s3, s0, e32,m4
    slli s2, s3, 2
    slli s3, s3, 2
    mv t0, s5
    vlse32.v v12, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v8, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v4, 0(t0), a6
    addi t0, t0, 4
    vlse32.v v0, 0(t0), a6
    addi sp, sp, -8
    sd a0, 0(sp)
    andi a0, a0, 3
1:   
    beqz a0, 1f
    vle32.v v28, 0(s8)
    mv t0, s10
    flw fa6, 0(t0)
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    flw fa5, 0(t0)
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    fmul.s fa3, fa3, fa0
    vfmacc.vf v28, fa6, v12
    vfmacc.vf v28, fa5, v8
    vfmacc.vf v28, fa4, v4
    vfmacc.vf v28, fa3, v0
    vse32.v v28, 0(s8)
    add s8, s8, s11
    addi s10, s10, 4
    addi a0, a0, -1
    j 1b
1:   
    ld a0, 0(sp)
    addi sp, sp, 8
    vle32.v v20, 0(s8)
    mv t0, s10
    add s8, s8, s11
    addi s10, s10, 4
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    fmul.s fs8, fs8, fa0
    vfmacc.vf v20, fs8, v12
    add t0, t0, a4
    add s8, s8, s11
    flw fs7, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs7, fs7, fa0
    vfmacc.vf v20, fs7, v8
    add t0, t0, a4
    add s8, s8, s11
    flw fs6, 0(t0)
    vle32.v v24, 0(s8)
    fmul.s fs6, fs6, fa0
    vfmacc.vf v20, fs6, v4
    add t0, t0, a4
    add s8, s8, s11
    flw fs5, 0(t0)
    mv t0, s10
    flw fs4, 0(t0)
    fmul.s fs5, fs5, fa0
    vfmacc.vf v20, fs5, v0
    fmul.s fs4, fs4, fa0
    add t0, t0, a4
    flw fs3, 0(t0)
    add t0, t0, a4
    flw fs2, 0(t0)
    fmul.s fs3, fs3, fa0
    fmul.s fs2, fs2, fa0
    vfmacc.vf v16, fs4, v12
    add t0, t0, a4
    flw fs1, 0(t0)
    addi s10, s10, 4
    fmul.s fs1, fs1, fa0
    mv t0, s10
    flw fa6, 0(t0)
    add t0, t0, a4
    flw fa5, 0(t0)
    vfmacc.vf v16, fs3, v8
    fmul.s fa6, fa6, fa0
    fmul.s fa5, fa5, fa0
    add t0, t0, a4
    flw fa4, 0(t0)
    add t0, t0, a4
    flw fa3, 0(t0)
    fmul.s fa4, fa4, fa0
    fmul.s fa3, fa3, fa0
    vfmacc.vf v16, fs2, v4
    addi s10, s10, 4
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    add t0, t0, a4
    vfmacc.vf v16, fs1, v0
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4

cblas_sgemm_ccr_3__loop_ii:
    vfmacc.vf v28, fa6, v12
    slli t1, s11, 2
    sub s8, s8, t1
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v24, fa2, v12
    sub s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vse32.v v16, 0(s8)
    add s8, s8, t1
    mv t0, s10
    addi s10, s10, 4
    vfmacc.vf v28, fa5, v8
    slli t1, s11, 2
    vle32.v v20, 0(s8)
    add s8, s8, s11
    vfmacc.vf v24, fs11, v8
    flw fs8, 0(t0)
    vle32.v v16, 0(s8)
    vfmacc.vf v28, fa4, v4
    fmul.s fs8, fs8, fa0
    add t0, t0, a4
    add s8, s8, s11
    sub s8, s8, t1
    slli t1, s11, 2
    vfmacc.vf v24, fs10, v4
    flw fs7, 0(t0)
    add t0, t0, a4
    flw fs6, 0(t0)
    fmul.s fs7, fs7, fa0
    fmul.s fs6, fs6, fa0
    add t0, t0, a4
    flw fs5, 0(t0)
    vfmacc.vf v28, fa3, v0
    fmul.s fs5, fs5, fa0
    mv t0, s10
    flw fs4, 0(t0)
    add t0, t0, a4
    flw fs3, 0(t0)
    fmul.s fs4, fs4, fa0
    fmul.s fs3, fs3, fa0
    vfmacc.vf v24, fs9, v0
    vse32.v v28, 0(s8)
    add t0, t0, a4
    addi s10, s10, 4
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v20, fs8, v12
    sub s8, s8, t1
    flw fs2, 0(t0)
    vse32.v v24, 0(s8)
    fmul.s fs2, fs2, fa0
    add t0, t0, a4
    li t1, 3
    mul t1, t1, s11
    vfmacc.vf v16, fs4, v12
    add s8, s8, t1
    flw fs1, 0(t0)
    vle32.v v28, 0(s8)
    fmul.s fs1, fs1, fa0
    mv t0, s10
    vfmacc.vf v20, fs7, v8
    add s8, s8, s11
    addi s10, s10, 4
    flw fa6, 0(t0)
    vle32.v v24, 0(s8)
    vfmacc.vf v16, fs3, v8
    fmul.s fa6, fa6, fa0
    add t0, t0, a4
    add s8, s8, s11
    vfmacc.vf v20, fs6, v4
    flw fa5, 0(t0)
    add t0, t0, a4
    flw fa4, 0(t0)
    fmul.s fa5, fa5, fa0
    fmul.s fa4, fa4, fa0
    add t0, t0, a4
    flw fa3, 0(t0)
    vfmacc.vf v16, fs2, v4
    fmul.s fa3, fa3, fa0
    mv t0, s10
    flw fa2, 0(t0)
    add t0, t0, a4
    flw fs11, 0(t0)
    fmul.s fa2, fa2, fa0
    fmul.s fs11, fs11, fa0
    vfmacc.vf v20, fs5, v0
    add t0, t0, a4
    flw fs10, 0(t0)
    add t0, t0, a4
    flw fs9, 0(t0)
    fmul.s fs10, fs10, fa0
    fmul.s fs9, fs9, fa0
    addi s10, s10, 4
    vfmacc.vf v16, fs1, v0
    blt s8, s6, cblas_sgemm_ccr_3__loop_ii

cblas_sgemm_ccr_3__epilog:
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
    vse32.v v20, 0(s8)
    slli t1, s11, 2
    add s8, s8, t1
    li t1, 3
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v16, 0(s8)
    li t1, 3
    mul t1, t1, s11
    add s8, s8, t1
    slli t1, s11, 1
    sub s8, s8, t1
    vse32.v v28, 0(s8)
    slli t1, s11, 1
    add s8, s8, t1
    li t1, 1
    mul t1, t1, s11
    sub s8, s8, t1
    vse32.v v24, 0(s8)
    li t1, 1
    mul t1, t1, s11
    add s8, s8, t1

cblas_sgemm_ccr_3__end_loop_ii:
    srai t1, s3, 2
    mul t1, t1, a6
    add s5, s5, t1
    slli t1, s3, 0
    add s4, s4, t1
    slli t1, s3, 0
    srai t1, t1, 2
    sub s0, s0, t1
    bnez s0, cblas_sgemm_ccr_3__loop_jj

cblas_sgemm_ccr_3__end_loop_jj:
    slli t1, a4, 2
    add s7, s7, t1
    mul t1, a1, a6
    sub s5, s5, t1
    slli t1, a1, 2
    sub s4, s4, t1
    li t1, 16
    add s5, s5, t1
    addi t2, t2, -4
    bnez t2, cblas_sgemm_ccr_3__loop_kk

cblas_sgemm_ccr_3__end_loop_kk:

cblas_sgemm_ccr_3__exit_gemm:

cblas_sgemm_ccr_3_jexit:
    j exit_cblas_sgemm_ccr

exit_cblas_sgemm_ccr:
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
.size cblas_sgemm_ccr, .-cblas_sgemm_ccr
