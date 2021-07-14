/*
 * Copyright (c) 2016-2020 SiFive, Inc. -- Proprietary and Confidential
 * All Rights Reserved.
 *
 * NOTICE: All information contained herein is, and remains the
 * property of SiFive, Inc. The intellectual and technical concepts
 * contained herein are proprietary to SiFive, Inc. and may be covered
 * by U.S. and Foreign Patents, patents in process, and are protected by
 * trade secret or copyright law.
 *
 * This work may not be copied, modified, re-published, uploaded,
 * executed, or distributed in any way, in any medium, whether in whole
 * or in part, without prior written permission from SiFive, Inc.
 *
 * The copyright notice above does not evidence any actual or intended
 * publication or disclosure of this source code, which includes
 * information that is confidential and/or proprietary, and is a trade
 * secret, of SiFive, Inc.
 */


#
# C prototype:
#    void cfft_64(float complex *buf0, float complex *buf1, float complex *pTwi);

.text
.global cfft_64
.type cfft_64, @function
cfft_64:

/*
 * C reference code for stage-radix8-jvec-first.S:
 *
 * for (uint32_t j = 0u; j < 1u << 3u * (L - 1); ++j)   
 * {
 *     float complex r0 = x[                     + j];
 *     float complex r1 = x[(1u << 3u * (L - 1)) + j];
 *     float complex r2 = x[(2u << 3u * (L - 1)) + j];
 *     float complex r3 = x[(3u << 3u * (L - 1)) + j];
 *     float complex r4 = x[(4u << 3u * (L - 1)) + j];
 *     float complex r5 = x[(5u << 3u * (L - 1)) + j];
 *     float complex r6 = x[(6u << 3u * (L - 1)) + j];
 *     float complex r7 = x[(7u << 3u * (L - 1)) + j];
 *     float complex s0 = r0;
 *     float complex s1 = r1 + r7;
 *     float complex s2 = r2 + r6;
 *     float complex s3 = r3 + r5;
 *     float complex s4 = r4;
 *     float complex s5 = r3 - r5;
 *     float complex s6 = r2 - r6;
 *     float complex s7 = r1 - r7;
 *     float complex t0 =  s0 + s4;
 *     float complex t1 = -s1 + s3;
 *     float complex t2 =  s2;
 *     float complex t3 =  s1 + s3;
 *     float complex t4 =  s0 - s4;
 *     float complex t5 = -s5 + s7;
 *     float complex t6 =  s6;
 *     float complex t7 =  s5 + s7;
 *     float complex u0 = t0 + t2;
 *     float complex u1 = t1;
 *     float complex u2 = t0 - t2;
 *     float complex u3 = t4;
 *     float complex u4 = t3;
 *     float complex u5 = t6;
 *     float complex u6 = t5;
 *     float complex u7 = t7;
 *     float complex v0 = u0;
 *     float complex v1 = sqrt(2.)/2. * u1;
 *     float complex v2 = u2;
 *     float complex v3 = u3;
 *     float complex v4 = u4;
 *     float complex v5 = -I * u5;
 *     float complex v6 = -I * u6;
 *     float complex v7 = -I * sqrt(2.)/2. * u7;
 *     float complex w0 =  v0 + v4;
 *     float complex w1 = -v1 + v3;
 *     float complex w2 =  v2;
 *     float complex w3 =  v1 + v3;
 *     float complex w4 =  v0 - v4;
 *     float complex w5 = -v5 + v7;
 *     float complex w6 =  v6;
 *     float complex w7 =  v5 + v7;
 *     y[                      + j] = w0;
 *     y[(1u << 3u * (L - 1u)) + j] = w1 + w7;
 *     y[(2u << 3u * (L - 1u)) + j] = w2 + w6;
 *     y[(3u << 3u * (L - 1u)) + j] = w3 + w5;
 *     y[(4u << 3u * (L - 1u)) + j] = w4;
 *     y[(5u << 3u * (L - 1u)) + j] = w3 - w5;
 *     y[(6u << 3u * (L - 1u)) + j] = w2 - w6;
 *     y[(7u << 3u * (L - 1u)) + j] = w1 - w7;
 * }
 * float complex *tmp = y; y = x; x = tmp;
 * 
 * C reference code for stage-radix8-transposed-jvec-first.S:
 * 
 * for (uint32_t j = 0u; j < 1u << 3u * (L - l); ++j)
 * {
 *     float complex r0 = x[(j << 3u * (l - 1u))                        ];
 *     float complex r1 = x[(j << 3u * (l - 1u)) + (1u << 3u * (L - 1u))];
 *     float complex r2 = x[(j << 3u * (l - 1u)) + (2u << 3u * (L - 1u))];
 *     float complex r3 = x[(j << 3u * (l - 1u)) + (3u << 3u * (L - 1u))];
 *     float complex r4 = x[(j << 3u * (l - 1u)) + (4u << 3u * (L - 1u))];
 *     float complex r5 = x[(j << 3u * (l - 1u)) + (5u << 3u * (L - 1u))];
 *     float complex r6 = x[(j << 3u * (l - 1u)) + (6u << 3u * (L - 1u))];
 *     float complex r7 = x[(j << 3u * (l - 1u)) + (7u << 3u * (L - 1u))];
 *     float complex s0 = r0;
 *     float complex s1 = r1 + r7;
 *     float complex s2 = r2 + r6;
 *     float complex s3 = r3 + r5;
 *     float complex s4 = r4;
 *     float complex s5 = r3 - r5;
 *     float complex s6 = r2 - r6;
 *     float complex s7 = r1 - r7;
 *     float complex t0 =  s0 + s4;
 *     float complex t1 = -s1 + s3;
 *     float complex t2 =  s2;
 *     float complex t3 =  s1 + s3;
 *     float complex t4 =  s0 - s4;
 *     float complex t5 = -s5 + s7;
 *     float complex t6 =  s6;
 *     float complex t7 =  s5 + s7;
 *     float complex u0 = t0 + t2;
 *     float complex u1 = t1;
 *     float complex u2 = t0 - t2;
 *     float complex u3 = t4;
 *     float complex u4 = t3;
 *     float complex u5 = t6;
 *     float complex u6 = t5;
 *     float complex u7 = t7;
 *     float complex v0 = u0;
 *     float complex v1 = sqrt(2.)/2. * u1;
 *     float complex v2 = u2;
 *     float complex v3 = u3;
 *     float complex v4 = u4;
 *     float complex v5 = -I * u5;
 *     float complex v6 = -I * u6;
 *     float complex v7 = -I * sqrt(2.)/2. * u7;
 *     float complex w0 =  v0 + v4;
 *     float complex w1 = -v1 + v3;
 *     float complex w2 =  v2;
 *     float complex w3 =  v1 + v3;
 *     float complex w4 =  v0 - v4;
 *     float complex w5 = -v5 + v7;
 *     float complex w6 =  v6;
 *     float complex w7 =  v5 + v7;
 *     y[(j << 3u)     ] = w0;
 *     y[(j << 3u) + 1u] = w1 + w7;
 *     y[(j << 3u) + 2u] = w2 + w6;
 *     y[(j << 3u) + 3u] = w3 + w5;
 *     y[(j << 3u) + 4u] = w4;
 *     y[(j << 3u) + 5u] = w3 - w5;
 *     y[(j << 3u) + 6u] = w2 - w6;
 *     y[(j << 3u) + 7u] = w1 - w7;
 * }
 *
 * template parameter: stage-radix8-jvec-first-viu75-tuned, stage_idx: 1, load_trans: normal, store_trans: normal, long_weight_vector: True
 */

#define pOut a1
#define pIn  a0


#define pTwi a2
#define tmp0 a3
#define tmp1 a4
#define st_stride a5
#define tmp2 a6
#define tmp3 a7

#define avl t0
#define vl  t1
#define i   t2
#define pIn0_iter t4
#define pOut0_iter t5
#define ld_stride t6

#define vColor0_Re v0
#define vColor0_Im v1
#define vColor1_Re v2
#define vColor1_Im v3
#define vColor2_Re v4
#define vColor2_Im v5
#define vColor3_Re v6
#define vColor3_Im v7
#define vColor4_Re v8
#define vColor4_Im v9
#define vColor5_Re v10
#define vColor5_Im v11
#define vColor6_Re v12
#define vColor6_Im v13
#define vColor7_Re v14
#define vColor7_Im v15
#define vColor8_Re v16
#define vColor8_Im v17

#define vColor9_Re  v18
#define vColor9_Im  v19
#define vColor10_Re v20
#define vColor10_Im v21
#define vColor11_Re v22
#define vColor11_Im v23
#define vColor12_Re v24
#define vColor12_Im v25
#define vColor13_Re v26
#define vColor13_Im v27
#define vColor14_Re v28
#define vColor14_Im v29
#define vColor15_Re v30
#define vColor15_Im v31

#define twi1_Re ft0
#define twi1_Im ft1
#define twi2_Re ft2
#define twi2_Im ft3
#define twi3_Re ft4
#define twi3_Im ft5
#define twi4_Re ft6
#define twi4_Im ft7
#define twi5_Re ft8
#define twi5_Im ft9
#define twi6_Re ft10
#define twi6_Im ft11
#define twi7_Re fa0
#define twi7_Im fa1
#define sqrt2_by_2 fa2

#define vX2_Re vColor0_Re
#define vX2_Im vColor0_Im
#define vX2_Re_2nd vColor10_Re
#define vX2_Im_2nd vColor10_Im
#define vR2_Re vColor0_Re
#define vR2_Im vColor0_Im
#define vR2_Re_2nd vColor10_Re
#define vR2_Im_2nd vColor10_Im
#define vX6_Re vColor1_Re
#define vX6_Im vColor1_Im
#define vX6_Re_2nd vColor11_Re
#define vX6_Im_2nd vColor11_Im
#define vR6_Re vColor1_Re
#define vR6_Im vColor1_Im
#define vR6_Re_2nd vColor11_Re
#define vR6_Im_2nd vColor11_Im
#define vS2_Re vColor2_Re
#define vS2_Im vColor2_Im
#define vS6_Re vColor0_Re
#define vS6_Im vColor0_Im
#define vT2_Re vColor2_Re
#define vT2_Im vColor2_Im
#define vT6_Re vColor0_Re
#define vT6_Im vColor0_Im
#define vU5_Re vColor0_Re
#define vU5_Im vColor0_Im
#define vV5_Re vColor0_Im
#define vV5_Im_neg vColor0_Re
#define vR0_Re vColor3_Re
#define vR0_Im vColor3_Im
#define vR0_Re_2nd vColor12_Re
#define vR0_Im_2nd vColor12_Im
#define vS0_Re vColor3_Re
#define vS0_Re_2nd vColor12_Re
#define vS0_Im_2nd vColor12_Im
#define vS0_Im vColor3_Im
#define vX4_Re vColor4_Re
#define vX4_Im vColor4_Im
#define vX4_Re_2nd vColor13_Re
#define vX4_Im_2nd vColor13_Im
#define vR4_Re vColor4_Re
#define vR4_Im vColor4_Im
#define vR4_Re_2nd vColor13_Re
#define vR4_Im_2nd vColor13_Im
#define vS4_Re vColor4_Re
#define vS4_Im vColor4_Im
#define vS4_Re_2nd vColor13_Re
#define vS4_Im_2nd vColor13_Im
#define vT0_Re vColor7_Re
#define vT0_Im vColor7_Im
#define vT4_Re vColor3_Re
#define vT4_Im vColor3_Im
#define vU3_Re vColor3_Re
#define vU3_Im vColor3_Im
#define vV3_Re vColor3_Re
#define vV3_Im vColor3_Im
#define vU2_Re vColor5_Re
#define vU2_Im vColor5_Im
#define vV2_Re vColor5_Re
#define vV2_Im vColor5_Im
#define vW2_Re vColor5_Re
#define vW2_Im vColor5_Im
#define vU0_Re vColor2_Re
#define vU0_Im vColor2_Im
#define vV0_Re vColor2_Re
#define vV0_Im vColor2_Im
#define vX1_Re vColor9_Re
#define vX1_Im vColor9_Im
#define vX7_Re vColor10_Re
#define vX7_Im vColor10_Im
#define vR1_Re vColor9_Re
#define vR1_Im vColor9_Im
#define vR7_Re vColor10_Re
#define vR7_Im vColor10_Im
#define vS1_Re vColor6_Re
#define vS1_Im vColor6_Im
#define vS7_Re vColor1_Re
#define vS7_Im vColor1_Im
#define vX3_Re vColor8_Re
#define vX3_Im vColor8_Im
#define vR3_Re vColor8_Re
#define vR3_Im vColor8_Im
#define vX5_Re vColor4_Re
#define vX5_Im vColor4_Im
#define vR5_Re vColor4_Re
#define vR5_Im vColor4_Im
#define vS5_Re vColor7_Re
#define vS5_Im vColor7_Im
#define vS3_Re vColor4_Re
#define vS3_Im vColor4_Im
#define vT1_Re vColor8_Re
#define vT1_Im vColor8_Im
#define vU1_Re vColor8_Re
#define vU1_Im vColor8_Im
#define vV1_Re vColor8_Re
#define vV1_Im vColor8_Im
#define vT3_Re vColor6_Re
#define vT3_Im vColor6_Im
#define vU4_Re vColor6_Re
#define vU4_Im vColor6_Im
#define vV4_Re vColor6_Re
#define vV4_Im vColor6_Im
#define vW0_Re vColor4_Re
#define vW0_Im vColor4_Im
#define vY0_Re vColor4_Re
#define vY0_Im vColor4_Im
#define vW4_Re vColor9_Re
#define vW4_Im vColor9_Im
#define vY4_Re vColor9_Re
#define vY4_Im vColor9_Im
#define vT5_Re vColor2_Re
#define vT5_Im vColor2_Im
#define vU6_Re vColor2_Re
#define vU6_Im vColor2_Im
#define vV6_Re vColor2_Im
#define vV6_Im_neg vColor2_Re
#define vW6_Re vColor2_Im
#define vW6_Im_neg vColor2_Re
#define vT7_Re vColor6_Re
#define vT7_Im vColor6_Im
#define vU7_Re vColor6_Re
#define vU7_Im vColor6_Im
#define vV7_Re vColor4_Re
#define vV7_Im_neg vColor4_Im
#define vW5_Re vColor1_Re
#define vW5_Im vColor1_Im
#define vW7_Re vColor7_Re
#define vW7_Im_neg vColor7_Im
#define vW3_Re vColor6_Re
#define vW3_Im vColor6_Im
#define vW1_Re vColor3_Re
#define vW1_Im vColor3_Im
#define vY1_Re vColor8_Re
#define vY1_Im vColor8_Im
#define vY7_Re vColor3_Re
#define vY7_Im vColor3_Im
#define vY2_Re vColor0_Re
#define vY2_Im vColor0_Im
#define vY6_Re vColor5_Re
#define vY6_Im vColor5_Im
#define vY3_Re vColor14_Re
#define vY3_Im vColor14_Im
#define vY5_Re vColor6_Re
#define vY5_Im vColor6_Im

enter_l1:

  /* start of i=0 special case */
    mv        pIn0_iter, pIn
    mv        pOut0_iter, pOut

    li        avl,  0x8

  /* pTwi[0] = 0x3f800000 (1.0f), 0x80000000(-0.0), */

///////////////////////////////////////////////////////////////// 1111111111111111111111111111111111
label_i0_jprolog_load_normal_store_normal_jvec_general_l1:
  vsetvli     vl, avl, e32, m1, tu,mu

    beq       vl, avl, label_i0_jcase1_load_normal_store_normal_jvec_general_l1

    li        tmp3, 128
    add       tmp0, pIn0_iter, tmp3
  vlseg2e32.v   vX2_Re, (tmp0)  /* tmp0 is pIn2_iter */
  
  /* r2 =  x2 */
    li        tmp3, 256
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX6_Re, (tmp0)  /* tmp0 is pIn6_iter */
  
  /* r0 = x0 */
  /* vR0_Re and vR0_Im not changed */
  vlseg2e32.v   vR0_Re, (pIn0_iter)

    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX4_Re, (tmp0)  /* tmp0 is pIn4_iter */
  
  /* r6 = x6 */
  /* s2 = r2 + r6 */
  vfadd.vv    vS2_Re, vR2_Re, vR6_Re
  vfadd.vv    vS2_Im, vR2_Im, vR6_Im
  
  /* s6 = r2 - r6 */
  vfsub.vv    vS6_Re, vR2_Re, vR6_Re

    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX1_Re, (tmp0)  /* tmp0 is pIn1_iter */

  vfsub.vv    vS6_Im, vR2_Im, vR6_Im
  /* t2 =  s2      */
  /* t6 =  s6      */
  /* u5 = t6       */
  /* v5 = -I * u5                 */
  // vV5_Re is vU5_Im
  // vV5_Im should be ( -1 * vU5_Re )
  /* s0 = r0      */
  
  /* r4 =  x4 */
  /* s4 = r4      */
  /* t0 =  s0 + s4 */
  vfadd.vv    vT0_Re, vS0_Re, vS4_Re

    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX3_Re, (tmp0)  /* tmp0 is pIn3_iter */
  
  vfadd.vv    vT0_Im, vS0_Im, vS4_Im

  /* t4 =  s0 - s4 */
  vfsub.vv    vT4_Re, vS0_Re, vS4_Re
  vfsub.vv    vT4_Im, vS0_Im, vS4_Im
  /* u3 = t4       */
  /* v3 = u3                      */
  /* u2 = t0 - t2  */
  vfsub.vv    vU2_Re, vT0_Re, vT2_Re
  
    li        tmp3, 256
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX7_Re, (tmp0)  /* tmp0 is pIn7_iter */
  
  vfsub.vv    vU2_Im, vT0_Im, vT2_Im

    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX5_Re, (tmp0)  /* tmp0 is pIn5_iter */
  
  /* v2 = u2                      */
  /* w2 =  v2      */
  /* u0 = t0 + t2  */
  vfadd.vv    vU0_Re, vT0_Re, vT2_Re
  vfadd.vv    vU0_Im, vT0_Im, vT2_Im
  /* v0 = u0 */
  
  /* r1 = x1 */
  /* r7 = x7 */
  /* s1 = r1 + r7 */
  vfadd.vv    vS1_Re, vR1_Re, vR7_Re
//?
  /* r3 = x3 */
  /* r5 = x5 */
  /* s5 = r3 - r5 */
  vfsub.vv    vS5_Re, vR3_Re, vR5_Re
  vfsub.vv    vS5_Im, vR3_Im, vR5_Im
  /* s3 = r3 + r5 */
  vfadd.vv    vS3_Re, vR3_Re, vR5_Re
  vfadd.vv    vS3_Im, vR3_Im, vR5_Im
//?

  vfadd.vv    vS1_Im, vR1_Im, vR7_Im
  /* s7 = r1 - r7 */
  vfsub.vv    vS7_Re, vR1_Re, vR7_Re
  vfsub.vv    vS7_Im, vR1_Im, vR7_Im
  
  /* t1 = -s1 + s3 */
  vfsub.vv    vT1_Re, vS3_Re, vS1_Re
  vfsub.vv    vT1_Im, vS3_Im, vS1_Im

  /* t3 =  s1 + s3 */
  vfadd.vv    vT3_Re, vS1_Re, vS3_Re
  vfadd.vv    vT3_Im, vS1_Im, vS3_Im
  /* u1 = t1       */
  li tmp0, 0x3f3504f3 
  fmv.w.x sqrt2_by_2, tmp0
  /* v1 = sqrt(2.)/2. * u1        */
  vfmul.vf    vV1_Re, vU1_Re, sqrt2_by_2
  vfmul.vf    vV1_Im, vU1_Im, sqrt2_by_2
  /* u4 = t3       */
  /* v4 = u4                      */
  /* w0 =  v0 + v4 */
  vfadd.vv    vW0_Re, vV0_Re, vV4_Re
  vfadd.vv    vW0_Im, vV0_Im, vV4_Im
  /* y0 = w0      */
  vsseg2e32.v vY0_Re, (pOut0_iter)
  /* w4 =  v0 - v4 */
  vfsub.vv    vW4_Re, vV0_Re, vV4_Re
  vfsub.vv    vW4_Im, vV0_Im, vV4_Im
  
  /* t7 =  s5 + s7 */
  vfadd.vv    vT7_Re, vS5_Re, vS7_Re
  vfadd.vv    vT7_Im, vS5_Im, vS7_Im
  /* t5 = -s5 + s7 */
  vfsub.vv    vT5_Re, vS7_Re, vS5_Re
  vfsub.vv    vT5_Im, vS7_Im, vS5_Im

  /* y4 = w4      */
  
    li        tmp3, 256
    add       tmp0, pOut0_iter, tmp3
  vsseg2e32.v vY4_Re, (tmp0)  /* tmp0 is pOut4_iter */

  /* u6 = t5       */
  /* v6 = -I * u6                 */
  // vV6_Re is vU6_Im
  // vV6_Im is vU6_Re*(-1)
  /* w6 =  v6      */
  /* u7 = t7       */
  /* v7 = -I * sqrt(2.)/2. * u7   */
  vfmul.vf    vV7_Im_neg, vU7_Re, sqrt2_by_2
  vfmul.vf    vV7_Re, vU7_Im, sqrt2_by_2
  /* w3 =  v1 + v3 */
  vfadd.vv    vW3_Re, vV1_Re, vV3_Re
  vfadd.vv    vW3_Im, vV1_Im, vV3_Im
  /* w5 = -v5 + v7 */
  // vW5_Im = vV7_Im - vV5_Im = vV7_Im + vU5_Re = vU5_Re - vV7_Im_neg
  vfsub.vv    vW5_Im, vU5_Re, vV7_Im_neg
  vfsub.vv    vW5_Re, vV7_Re, vV5_Re

    slli      tmp1, vl, 3        /* 2 elements/segment; 4 bytes/element */
    add       pIn0_iter, pIn0_iter, tmp1
    add       pOut0_iter, pOut0_iter, tmp1

    li        tmp3, 128
    add       tmp1, pIn0_iter, tmp3
  vlseg2e32.v   vX2_Re_2nd, (tmp1)  /* tmp1 is pIn2_iter */
  
  /* w7 =  v5 + v7 */
  vfadd.vv    vW7_Re, vV5_Re, vV7_Re
  // vW7_Im     = vW5_Im + vV7_Im = vV7_Im - vU5_Re = - vV7_Im_neg - vU5_Re
  // vW7_Im_neg = vV7_Im_neg + vU5_Re
  vfadd.vv    vW7_Im_neg, vV7_Im_neg, vU5_Re
  /* w1 = -v1 + v3 */
  vfsub.vv    vW1_Re, vV3_Re, vV1_Re
  vfsub.vv    vW1_Im, vV3_Im, vV1_Im

  /* y2 = w2 + w6 */
  vfadd.vv    vY2_Re, vW2_Re, vW6_Re
  // vY2_Im = vW2_Im + vW6_Im = vW2_Im - vU6_Re
  vfsub.vv    vY2_Im, vW2_Im, vU6_Re
  
    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */
  
  /* y1 = w1 + w7 */
  vfadd.vv    vY1_Re, vW1_Re, vW7_Re
  
  /* r2 =  x2 */
    li        tmp3, 256
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX6_Re_2nd, (tmp1)  /* tmp1 is pIn6_iter */
  
  vfsub.vv    vY1_Im, vW1_Im, vW7_Im_neg
  
  /* y7 = w1 - w7 */
  vfsub.vv    vY7_Re, vW1_Re, vW7_Re
  vfadd.vv    vY7_Im, vW1_Im, vW7_Im_neg
  
  /* y6 = w2 - w6 */
  vfsub.vv    vY6_Re, vW2_Re, vW6_Re
  // vY6_Im = vW2_Im - vW6_Im = vW2_Im + vU6_Re
  vfadd.vv    vY6_Im, vW2_Im, vU6_Re
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */
  
  /* y3 = w3 + w5 */
  vfadd.vv    vY3_Re, vW3_Re, vW5_Re

  /* r0 = x0 */
  /* vR0_Re and vR0_Im not changed */
  vlseg2e32.v   vR0_Re_2nd, (pIn0_iter)

  vfadd.vv    vY3_Im, vW3_Im, vW5_Im
  
    li        tmp3, 384
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY7_Re, (tmp0)  /* tmp0 is pOut7_iter */
  
  /* y5 = w3 - w5 */
  vfsub.vv    vY5_Re, vW3_Re, vW5_Re

    li        tmp3, -128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX4_Re_2nd, (tmp1)  /* tmp1 is pIn4_iter */

  vfsub.vv    vY5_Im, vW3_Im, vW5_Im

  /* r6 = x6 */
  /* s2 = r2 + r6 */
  vfadd.vv    vS2_Re, vR2_Re_2nd, vR6_Re_2nd
  vfadd.vv    vS2_Im, vR2_Im_2nd, vR6_Im_2nd
  
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY6_Re, (tmp0)  /* tmp0 is pOut6_iter */

  /* s6 = r2 - r6 */
  vfsub.vv    vS6_Re, vR2_Re_2nd, vR6_Re_2nd

    li        tmp3, -192
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX1_Re, (tmp1)  /* tmp1 is pIn1_iter */

  vfsub.vv    vS6_Im, vR2_Im_2nd, vR6_Im_2nd

    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */
  
  vfadd.vv    vT0_Re, vS0_Re_2nd, vS4_Re_2nd

  vfadd.vv    vT0_Im, vS0_Im_2nd, vS4_Im_2nd
  
    li        tmp3, 128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX3_Re, (tmp1)  /* tmp1 is pIn3_iter */

  /* t4 =  s0 - s4 */
  vfsub.vv    vT4_Re, vS0_Re_2nd, vS4_Re_2nd

    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY5_Re, (tmp0)  /* tmp0 is pOut5_iter */
  
    sub       avl, avl, vl

    beq       avl, vl, label_i0_jepilog_load_normal_store_normal_jvec_general_l1

///////////////////////////////////////////////////////////////// 222222222222222222222222222222222222222 
label_i0_jmiddle_load_normal_store_normal_jvec_general_l1:
  vsetvli     vl, avl, e32, m1, tu,mu
  
  /* t2 =  s2      */
  /* t6 =  s6      */
  /* u5 = t6       */
  /* v5 = -I * u5                 */
  // vV5_Re is vU5_Im
  // vV5_Im should be ( -1 * vU5_Re )
  /* s0 = r0      */
  
  /* r4 =  x4 */
  /* s4 = r4      */
  /* t0 =  s0 + s4 */

  vfsub.vv    vT4_Im, vS0_Im_2nd, vS4_Im_2nd
  /* u3 = t4       */
  /* v3 = u3                      */
  /* u2 = t0 - t2  */
  vfsub.vv    vU2_Re, vT0_Re, vT2_Re
  
    li        tmp3, 256
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX7_Re, (tmp1)  /* tmp1 is pIn7_iter */
  
  vfsub.vv    vU2_Im, vT0_Im, vT2_Im

    li        tmp3, -128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX5_Re, (tmp1)  /* tmp1 is pIn5_iter */
  
  /* v2 = u2                      */
  /* w2 =  v2      */
  /* u0 = t0 + t2  */
  vfadd.vv    vU0_Re, vT0_Re, vT2_Re
  vfadd.vv    vU0_Im, vT0_Im, vT2_Im
  /* v0 = u0 */
  
  /* r1 = x1 */
  /* r7 = x7 */
  /* s1 = r1 + r7 */
  vfadd.vv    vS1_Re, vR1_Re, vR7_Re
//?
  /* r3 = x3 */
  /* r5 = x5 */
  /* s5 = r3 - r5 */
  vfsub.vv    vS5_Re, vR3_Re, vR5_Re
  vfsub.vv    vS5_Im, vR3_Im, vR5_Im
  /* s3 = r3 + r5 */
  vfadd.vv    vS3_Re, vR3_Re, vR5_Re
  vfadd.vv    vS3_Im, vR3_Im, vR5_Im
//?

  vfadd.vv    vS1_Im, vR1_Im, vR7_Im
  /* s7 = r1 - r7 */
  vfsub.vv    vS7_Re, vR1_Re, vR7_Re
  vfsub.vv    vS7_Im, vR1_Im, vR7_Im
  
  /* t1 = -s1 + s3 */
  vfsub.vv    vT1_Re, vS3_Re, vS1_Re
  vfsub.vv    vT1_Im, vS3_Im, vS1_Im

  /* t3 =  s1 + s3 */
  vfadd.vv    vT3_Re, vS1_Re, vS3_Re
  vfadd.vv    vT3_Im, vS1_Im, vS3_Im
  /* u1 = t1       */
  li tmp0, 0x3f3504f3 
  fmv.w.x sqrt2_by_2, tmp0
  /* v1 = sqrt(2.)/2. * u1        */
  vfmul.vf    vV1_Re, vU1_Re, sqrt2_by_2
  vfmul.vf    vV1_Im, vU1_Im, sqrt2_by_2
  /* u4 = t3       */
  /* v4 = u4                      */
  /* w0 =  v0 + v4 */
  vfadd.vv    vW0_Re, vV0_Re, vV4_Re
  vfadd.vv    vW0_Im, vV0_Im, vV4_Im
  /* y0 = w0      */
  vsseg2e32.v vY0_Re, (pOut0_iter)
  /* w4 =  v0 - v4 */
  vfsub.vv    vW4_Re, vV0_Re, vV4_Re
  vfsub.vv    vW4_Im, vV0_Im, vV4_Im
  
  /* t7 =  s5 + s7 */
  vfadd.vv    vT7_Re, vS5_Re, vS7_Re
  vfadd.vv    vT7_Im, vS5_Im, vS7_Im
  /* t5 = -s5 + s7 */
  vfsub.vv    vT5_Re, vS7_Re, vS5_Re
  vfsub.vv    vT5_Im, vS7_Im, vS5_Im

  /* y4 = w4      */
  
    li        tmp3, 256
    add       tmp0, pOut0_iter, tmp3
  vsseg2e32.v vY4_Re, (tmp0)  /* tmp0 is pOut4_iter */

  /* u6 = t5       */
  /* v6 = -I * u6                 */
  // vV6_Re is vU6_Im
  // vV6_Im is vU6_Re*(-1)
  /* w6 =  v6      */
  /* u7 = t7       */
  /* v7 = -I * sqrt(2.)/2. * u7   */
  vfmul.vf    vV7_Im_neg, vU7_Re, sqrt2_by_2
  vfmul.vf    vV7_Re, vU7_Im, sqrt2_by_2
  /* w3 =  v1 + v3 */
  vfadd.vv    vW3_Re, vV1_Re, vV3_Re
  vfadd.vv    vW3_Im, vV1_Im, vV3_Im
  /* w5 = -v5 + v7 */
  // vW5_Im = vV7_Im - vV5_Im = vV7_Im + vU5_Re = vU5_Re - vV7_Im_neg
  vfsub.vv    vW5_Im, vU5_Re, vV7_Im_neg
  vfsub.vv    vW5_Re, vV7_Re, vV5_Re

    slli      tmp1, vl, 3        /* 2 elements/segment; 4 bytes/element */
    add       pIn0_iter, pIn0_iter, tmp1
    add       pOut0_iter, pOut0_iter, tmp1

    li        tmp3, 128
    add       tmp1, pIn0_iter, tmp3
  vlseg2e32.v   vX2_Re_2nd, (tmp1)  /* tmp1 is pIn2_iter */
  
  /* w7 =  v5 + v7 */
  vfadd.vv    vW7_Re, vV5_Re, vV7_Re
  // vW7_Im     = vW5_Im + vV7_Im = vV7_Im - vU5_Re = - vV7_Im_neg - vU5_Re
  // vW7_Im_neg = vV7_Im_neg + vU5_Re
  vfadd.vv    vW7_Im_neg, vV7_Im_neg, vU5_Re
  /* w1 = -v1 + v3 */
  vfsub.vv    vW1_Re, vV3_Re, vV1_Re
  vfsub.vv    vW1_Im, vV3_Im, vV1_Im

  /* y2 = w2 + w6 */
  vfadd.vv    vY2_Re, vW2_Re, vW6_Re
  // vY2_Im = vW2_Im + vW6_Im = vW2_Im - vU6_Re
  vfsub.vv    vY2_Im, vW2_Im, vU6_Re
  
    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */
  
  /* y1 = w1 + w7 */
  vfadd.vv    vY1_Re, vW1_Re, vW7_Re

  /* r2 =  x2 */
    li        tmp3, 256
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX6_Re_2nd, (tmp1)  /* tmp1 is pIn6_iter */

  vfsub.vv    vY1_Im, vW1_Im, vW7_Im_neg
  
  /* y7 = w1 - w7 */
  vfsub.vv    vY7_Re, vW1_Re, vW7_Re
  vfadd.vv    vY7_Im, vW1_Im, vW7_Im_neg
  
  /* y6 = w2 - w6 */
  vfsub.vv    vY6_Re, vW2_Re, vW6_Re
  // vY6_Im = vW2_Im - vW6_Im = vW2_Im + vU6_Re
  vfadd.vv    vY6_Im, vW2_Im, vU6_Re
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */
  
  /* y3 = w3 + w5 */
  vfadd.vv    vY3_Re, vW3_Re, vW5_Re

  /* r0 = x0 */
  /* vR0_Re and vR0_Im not changed */
  vlseg2e32.v   vR0_Re_2nd, (pIn0_iter)

  vfadd.vv    vY3_Im, vW3_Im, vW5_Im
  
    li        tmp3, 384
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY7_Re, (tmp0)  /* tmp0 is pOut7_iter */
  
  /* y5 = w3 - w5 */
  vfsub.vv    vY5_Re, vW3_Re, vW5_Re

    li        tmp3, -128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX4_Re_2nd, (tmp1)  /* tmp1 is pIn4_iter */
  
  vfsub.vv    vY5_Im, vW3_Im, vW5_Im
  
  /* r6 = x6 */
  /* s2 = r2 + r6 */
  vfadd.vv    vS2_Re, vR2_Re_2nd, vR6_Re_2nd
  vfadd.vv    vS2_Im, vR2_Im_2nd, vR6_Im_2nd
  

    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY6_Re, (tmp0)  /* tmp0 is pOut6_iter */

  /* s6 = r2 - r6 */
  vfsub.vv    vS6_Re, vR2_Re_2nd, vR6_Re_2nd

    li        tmp3, -192
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX1_Re, (tmp1)  /* tmp1 is pIn1_iter */

  vfsub.vv    vS6_Im, vR2_Im_2nd, vR6_Im_2nd
  
    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */
  
  vfadd.vv    vT0_Re, vS0_Re_2nd, vS4_Re_2nd

  vfadd.vv    vT0_Im, vS0_Im_2nd, vS4_Im_2nd

    li        tmp3, 128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX3_Re, (tmp1)  /* tmp1 is pIn3_iter */

  /* t4 =  s0 - s4 */
  vfsub.vv    vT4_Re, vS0_Re_2nd, vS4_Re_2nd

    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY5_Re, (tmp0)  /* tmp0 is pOut5_iter */
  
    sub       avl, avl, vl
///////////////////////////////////////////////////////////////// 3333333333333333333333333333333333
    sub       tmp3, avl, vl
  bnez tmp3, label_i0_jmiddle_load_normal_store_normal_jvec_general_l1
///////////////////////////////////////////////////////////////// 444444444444444444444444444444444444

label_i0_jepilog_load_normal_store_normal_jvec_general_l1:
  vsetvli     vl, avl, e32, m1, tu,mu
  
  /* t2 =  s2      */
  /* t6 =  s6      */
  /* u5 = t6       */
  /* v5 = -I * u5                 */
  // vV5_Re is vU5_Im
  // vV5_Im should be ( -1 * vU5_Re )
  /* s0 = r0      */
  
  /* r4 =  x4 */
  /* s4 = r4      */
  /* t0 =  s0 + s4 */

  vfsub.vv    vT4_Im, vS0_Im_2nd, vS4_Im_2nd
  /* u3 = t4       */
  /* v3 = u3                      */
  /* u2 = t0 - t2  */
  vfsub.vv    vU2_Re, vT0_Re, vT2_Re
  
    li        tmp3, 256
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX7_Re, (tmp1)  /* tmp1 is pIn7_iter */
  
  vfsub.vv    vU2_Im, vT0_Im, vT2_Im

    li        tmp3, -128
    add       tmp1, tmp1, tmp3
  vlseg2e32.v   vX5_Re, (tmp1)  /* tmp1 is pIn5_iter */
  
  /* v2 = u2                      */
  /* w2 =  v2      */
  /* u0 = t0 + t2  */
  vfadd.vv    vU0_Re, vT0_Re, vT2_Re
  vfadd.vv    vU0_Im, vT0_Im, vT2_Im
  /* v0 = u0 */
  
  /* r1 = x1 */
  /* r7 = x7 */
  /* s1 = r1 + r7 */
  vfadd.vv    vS1_Re, vR1_Re, vR7_Re
//?
  /* r3 = x3 */
  /* r5 = x5 */
  /* s5 = r3 - r5 */
  vfsub.vv    vS5_Re, vR3_Re, vR5_Re
  vfsub.vv    vS5_Im, vR3_Im, vR5_Im
  /* s3 = r3 + r5 */
  vfadd.vv    vS3_Re, vR3_Re, vR5_Re
  vfadd.vv    vS3_Im, vR3_Im, vR5_Im
//?

  vfadd.vv    vS1_Im, vR1_Im, vR7_Im
  /* s7 = r1 - r7 */
  vfsub.vv    vS7_Re, vR1_Re, vR7_Re
  vfsub.vv    vS7_Im, vR1_Im, vR7_Im
  
  /* t1 = -s1 + s3 */
  vfsub.vv    vT1_Re, vS3_Re, vS1_Re
  vfsub.vv    vT1_Im, vS3_Im, vS1_Im

  /* t3 =  s1 + s3 */
  vfadd.vv    vT3_Re, vS1_Re, vS3_Re
  vfadd.vv    vT3_Im, vS1_Im, vS3_Im
  /* u1 = t1       */
  li tmp0, 0x3f3504f3 
  fmv.w.x sqrt2_by_2, tmp0
  /* v1 = sqrt(2.)/2. * u1        */
  vfmul.vf    vV1_Re, vU1_Re, sqrt2_by_2
  vfmul.vf    vV1_Im, vU1_Im, sqrt2_by_2
  /* u4 = t3       */
  /* v4 = u4                      */
  /* w0 =  v0 + v4 */
  vfadd.vv    vW0_Re, vV0_Re, vV4_Re
  vfadd.vv    vW0_Im, vV0_Im, vV4_Im
  /* y0 = w0      */
  vsseg2e32.v vY0_Re, (pOut0_iter)
  /* w4 =  v0 - v4 */
  vfsub.vv    vW4_Re, vV0_Re, vV4_Re
  vfsub.vv    vW4_Im, vV0_Im, vV4_Im
  
  /* t7 =  s5 + s7 */
  vfadd.vv    vT7_Re, vS5_Re, vS7_Re
  vfadd.vv    vT7_Im, vS5_Im, vS7_Im
  /* t5 = -s5 + s7 */
  vfsub.vv    vT5_Re, vS7_Re, vS5_Re
  vfsub.vv    vT5_Im, vS7_Im, vS5_Im

  /* y4 = w4      */
  
    li        tmp3, 256
    add       tmp0, pOut0_iter, tmp3
  vsseg2e32.v vY4_Re, (tmp0)  /* tmp0 is pOut4_iter */

  /* u6 = t5       */
  /* v6 = -I * u6                 */
  // vV6_Re is vU6_Im
  // vV6_Im is vU6_Re*(-1)
  /* w6 =  v6      */
  /* u7 = t7       */
  /* v7 = -I * sqrt(2.)/2. * u7   */
  vfmul.vf    vV7_Im_neg, vU7_Re, sqrt2_by_2
  vfmul.vf    vV7_Re, vU7_Im, sqrt2_by_2
  /* w3 =  v1 + v3 */
  vfadd.vv    vW3_Re, vV1_Re, vV3_Re
  vfadd.vv    vW3_Im, vV1_Im, vV3_Im
  /* w5 = -v5 + v7 */
  // vW5_Im = vV7_Im - vV5_Im = vV7_Im + vU5_Re = vU5_Re - vV7_Im_neg
  vfsub.vv    vW5_Im, vU5_Re, vV7_Im_neg
  vfsub.vv    vW5_Re, vV7_Re, vV5_Re
  /* w7 =  v5 + v7 */
  vfadd.vv    vW7_Re, vV5_Re, vV7_Re
  // vW7_Im     = vW5_Im + vV7_Im = vV7_Im - vU5_Re = - vV7_Im_neg - vU5_Re
  // vW7_Im_neg = vV7_Im_neg + vU5_Re
  vfadd.vv    vW7_Im_neg, vV7_Im_neg, vU5_Re
  /* w1 = -v1 + v3 */
  vfsub.vv    vW1_Re, vV3_Re, vV1_Re
  vfsub.vv    vW1_Im, vV3_Im, vV1_Im

  /* y2 = w2 + w6 */
  vfadd.vv    vY2_Re, vW2_Re, vW6_Re
  // vY2_Im = vW2_Im + vW6_Im = vW2_Im - vU6_Re
  vfsub.vv    vY2_Im, vW2_Im, vU6_Re
  
    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */
  
  /* y1 = w1 + w7 */
  vfadd.vv    vY1_Re, vW1_Re, vW7_Re
  vfsub.vv    vY1_Im, vW1_Im, vW7_Im_neg
  
  /* y7 = w1 - w7 */
  vfsub.vv    vY7_Re, vW1_Re, vW7_Re
  vfadd.vv    vY7_Im, vW1_Im, vW7_Im_neg
  
  /* y6 = w2 - w6 */
  vfsub.vv    vY6_Re, vW2_Re, vW6_Re
  // vY6_Im = vW2_Im - vW6_Im = vW2_Im + vU6_Re
  vfadd.vv    vY6_Im, vW2_Im, vU6_Re
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */
  
  /* y3 = w3 + w5 */
  vfadd.vv    vY3_Re, vW3_Re, vW5_Re
  vfadd.vv    vY3_Im, vW3_Im, vW5_Im
  
    li        tmp3, 384
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY7_Re, (tmp0)  /* tmp0 is pOut7_iter */
  
  /* y5 = w3 - w5 */
  vfsub.vv    vY5_Re, vW3_Re, vW5_Re
  vfsub.vv    vY5_Im, vW3_Im, vW5_Im
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY6_Re, (tmp0)  /* tmp0 is pOut6_iter */
  
    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */
  
    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY5_Re, (tmp0)  /* tmp0 is pOut5_iter */


    j         exit_l1
  


label_i0_jcase1_load_normal_store_normal_jvec_general_l1:
    li        tmp3, 128
    add       tmp0, pIn0_iter, tmp3
  vlseg2e32.v   vX2_Re, (tmp0)  /* tmp0 is pIn2_iter */
  
  /* r2 =  x2 */
    li        tmp3, 256
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX6_Re, (tmp0)  /* tmp0 is pIn6_iter */
  
  /* r0 = x0 */
  /* vR0_Re and vR0_Im not changed */
  vlseg2e32.v   vR0_Re, (pIn0_iter)

    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX4_Re, (tmp0)  /* tmp0 is pIn4_iter */
  
  /* r6 = x6 */
  /* s2 = r2 + r6 */
  vfadd.vv    vS2_Re, vR2_Re, vR6_Re
  vfadd.vv    vS2_Im, vR2_Im, vR6_Im
  
  /* s6 = r2 - r6 */
  vfsub.vv    vS6_Re, vR2_Re, vR6_Re

    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX1_Re, (tmp0)  /* tmp0 is pIn1_iter */

  vfsub.vv    vS6_Im, vR2_Im, vR6_Im
  /* t2 =  s2      */
  /* t6 =  s6      */
  /* u5 = t6       */
  /* v5 = -I * u5                 */
  // vV5_Re is vU5_Im
  // vV5_Im should be ( -1 * vU5_Re )
  /* s0 = r0      */
  
  /* r4 =  x4 */
  /* s4 = r4      */
  /* t0 =  s0 + s4 */
  vfadd.vv    vT0_Re, vS0_Re, vS4_Re

    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX3_Re, (tmp0)  /* tmp0 is pIn3_iter */
  
  vfadd.vv    vT0_Im, vS0_Im, vS4_Im

  /* t4 =  s0 - s4 */
  vfsub.vv    vT4_Re, vS0_Re, vS4_Re
  vfsub.vv    vT4_Im, vS0_Im, vS4_Im
  /* u3 = t4       */
  /* v3 = u3                      */
  /* u2 = t0 - t2  */
  vfsub.vv    vU2_Re, vT0_Re, vT2_Re
  
    li        tmp3, 256
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX7_Re, (tmp0)  /* tmp0 is pIn7_iter */
  
  vfsub.vv    vU2_Im, vT0_Im, vT2_Im

    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vlseg2e32.v   vX5_Re, (tmp0)  /* tmp0 is pIn5_iter */
  
  /* v2 = u2                      */
  /* w2 =  v2      */
  /* u0 = t0 + t2  */
  vfadd.vv    vU0_Re, vT0_Re, vT2_Re
  vfadd.vv    vU0_Im, vT0_Im, vT2_Im
  /* v0 = u0 */
  
  /* r1 = x1 */
  /* r7 = x7 */
  /* s1 = r1 + r7 */
  vfadd.vv    vS1_Re, vR1_Re, vR7_Re
//?
  /* r3 = x3 */
  /* r5 = x5 */
  /* s5 = r3 - r5 */
  vfsub.vv    vS5_Re, vR3_Re, vR5_Re
  vfsub.vv    vS5_Im, vR3_Im, vR5_Im
  /* s3 = r3 + r5 */
  vfadd.vv    vS3_Re, vR3_Re, vR5_Re
  vfadd.vv    vS3_Im, vR3_Im, vR5_Im
//?

  vfadd.vv    vS1_Im, vR1_Im, vR7_Im
  /* s7 = r1 - r7 */
  vfsub.vv    vS7_Re, vR1_Re, vR7_Re
  vfsub.vv    vS7_Im, vR1_Im, vR7_Im
  
  /* t1 = -s1 + s3 */
  vfsub.vv    vT1_Re, vS3_Re, vS1_Re
  vfsub.vv    vT1_Im, vS3_Im, vS1_Im

  /* t3 =  s1 + s3 */
  vfadd.vv    vT3_Re, vS1_Re, vS3_Re
  vfadd.vv    vT3_Im, vS1_Im, vS3_Im
  /* u1 = t1       */
  li tmp0, 0x3f3504f3 
  fmv.w.x sqrt2_by_2, tmp0
  /* v1 = sqrt(2.)/2. * u1        */
  vfmul.vf    vV1_Re, vU1_Re, sqrt2_by_2
  vfmul.vf    vV1_Im, vU1_Im, sqrt2_by_2
  /* u4 = t3       */
  /* v4 = u4                      */
  /* w0 =  v0 + v4 */
  vfadd.vv    vW0_Re, vV0_Re, vV4_Re
  vfadd.vv    vW0_Im, vV0_Im, vV4_Im
  /* y0 = w0      */
  vsseg2e32.v vY0_Re, (pOut0_iter)
  /* w4 =  v0 - v4 */
  vfsub.vv    vW4_Re, vV0_Re, vV4_Re
  vfsub.vv    vW4_Im, vV0_Im, vV4_Im
  
  /* t7 =  s5 + s7 */
  vfadd.vv    vT7_Re, vS5_Re, vS7_Re
  vfadd.vv    vT7_Im, vS5_Im, vS7_Im
  /* t5 = -s5 + s7 */
  vfsub.vv    vT5_Re, vS7_Re, vS5_Re
  vfsub.vv    vT5_Im, vS7_Im, vS5_Im

  /* y4 = w4      */
  
    li        tmp3, 256
    add       tmp0, pOut0_iter, tmp3
  vsseg2e32.v vY4_Re, (tmp0)  /* tmp0 is pOut4_iter */

  /* u6 = t5       */
  /* v6 = -I * u6                 */
  // vV6_Re is vU6_Im
  // vV6_Im is vU6_Re*(-1)
  /* w6 =  v6      */
  /* u7 = t7       */
  /* v7 = -I * sqrt(2.)/2. * u7   */
  vfmul.vf    vV7_Im_neg, vU7_Re, sqrt2_by_2
  vfmul.vf    vV7_Re, vU7_Im, sqrt2_by_2
  /* w3 =  v1 + v3 */
  vfadd.vv    vW3_Re, vV1_Re, vV3_Re
  vfadd.vv    vW3_Im, vV1_Im, vV3_Im
  /* w5 = -v5 + v7 */
  // vW5_Im = vV7_Im - vV5_Im = vV7_Im + vU5_Re = vU5_Re - vV7_Im_neg
  vfsub.vv    vW5_Im, vU5_Re, vV7_Im_neg
  vfsub.vv    vW5_Re, vV7_Re, vV5_Re

  /* w7 =  v5 + v7 */
  vfadd.vv    vW7_Re, vV5_Re, vV7_Re
  // vW7_Im     = vW5_Im + vV7_Im = vV7_Im - vU5_Re = - vV7_Im_neg - vU5_Re
  // vW7_Im_neg = vV7_Im_neg + vU5_Re
  vfadd.vv    vW7_Im_neg, vV7_Im_neg, vU5_Re
  /* w1 = -v1 + v3 */
  vfsub.vv    vW1_Re, vV3_Re, vV1_Re
  vfsub.vv    vW1_Im, vV3_Im, vV1_Im

  /* y2 = w2 + w6 */
  vfadd.vv    vY2_Re, vW2_Re, vW6_Re
  // vY2_Im = vW2_Im + vW6_Im = vW2_Im - vU6_Re
  vfsub.vv    vY2_Im, vW2_Im, vU6_Re
  
    li        tmp3, -128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */
  
  /* y1 = w1 + w7 */
  vfadd.vv    vY1_Re, vW1_Re, vW7_Re
  
  /* r2 =  x2 */
  
  vfsub.vv    vY1_Im, vW1_Im, vW7_Im_neg
  
  /* y7 = w1 - w7 */
  vfsub.vv    vY7_Re, vW1_Re, vW7_Re
  vfadd.vv    vY7_Im, vW1_Im, vW7_Im_neg
  
  /* y6 = w2 - w6 */
  vfsub.vv    vY6_Re, vW2_Re, vW6_Re
  // vY6_Im = vW2_Im - vW6_Im = vW2_Im + vU6_Re
  vfadd.vv    vY6_Im, vW2_Im, vU6_Re
  
    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */
  
  /* y3 = w3 + w5 */
  vfadd.vv    vY3_Re, vW3_Re, vW5_Re
  vfadd.vv    vY3_Im, vW3_Im, vW5_Im
  
    li        tmp3, 384
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY7_Re, (tmp0)  /* tmp0 is pOut7_iter */
  
  /* y5 = w3 - w5 */
  vfsub.vv    vY5_Re, vW3_Re, vW5_Re
  vfsub.vv    vY5_Im, vW3_Im, vW5_Im

    li        tmp3, -64
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY6_Re, (tmp0)  /* tmp0 is pOut6_iter */

    li        tmp3, -192
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */

    li        tmp3, 128
    add       tmp0, tmp0, tmp3
  vsseg2e32.v vY5_Re, (tmp0)  /* tmp0 is pOut5_iter */
  
  /* end of i=0 special case */


exit_l1:

#undef pOut
#undef pIn


#undef pTwi
#undef tmp0
#undef tmp1
#undef st_stride
#undef tmp2
#undef tmp3

#undef avl
#undef vl
#undef i
#undef pIn0_iter
#undef pOut0_iter
#undef ld_stride

#undef vX2_Re
#undef vX2_Im
#undef vX2_Re_2nd
#undef vX2_Im_2nd
#undef vR2_Re
#undef vR2_Im
#undef vR2_Re_2nd
#undef vR2_Im_2nd
#undef vX6_Re
#undef vX6_Im
#undef vX6_Re_2nd
#undef vX6_Im_2nd
#undef vR6_Re
#undef vR6_Im
#undef vR6_Re_2nd
#undef vR6_Im_2nd
#undef vS2_Re
#undef vS2_Im
#undef vS6_Re
#undef vS6_Im
#undef vT2_Re
#undef vT2_Im
#undef vT6_Re
#undef vT6_Im
#undef vU5_Re
#undef vU5_Im
#undef vV5_Re
#undef vV5_Im_neg
#undef vR0_Re
#undef vR0_Im
#undef vR0_Re_2nd
#undef vR0_Im_2nd
#undef vS0_Re
#undef vS0_Re_2nd
#undef vS0_Im_2nd
#undef vS0_Im
#undef vX4_Re
#undef vX4_Im
#undef vX4_Re_2nd
#undef vX4_Im_2nd
#undef vR4_Re
#undef vR4_Im
#undef vR4_Re_2nd
#undef vR4_Im_2nd
#undef vS4_Re
#undef vS4_Im
#undef vS4_Re_2nd
#undef vS4_Im_2nd
#undef vT0_Re
#undef vT0_Im
#undef vT4_Re
#undef vT4_Im
#undef vU3_Re
#undef vU3_Im
#undef vV3_Re
#undef vV3_Im
#undef vU2_Re
#undef vU2_Im
#undef vV2_Re
#undef vV2_Im
#undef vW2_Re
#undef vW2_Im
#undef vU0_Re
#undef vU0_Im
#undef vV0_Re
#undef vV0_Im
#undef vX1_Re
#undef vX1_Im
#undef vX7_Re
#undef vX7_Im
#undef vR1_Re
#undef vR1_Im
#undef vR7_Re
#undef vR7_Im
#undef vS1_Re
#undef vS1_Im
#undef vS7_Re
#undef vS7_Im
#undef vX3_Re
#undef vX3_Im
#undef vR3_Re
#undef vR3_Im
#undef vX5_Re
#undef vX5_Im
#undef vR5_Re
#undef vR5_Im
#undef vS5_Re
#undef vS5_Im
#undef vS3_Re
#undef vS3_Im
#undef vT1_Re
#undef vT1_Im
#undef vU1_Re
#undef vU1_Im
#undef vV1_Re
#undef vV1_Im
#undef vT3_Re
#undef vT3_Im
#undef vU4_Re
#undef vU4_Im
#undef vV4_Re
#undef vV4_Im
#undef vW0_Re
#undef vW0_Im
#undef vY0_Re
#undef vY0_Im
#undef vW4_Re
#undef vW4_Im
#undef vY4_Re
#undef vY4_Im
#undef vT5_Re
#undef vT5_Im
#undef vU6_Re
#undef vU6_Im
#undef vV6_Re
#undef vV6_Im_neg
#undef vW6_Re
#undef vW6_Im_neg
#undef vT7_Re
#undef vT7_Im
#undef vU7_Re
#undef vU7_Im
#undef vV7_Re
#undef vV7_Im_neg
#undef vW5_Re
#undef vW5_Im
#undef vW7_Re
#undef vW7_Im_neg
#undef vW3_Re
#undef vW3_Im
#undef vW1_Re
#undef vW1_Im
#undef vY1_Re
#undef vY1_Im
#undef vY7_Re
#undef vY7_Im
#undef vY2_Re
#undef vY2_Im
#undef vY6_Re
#undef vY6_Im
#undef vY3_Re
#undef vY3_Im
#undef vY5_Re
#undef vY5_Im

#undef vColor0_Re
#undef vColor0_Im
#undef vColor1_Re
#undef vColor1_Im
#undef vColor2_Re
#undef vColor2_Im
#undef vColor3_Re
#undef vColor3_Im
#undef vColor4_Re
#undef vColor4_Im
#undef vColor5_Re 
#undef vColor5_Im 
#undef vColor6_Re 
#undef vColor6_Im 
#undef vColor7_Re 
#undef vColor7_Im 
#undef vColor8_Re 
#undef vColor8_Im 

#undef vColor9_Re
#undef vColor9_Im
#undef vColor10_Re 
#undef vColor10_Im
#undef vColor11_Re
#undef vColor11_Im
#undef vColor12_Re
#undef vColor12_Im
#undef vColor13_Re
#undef vColor13_Im
#undef vColor14_Re
#undef vColor14_Im
#undef vColor15_Re
#undef vColor15_Im

#undef twi1_Re
#undef twi1_Im
#undef twi2_Re
#undef twi2_Im
#undef twi3_Re
#undef twi3_Im
#undef twi4_Re
#undef twi4_Im
#undef twi5_Re
#undef twi5_Im
#undef twi6_Re
#undef twi6_Im
#undef twi7_Re
#undef twi7_Im
#undef sqrt2_by_2

/*
 * C reference code for stage-radix4-ivec-general.S:
 *
 * float complex *x = buf0, *y = buf1;
 * for (uint32_t l = 1u; l <= L; ++l)
 * {
 *   for (uint32_t i = 0u; i < 1u << 2u * (l - 1u); ++i)
 *     for (uint32_t j = 0u; j < 1u << 2u * (L - l); ++j)
 *     {
 *       float complex u0 =                               x[(i << 2u * (L - l + 1u))                        + j];
 *       float complex u1 = twi[     i << 2u * (L - l)] * x[(i << 2u * (L - l + 1u)) + (1u << 2u * (L - l)) + j];
 *       float complex u2 = twi[2u * i << 2u * (L - l)] * x[(i << 2u * (L - l + 1u)) + (2u << 2u * (L - l)) + j];
 *       float complex u3 = twi[3u * i << 2u * (L - l)] * x[(i << 2u * (L - l + 1u)) + (3u << 2u * (L - l)) + j];
 *       float complex v0 = u0 + u2;
 *       float complex v1 = u0 - u2;
 *       float complex v2 = u1 + u3;
 *       float complex v3 = u1 - u3;
 *       y[(i << 2u * (L - l))                        + j] = v0 + v2;
 *       y[(i << 2u * (L - l)) + (1u << 2u * (L - 1)) + j] = v1 - I * v3;
 *       y[(i << 2u * (L - l)) + (2u << 2u * (L - 1)) + j] = v0 - v2;
 *       y[(i << 2u * (L - l)) + (3u << 2u * (L - 1)) + j] = v1 + I * v3;
 *     }
 *   float complex* tmp = y; y = x; x = tmp;
 * }
 * 
 * C reference code for stage-radix4-transposed-ivec-general.S:
 *
 * for (uint32_t i = 0u; i < 1u << 2u * (l - 1u); ++i)
 *  for (uint32_t j = 0u; j < 1u << 2u * (L - l); ++j)
 *  {
 *      float complex u0 =                               x[(j << 2u * (l - 1u))                         + i];
 *      float complex u1 = twi[     i << 2u * (L - l)] * x[(j << 2u * (l - 1u)) + (1u << 2u * (L - 1u)) + i];
 *      float complex u2 = twi[2u * i << 2u * (L - l)] * x[(j << 2u * (l - 1u)) + (2u << 2u * (L - 1u)) + i];
 *      float complex u3 = twi[3u * i << 2u * (L - l)] * x[(j << 2u * (l - 1u)) + (3u << 2u * (L - 1u)) + i];
 *      float complex v0 = u0 + u2;
 *      float complex v1 = u0 - u2;
 *      float complex v2 = u1 + u3;
 *      float complex v3 = u1 - u3;
 *      y[(j << 2u * l)                         + i] = v0 + v2;
 *      y[(j << 2u * l) + (1u << 2u * (l - 1u)) + i] = v1 - I * v3;
 *      y[(j << 2u * l) + (2u << 2u * (l - 1u)) + i] = v0 - v2;
 *      y[(j << 2u * l) + (3u << 2u * (l - 1u)) + i] = v1 + I * v3;
 *  }
 * 
 * template parameter: stage-radix4-ivec-general-viu75-tuned, stage_idx: 2, load_trans: normal, store_trans: transposed, long_weight_vector: True
 */


#define pOut a0
#define pIn  a1


#define pTwi  a2
#define tmp0  a3
#define tmp1 a4
#define tmp2 a5
#define j    a6
#define tmp3 a7

#define avl t0
#define vl  t1
#define pIn0_iter t2
#define pOut0_iter t3
#define pTwi1_iter t4
#define iter_start_i t5
#define tmp4 t6

#define vColor0_Re v0
#define vColor0_Im v1
#define vColor1_Re v12   //v16
#define vColor1_Im v13   //v17
#define vColor2_Re v4
#define vColor2_Im v5
#define vColor3_Re v6
#define vColor3_Im v7
#define vColor4_Re v8
#define vColor4_Im v9

#define vColor5_Re v10
#define vColor5_Im v11
#define vColor6_Re v18         //v14
#define vColor6_Im v19         //v15
#define vColor7_Re v26
#define vColor7_Im v27

#define vTw1_Re vColor5_Re
#define vTw1_Im vColor5_Im
#define vTw2_Re vColor6_Re
#define vTw2_Im vColor6_Im
#define vTw3_Re vColor7_Re
#define vTw3_Im vColor7_Im

#define vX0_Re vColor0_Re
#define vX0_Im vColor0_Im
#define vX1_Re vColor5_Re_2nd
#define vX1_Im vColor5_Im_2nd
#define vX2_Re vColor1_Re
#define vX2_Im vColor1_Im
#define vX3_Re vColor6_Re_2nd
#define vX3_Im vColor6_Im_2nd
#define vU0_Re vColor0_Re
#define vU0_Im vColor0_Im
#define vU1_Re vColor2_Re
#define vU1_Im vColor2_Im
#define vU2_Re vColor2_Re
#define vU2_Im vColor2_Im
#define vU3_Re vColor4_Re
#define vU3_Im vColor4_Im
#define vV0_Re vColor1_Re
#define vV0_Im vColor1_Im
#define vV1_Re vColor3_Re
#define vV1_Im vColor3_Im
#define vV2_Re vColor0_Re
#define vV2_Im vColor0_Im
#define vV3_Re vColor2_Re
#define vV3_Im vColor2_Im
#define vY0_Re vColor5_Re_2nd
#define vY0_Im vColor5_Im_2nd
#define vY1_Re vColor6_Re_2nd
#define vY1_Im vColor6_Im_2nd
#define vY2_Re vColor4_Re
#define vY2_Im vColor4_Im
#define vY3_Re vColor5_Re_2nd
#define vY3_Im vColor5_Im_2nd

#define vColor0_Re_2nd v2
#define vColor0_Im_2nd v3
#define vColor1_Re_2nd v14     //v18
#define vColor1_Im_2nd v15     //v19
#define vColor2_Re_2nd v20
#define vColor2_Im_2nd v21
#define vColor3_Re_2nd v22
#define vColor3_Im_2nd v23
#define vColor4_Re_2nd v24
#define vColor4_Im_2nd v25

#define vColor5_Re_2nd v28
#define vColor5_Im_2nd v29
#define vColor6_Re_2nd v16      //v12
#define vColor6_Im_2nd v17      //v13
#define vColor7_Re_2nd v30
#define vColor7_Im_2nd v31

#define vX0_Re_2nd vColor0_Re_2nd
#define vX0_Im_2nd vColor0_Im_2nd
#define vX1_Re_2nd vColor7_Re_2nd
#define vX1_Im_2nd vColor7_Im_2nd
#define vX2_Re_2nd vColor1_Re_2nd
#define vX2_Im_2nd vColor1_Im_2nd
#define vX3_Re_2nd vColor6_Re
#define vX3_Im_2nd vColor6_Im
#define vU0_Re_2nd vColor0_Re_2nd
#define vU0_Im_2nd vColor0_Im_2nd
#define vU1_Re_2nd vColor2_Re_2nd
#define vU1_Im_2nd vColor2_Im_2nd
#define vU2_Re_2nd vColor2_Re_2nd
#define vU2_Im_2nd vColor2_Im_2nd
#define vU3_Re_2nd vColor4_Re_2nd
#define vU3_Im_2nd vColor4_Im_2nd
#define vV0_Re_2nd vColor1_Re_2nd
#define vV0_Im_2nd vColor1_Im_2nd
#define vV1_Re_2nd vColor3_Re_2nd
#define vV1_Im_2nd vColor3_Im_2nd
#define vV2_Re_2nd vColor0_Re_2nd
#define vV2_Im_2nd vColor0_Im_2nd
#define vV3_Re_2nd vColor2_Re_2nd
#define vV3_Im_2nd vColor2_Im_2nd
#define vY0_Re_2nd vColor6_Re_2nd
#define vY0_Im_2nd vColor6_Im_2nd
#define vY1_Re_2nd vColor7_Re        //vColor2_Re      //vColor1_Re_2nd
#define vY1_Im_2nd vColor7_Im        //vColor2_Im      //vColor1_Im_2nd
#define vY2_Re_2nd vColor4_Re_2nd
#define vY2_Im_2nd vColor4_Im_2nd
#define vY3_Re_2nd vColor4_Re
#define vY3_Im_2nd vColor4_Im

#define vY0_Re_3rd vColor0_Re
#define vY0_Im_3rd vColor0_Im
#define vY3_Re_3rd vColor3_Re        //vColor5_Re_2nd
#define vY3_Im_3rd vColor3_Im        //vColor5_Im_2nd

enter_l2:

    li        avl, 0x8
    li        iter_start_i, 0

    li        tmp0, 56  #lwv
    add       pTwi1_iter, pTwi, tmp0

    mv        pOut0_iter, pOut
    mv        pIn0_iter, pIn

loop_i2ip1_j0to3_iprolog_load_normal_store_transposed_ivec_general_l2:
  vsetvli     vl, avl, e32, m1, tu,mu

    beq       vl, avl, label_i0tovl_j0to3_load_normal_store_transposed_ivec_general_l2

    slli      tmp1, iter_start_i, 3
    add       tmp0, pTwi1_iter, tmp1
    li        tmp1, 0x40
  vlseg2e32.v  vTw1_Re, (tmp0)
    add       tmp0, tmp0, tmp1
  vlseg2e32.v  vTw2_Re, (tmp0)
    add       tmp0, tmp0, tmp1
  vlseg2e32.v  vTw3_Re, (tmp0)
 
    li        j, 0

    ///////////////////////////////////////////////////////////////////////////////////// 1st
    ///////////////////////////////////////////////////////////////////////////////////// 2nd

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp0  /* tmp1 is pIn2_iter */

    
    
    
    
  

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp0

    
    
  

    
    
    
    
    
  

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  

    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */
  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re
  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

    
    
  

  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re

  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re
  vfadd.vv    vV0_Im, vU0_Im, vU2_Im

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

    
    
  

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re
  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im

    
    
  


  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

    
    
  

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */
  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd
  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_2nd, (tmp4)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x40
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

    addi      j, j, 1

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */

  /* y3 = v1 + I * v3 */
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y3 = v1 + I * v3 */

    
    
    
    
  

  vfsub.vv    vY3_Re, vV1_Re, vV3_Im


  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    
    
    
    
    
  

  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    li        tmp2, 64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */


  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    li        tmp2, -128
    add       tmp0, tmp0, tmp2

  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  

    
    
  

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd
  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re
  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re

    
    
  


    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

    
    
  

  vfadd.vv    vV0_Im, vU0_Im, vU2_Im
  /* v0 = u0 + u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re



  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im
  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re

    
    
  

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */

    ///////////////////////////////////////////////////////////////////////////////////// 3rd
    ///////////////////////////////////////////////////////////////////////////////////// 4th


  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im

    
    
  

  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x80
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw3_Re, (tmp2)

  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */

  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd


  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

    sub       avl, avl, vl
    add       iter_start_i, iter_start_i, vl  /* iter_start_i is accumulated vl */
  vsetvli     vl, avl, e32, m1, tu,mu


    slli      tmp1, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp1
    li        tmp1, 0x40
  vlseg2e32.v  vTw1_Re, (tmp2)

    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    //////////////////////////////////////////
    li        tmp1, 4
    sll       tmp1, vl, tmp1

    slli      tmp2, tmp1, 2                   /* N[l] must be 4 (shift_bits = 2) */
    add       pIn0_iter, pIn0_iter, tmp2


    slli      tmp1, zero, 3      /* j=zero */ 
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp2  /* tmp1 is pIn1_iter */
    //////////////////////////////////////////

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_3rd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_3rd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_3rd, (tmp4)


    li        j, 0

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re


  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

 
    //////////////////////////////////////////
    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */
    //////////////////////////////////////////

    //////////////////////////////////////////
    
    

    
    
    
    
  
    //////////////////////////////////////////

  /* y3 = v1 + I * v3 */
  vfsub.vv    vY3_Re_3rd, vV1_Re, vV3_Im
  vfadd.vv    vY3_Im_3rd, vV1_Im, vV3_Re

    li        tmp2, -64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */
  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re
  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re_3rd, (tmp0)  /* tmp0 is pOut3_iter */

  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd


    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    
    
  

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re

    li        tmp2, -64
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd

  vfadd.vv    vV0_Re, vU0_Re, vU2_Re
  vfadd.vv    vV0_Im, vU0_Im, vU2_Im

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp3, 0x80
    add       tmp3, tmp2, tmp3
  vlseg2e32.v  vTw3_Re, (tmp3)

  vfsub.vv    vV1_Re, vU0_Re, vU2_Re
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im

  /* y3 = v1 + I * v3 */
    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */


    ///////////////////////////////////////////////////////////////////////////////////// 5th
    ///////////////////////////////////////////////////////////////////////////////////// 6th

    ///////////////////////////////////////////////////////////////////////////////////// 7th
    ///////////////////////////////////////////////////////////////////////////////////// 8th

    beq avl, vl, loop_i2ip1_j0to3_iepilog_load_normal_store_transposed_ivec_general_l2

loop_i2ip1_j0to3_imiddle_load_normal_store_transposed_ivec_general_l2:


    ///////////////////////////////////////////////////////////////////////////////////// 9th
    ///////////////////////////////////////////////////////////////////////////////////// 10th


    slli      tmp0, vl, 3      /* 4 bytes/element, 2 elements/segment */
    add       pOut0_iter, pOut0_iter, tmp0

  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re
  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */

    
    
    
    
    
  

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  


  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  

    
    
  

  

  
  

  
  

  /* v0 = u0 + u2 */
  
  

    li        tmp2, 48
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

    
    
  

  /* v1 = u0 - u2 */
  
  

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  
  

    
    
  


  /* v0 = u0 + u2 */
  
  

  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

    
    
  

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */
  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd
  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_2nd, (tmp4)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x40
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

    addi      j, j, 1

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */

  /* y3 = v1 + I * v3 */
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y3 = v1 + I * v3 */

    
    
    
    
  

  vfsub.vv    vY3_Re, vV1_Re, vV3_Im


  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    
    
    
    
    
  

  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    li        tmp2, 64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */


  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    li        tmp2, -128
    add       tmp0, tmp0, tmp2

  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  

    
    
  

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd
  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re
  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re

    
    
  


    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

    
    
  

  vfadd.vv    vV0_Im, vU0_Im, vU2_Im
  /* v0 = u0 + u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re



  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im
  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re

    
    
  

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */

    ///////////////////////////////////////////////////////////////////////////////////// 11th
    ///////////////////////////////////////////////////////////////////////////////////// 12th


  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im

    
    
  

  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x80
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw3_Re, (tmp2)

  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */

  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd


  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

    sub       avl, avl, vl
    add       iter_start_i, iter_start_i, vl  /* iter_start_i is accumulated vl */
  vsetvli     vl, avl, e32, m1, tu,mu


    slli      tmp1, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp1
    li        tmp1, 0x40
  vlseg2e32.v  vTw1_Re, (tmp2)

    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    //////////////////////////////////////////
    li        tmp1, 4
    sll       tmp1, vl, tmp1

    slli      tmp2, tmp1, 2                   /* N[l] must be 4 (shift_bits = 2) */
    add       pIn0_iter, pIn0_iter, tmp2


    slli      tmp1, zero, 3      /* j=zero */ 
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp2  /* tmp1 is pIn1_iter */
    //////////////////////////////////////////

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_3rd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_3rd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_3rd, (tmp4)


    li        j, 0

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re


  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

 
    //////////////////////////////////////////
    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */
    //////////////////////////////////////////

    //////////////////////////////////////////
    
    

    
    
    
    
  
    //////////////////////////////////////////

  /* y3 = v1 + I * v3 */
  vfsub.vv    vY3_Re_3rd, vV1_Re, vV3_Im
  vfadd.vv    vY3_Im_3rd, vV1_Im, vV3_Re

    li        tmp2, -64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */
  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re
  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re_3rd, (tmp0)  /* tmp0 is pOut3_iter */

  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd


    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    
    
  

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re

    li        tmp2, -64
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd

  vfadd.vv    vV0_Re, vU0_Re, vU2_Re
  vfadd.vv    vV0_Im, vU0_Im, vU2_Im

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp3, 0x80
    add       tmp3, tmp2, tmp3
  vlseg2e32.v  vTw3_Re, (tmp3)

  vfsub.vv    vV1_Re, vU0_Re, vU2_Re
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im

  /* y3 = v1 + I * v3 */
    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */


    ///////////////////////////////////////////////////////////////////////////////////// 13th
    ///////////////////////////////////////////////////////////////////////////////////// 14th

  // FIXME: what's the condition?
  sub       tmp2, avl, vl
  //sub       tmp2, tmp2, vl

  bnez      tmp2, loop_i2ip1_j0to3_imiddle_load_normal_store_transposed_ivec_general_l2

loop_i2ip1_j0to3_iepilog_load_normal_store_transposed_ivec_general_l2:

    slli      tmp0, vl, 3      /* 4 bytes/element, 2 elements/segment */
    add       pOut0_iter, pOut0_iter, tmp0

  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re
  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */

    
    
    
    
    
  

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  


  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  

    
    
  

  

  
  

  
  

  /* v0 = u0 + u2 */
  
  

    li        tmp2, 48
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp2  /* tmp1 is pIn3_iter */

    
    
  

  /* v1 = u0 - u2 */
  
  

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  
  

    
    
  


  /* v0 = u0 + u2 */
  
  

  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

    
    
  

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */
  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd
  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_2nd, (tmp4)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x40
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

    addi      j, j, 1

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */

  /* y3 = v1 + I * v3 */
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y3 = v1 + I * v3 */

    
    
    
    
  

  vfsub.vv    vY3_Re, vV1_Re, vV3_Im


  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    
    
    
    
    
  

  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    li        tmp2, 64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */


  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    li        tmp2, -128
    add       tmp0, tmp0, tmp2

  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    
  

    
    
  

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd
  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re
  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re

    
    
  


    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

    
    
  

  vfadd.vv    vV0_Im, vU0_Im, vU2_Im
  /* v0 = u0 + u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re



  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im
  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re

    
    
  

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */

    ///////////////////////////////////////////////////////////////////////////////////// 15th
    ///////////////////////////////////////////////////////////////////////////////////// 16th




  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im

    
    
  

  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x80
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw3_Re, (tmp2)

  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */

  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_3rd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_3rd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_3rd, (tmp4)

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

  /* y3 = v1 + I * v3 */
  vfsub.vv    vY3_Re, vV1_Re, vV3_Im
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, -64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* y3 = v1 + I * v3 */
    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */

    li        tmp1, 4
    sll       tmp1, vl, tmp1
    slli      tmp0, tmp1, 2                   /* N[l] must be 4 (shift_bits = 2) */
    add       pIn0_iter, pIn0_iter, tmp0
    slli      tmp0, vl, 3      /* 4 bytes/element, 2 elements/segment */
  
    add       pOut0_iter, pOut0_iter, tmp0

  //sub       avl, avl, vl
  //add       iter_start_i, iter_start_i, vl  /* iter_start_i is accumulated vl */
  //bnez      avl, loop_i2ip1_j0to3_iprolog_load_normal_store_transposed_ivec_general_l2


    beq x0, x0, exit_l2


label_i0tovl_j0to3_load_normal_store_transposed_ivec_general_l2:

    slli      tmp1, iter_start_i, 3
    add       tmp0, pTwi1_iter, tmp1
    li        tmp1, 0x40
  vlseg2e32.v  vTw1_Re, (tmp0)
    add       tmp0, tmp0, tmp1
  vlseg2e32.v  vTw2_Re, (tmp0)
    add       tmp0, tmp0, tmp1
  vlseg2e32.v  vTw3_Re, (tmp0)

    li        j, 0

    ///////////////////////////////////////////////////////////////////////////////////// case1-1st
    ///////////////////////////////////////////////////////////////////////////////////// case1-2nd

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp0  /* tmp1 is pIn2_iter */







  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp0





    
    
    


  

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */

    
  

    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */
  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re
  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

    
    
  

  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re

  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re
  vfadd.vv    vV0_Im, vU0_Im, vU2_Im

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */





  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re
  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im

    
    
  


  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd





  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */
  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd
  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)


  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_2nd, (tmp4)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x40
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw2_Re, (tmp2)

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

    addi      j, j, 1

    slli      tmp1, j, 3
    add       tmp1, tmp1, pIn0_iter
    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vX2_Re, (tmp1), tmp2  /* tmp1 is pIn2_iter */

  /* y3 = v1 + I * v3 */
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y3 = v1 + I * v3 */

    
    
    

  

  vfsub.vv    vY3_Re, vV1_Re, vV3_Im


  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    
    
    


  

  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd

    li        tmp2, 64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */


  vfmul.vv    vU2_Re, vTw2_Re, vX2_Re

  /* vU0_Re and vU0_Im not changed */
  /* u0 = x0 */
    li        tmp2, -32
    add       tmp1, tmp1, tmp2
    li        tmp2, 64
  vlsseg4e32.v  vU0_Re, (tmp1), tmp2

    li        tmp2, -128
    add       tmp0, tmp0, tmp2

  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  vfmul.vv    vU2_Im, vTw2_Re, vX2_Im
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd
  vfmul.vv    vU2_Re_2nd, vTw2_Re, vX2_Re_2nd

  /* vU0_Re_2nd and vU0_Im_2nd not changed */
  /* u0 = x0 */
    
    


    
    
  

  /* u2 = tw2 * x2 */
  /* vU2_Re_2nd <= ( vTwi2_Re * vX2_Re_2nd - vTwi2_Im * vX2_Im_2nd ) */
  /* vU2_Im_2nd <= ( vTwi2_Re * vX2_Im_2nd + vTwi2_Im * vX2_Re_2nd ) */
  vfmul.vv    vU2_Im_2nd, vTw2_Re, vX2_Im_2nd
  /* u2 = tw2 * x2 */
  /* vU2_Re <= ( vTwi2_Re * vX2_Re - vTwi2_Im * vX2_Im ) */
  /* vU2_Im <= ( vTwi2_Re * vX2_Im + vTwi2_Im * vX2_Re ) */


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2

  vfnmsac.vv  vU2_Re, vTw2_Im, vX2_Im
  vfmacc.vv   vU2_Im, vTw2_Im, vX2_Re
  vfnmsac.vv  vU2_Re_2nd, vTw2_Im, vX2_Im_2nd
  vfmacc.vv   vU2_Im_2nd, vTw2_Im, vX2_Re_2nd
  vfadd.vv    vV0_Re, vU0_Re, vU2_Re

    

  


    li        tmp2, 16
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX1_Re, (tmp1), tmp0  /* tmp1 is pIn1_iter */

    
    
  

  vfadd.vv    vV0_Im, vU0_Im, vU2_Im
  /* v0 = u0 + u2 */
  vfsub.vv    vV1_Re, vU0_Re, vU2_Re



  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Im, vU0_Im, vU2_Im
  /* v1 = u0 - u2 */
  vfsub.vv    vV1_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfsub.vv    vV1_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* v0 = u0 + u2 */
  vfadd.vv    vV0_Re_2nd, vU0_Re_2nd, vU2_Re_2nd
  vfadd.vv    vV0_Im_2nd, vU0_Im_2nd, vU2_Im_2nd

  /* u1 = tw1 * x1 */
  /* vU1_Re <= ( vTwi1_Re * vX1_Re - vTwi1_Im * vX1_Im ) */
  /* vU1_Im <= ( vTwi1_Re * vX1_Im + vTwi1_Im * vX1_Re ) */
  vfmul.vv    vU1_Re, vTw1_Re, vX1_Re

    
    
  

    li        tmp2, 32
    add       tmp1, tmp1, tmp2
    li        tmp0, 64
  vlsseg4e32.v  vX3_Re, (tmp1), tmp0  /* tmp1 is pIn3_iter */

  vfmul.vv    vU1_Im, vTw1_Re, vX1_Im


    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */

    ///////////////////////////////////////////////////////////////////////////////////// case1-3rd
    ///////////////////////////////////////////////////////////////////////////////////// case1-4th




  vfnmsac.vv  vU1_Re, vTw1_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTw1_Im, vX1_Re

  /* u1 = tw1 * x1 */
  /* vU1_Re_2nd <= ( vTwi1_Re * vX1_Re_2nd - vTwi1_Im * vX1_Im_2nd ) */
  /* vU1_Im_2nd <= ( vTwi1_Re * vX1_Im_2nd + vTwi1_Im * vX1_Re_2nd ) */
  vfmul.vv    vU1_Re_2nd, vTw1_Re, vX1_Re_2nd
  vfmul.vv    vU1_Im_2nd, vTw1_Re, vX1_Im_2nd

  vfnmsac.vv  vU1_Re_2nd, vTw1_Im, vX1_Im_2nd

    slli      tmp2, iter_start_i, 3
    add       tmp2, pTwi1_iter, tmp2
    li        tmp1, 0x80
    add       tmp2, tmp2, tmp1
  vlseg2e32.v  vTw3_Re, (tmp2)

  vfmacc.vv   vU1_Im_2nd, vTw1_Im, vX1_Re_2nd

  /* u3 = tw3 * x3 */
  /* vU3_Re <= ( vTwi3_Re * vX3_Re - vTwi3_Im * vX3_Im ) */
  /* vU3_Im <= ( vTwi3_Re * vX3_Im + vTwi3_Im * vX3_Re ) */

  vfmul.vv    vU3_Re, vTw3_Re, vX3_Re
  vfmul.vv    vU3_Im, vTw3_Re, vX3_Im

  /* u3 = tw3 * x3 */
  /* vU3_Re_2nd <= ( vTwi3_Re * vX3_Re_2nd - vTwi3_Im * vX3_Im_2nd ) */
  /* vU3_Im_2nd <= ( vTwi3_Re * vX3_Im_2nd + vTwi3_Im * vX3_Re_2nd ) */
  vfmul.vv    vU3_Re_2nd, vTw3_Re, vX3_Re_2nd
  vfmul.vv    vU3_Im_2nd, vTw3_Re, vX3_Im_2nd

  vfnmsac.vv  vU3_Re, vTw3_Im, vX3_Im
  vfmacc.vv   vU3_Im, vTw3_Im, vX3_Re

  vfnmsac.vv  vU3_Re_2nd, vTw3_Im, vX3_Im_2nd
  vfmacc.vv   vU3_Im_2nd, vTw3_Im, vX3_Re_2nd

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re, vU1_Re, vU3_Re
  vfadd.vv    vV2_Im, vU1_Im, vU3_Im





  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re, vU1_Re, vU3_Re
  vfsub.vv    vV3_Im, vU1_Im, vU3_Im

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re, vV0_Re, vV2_Re
  vfadd.vv    vY0_Im, vV0_Im, vV2_Im

    slli      tmp0, j, 0x8
    add       tmp0, pOut0_iter, tmp0
  vsseg2e32.v  vY0_Re, (tmp0)

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re, vV0_Re, vV2_Re
  vfsub.vv    vY2_Im, vV0_Im, vV2_Im

  /* v2 = u1 + u3 */
  vfadd.vv    vV2_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfadd.vv    vV2_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

  /* v3 = u1 - u3 */
  vfsub.vv    vV3_Re_2nd, vU1_Re_2nd, vU3_Re_2nd
  vfsub.vv    vV3_Im_2nd, vU1_Im_2nd, vU3_Im_2nd

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY2_Re, (tmp0)  /* tmp0 is pOut2_iter */

  /* y0 = v0 + v2 */
  vfadd.vv    vY0_Re_3rd, vV0_Re_2nd, vV2_Re_2nd
  vfadd.vv    vY0_Im_3rd, vV0_Im_2nd, vV2_Im_2nd

    addi      j, j, 1

    slli      tmp4, j, 0x8
    add       tmp4, pOut0_iter, tmp4
  vsseg2e32.v  vY0_Re_3rd, (tmp4)

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re, vV1_Re, vV3_Im
  vfsub.vv    vY1_Im, vV1_Im, vV3_Re

  /* y2 = v0 - v2 */
  vfsub.vv    vY2_Re_2nd, vV0_Re_2nd, vV2_Re_2nd
  vfsub.vv    vY2_Im_2nd, vV0_Im_2nd, vV2_Im_2nd

  /* y3 = v1 + I * v3 */
  vfsub.vv    vY3_Re, vV1_Re, vV3_Im
  vfadd.vv    vY3_Im, vV1_Im, vV3_Re

    li        tmp2, -64
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY1_Re, (tmp0)  /* tmp0 is pOut1_iter */

  /* y1 = v1 - I * v3 */
  vfadd.vv    vY1_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfsub.vv    vY1_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

  vfsub.vv    vY3_Re_2nd, vV1_Re_2nd, vV3_Im_2nd
  vfadd.vv    vY3_Im_2nd, vV1_Im_2nd, vV3_Re_2nd

    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY2_Re_2nd, (tmp4)  /* tmp4 is pOut2_iter */

    li        tmp2, 128
    add       tmp0, tmp0, tmp2
  vsseg2e32.v  vY3_Re, (tmp0)  /* tmp0 is pOut3_iter */

    li        tmp2, -64
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY1_Re_2nd, (tmp4)  /* tmp4 is pOut1_iter */

  /* y3 = v1 + I * v3 */
    li        tmp2, 128
    add       tmp4, tmp4, tmp2
  vsseg2e32.v  vY3_Re_2nd, (tmp4)  /* tmp4 is pOut3_iter */



exit_l2:

#undef pOut
#undef pIn

#undef pTwi
#undef tmp0
#undef tmp1
#undef tmp2
#undef j
#undef tmp3

#undef avl
#undef vl
#undef pIn0_iter
#undef pOut0_iter
#undef pTwi1_iter
#undef iter_start_i
#undef tmp4

#undef vX0_Re
#undef vX0_Im
#undef vX1_Re
#undef vX1_Im
#undef vX2_Re
#undef vX2_Im
#undef vX3_Re
#undef vX3_Im

#undef vU0_Re
#undef vU0_Im
#undef vU1_Re
#undef vU1_Im
#undef vU2_Re
#undef vU2_Im
#undef vU3_Re
#undef vU3_Im

#undef vV0_Re
#undef vV0_Im
#undef vV1_Re
#undef vV1_Im
#undef vV2_Re
#undef vV2_Im
#undef vV3_Re
#undef vV3_Im

#undef vY0_Re
#undef vY0_Im
#undef vY1_Re
#undef vY1_Im
#undef vY2_Re
#undef vY2_Im
#undef vY3_Re
#undef vY3_Im

#undef vTw1_Re
#undef vTw1_Im
#undef vTw2_Re
#undef vTw2_Im
#undef vTw3_Re
#undef vTw3_Im

#undef vColor0_Re
#undef vColor0_Im
#undef vColor1_Re
#undef vColor1_Im
#undef vColor2_Re
#undef vColor2_Im
#undef vColor3_Re
#undef vColor3_Im
#undef vColor4_Re
#undef vColor4_Im

#undef vColor5_Re
#undef vColor5_Im
#undef vColor6_Re
#undef vColor6_Im
#undef vColor7_Re
#undef vColor7_Im

#undef vColor0_Re_2nd
#undef vColor0_Im_2nd
#undef vColor1_Re_2nd
#undef vColor1_Im_2nd
#undef vColor2_Re_2nd
#undef vColor2_Im_2nd
#undef vColor3_Re_2nd
#undef vColor3_Im_2nd
#undef vColor4_Re_2nd
#undef vColor4_Im_2nd
#undef vTw1_Re_2nd
#undef vTw1_Im_2nd
#undef vTw2_Re_2nd
#undef vTw2_Im_2nd
#undef vTw3_Re_2nd
#undef vTw3_Im_2nd

#undef vX0_Re_2nd
#undef vX0_Im_2nd
#undef vX1_Re_2nd
#undef vX1_Im_2nd
#undef vX2_Re_2nd
#undef vX2_Im_2nd
#undef vX3_Re_2nd
#undef vX3_Im_2nd
#undef vU0_Re_2nd
#undef vU0_Im_2nd
#undef vU1_Re_2nd
#undef vU1_Im_2nd
#undef vU2_Re_2nd
#undef vU2_Im_2nd
#undef vU3_Re_2nd
#undef vU3_Im_2nd
#undef vV0_Re_2nd
#undef vV0_Im_2nd
#undef vV1_Re_2nd
#undef vV1_Im_2nd
#undef vV2_Re_2nd
#undef vV2_Im_2nd
#undef vV3_Re_2nd
#undef vV3_Im_2nd
#undef vY0_Re_2nd
#undef vY0_Im_2nd
#undef vY1_Re_2nd
#undef vY1_Im_2nd
#undef vY2_Re_2nd
#undef vY2_Im_2nd
#undef vY3_Re_2nd
#undef vY3_Im_2nd

#undef vY0_Re_3rd
#undef vY0_Im_3rd
#undef vY3_Re_3rd
#undef vY3_Im_3rd
/*
 * C reference code for stage-radix2-ivec-last.S:
 *
 * for (uint32_t i = 0u; i < 1u << (l - 1u); ++i)
 * {
 *   {
 *     float complex u0 =          x[(i << 1u)     ];
 *     float complex u1 = twi[i] * x[(i << 1u) + 1u];
 *     y[i                   ] = u0 + u1;
 *     y[i + (1u << (L - 1u))] = u0 - u1;
 *   }
 * }
 *
 * C reference code for stage-radix2-transposed-ivec-last.S:
 *
 * for (uint32_t i = 0u; i < 1u << (l - 1u); ++i)
 * {
 *   {
 *     float complex u0 =          x[                 + i];
 *     float complex u1 = twi[i] * x[(1u << (L - 1u)) + i];
 *     y[                 + i] = u0 + u1;
 *     y[(1u << (l - 1u)) + i] = u0 - u1;
 *   }
 * }
 *
 * template parameter: stage-radix2-ivec-last, stage_idx: 3, load_trans: transposed, store_trans: transposed, long_weight_vector: True
 */


#define pOut a1
#define pIn  a0


#define pTwi  a2

#define avl  a5
#define vl   a6

#define tmp0  t0
#define tmp1 t1
#define tmp2 t2
#define pOut0_iter t3
#define pIn0_iter t4
#define pTwi_iter t5

#define vColor0_Re v0
#define vColor0_Im v4
#define vColor1_Re v8
#define vColor1_Im v12
#define vColor2_Re v16
#define vColor2_Im v20

#define vX0_Re vColor0_Re
#define vX0_Im vColor0_Im
#define vX1_Re vColor1_Re
#define vX1_Im vColor1_Im
#define vU0_Re vColor0_Re
#define vU0_Im vColor0_Im
#define vU1_Re vColor2_Re
#define vU1_Im vColor2_Im
#define vY0_Re vColor1_Re
#define vY0_Im vColor1_Im
#define vY1_Re vColor1_Re
#define vY1_Im vColor1_Im

#define vTwi_Re v24
#define vTwi_Im v28

#define one_by_N    fa0

# stage_idx == total_stage_num

enter_l3:

    mv        pOut0_iter, pOut
    mv        pIn0_iter, pIn
    li        tmp0, 248  #lwv
    add       pTwi_iter, pTwi, tmp0
    li        avl, 0x20

loop_i_load_transposed_store_transposed_ivec_last_l3:
  vsetvli     vl, avl, e32, m4, tu,mu

  vlseg2e32.v   vTwi_Re, (pTwi_iter)
  vlseg2e32.v   vU0_Re, (pIn0_iter)
    addi      tmp2, pIn0_iter, 0x100
  vlseg2e32.v   vX1_Re, (tmp2)

  /* u0 unchanged */

  /* u1 = twi * x1 */
  /* vU1_Re <= vTwi_Re * vX1_Re - vTwi_Im * vX1_Im */
  /* vU1_Im <= vTwi_Re * vX1_Im + vTwi_Im * vX1_Re */
  vfmul.vv    vU1_Re, vTwi_Re, vX1_Re
  vfmul.vv    vU1_Im, vTwi_Re, vX1_Im
  vfnmsac.vv  vU1_Re, vTwi_Im, vX1_Im
  vfmacc.vv   vU1_Im, vTwi_Im, vX1_Re
#define vY0_Re_write vY0_Re
#define vY0_Im_write vY0_Im
#define vY1_Re_write vY1_Re
#define vY1_Im_write vY1_Im

  /* y0 = u0 + u1 */
  /* vY0_Re <= vU0_Re + vU1_Re */
  /* vY0_Im <= vU0_Im + vU1_Im */
  vfadd.vv    vY0_Re_write, vU0_Re, vU1_Re
  vfadd.vv    vY0_Im_write, vU0_Im, vU1_Im
  vsseg2e32.v vY0_Re, (pOut0_iter)

  /* y1 = u0 - u1 */
  /* vY1_Re <= vU0_Re - vU1_Re */
  /* vY1_Im <= vU0_Im - vU1_Im */
  vfsub.vv    vY1_Re_write, vU0_Re, vU1_Re
  vfsub.vv    vY1_Im_write, vU0_Im, vU1_Im
    addi      tmp2, pOut0_iter, 0x100
  vsseg2e32.v vY1_Re, (tmp2)  /* tmp2 is pOut1_iter */


    slli      tmp1, vl, 3  /* 4 bytes/element, 2 elements/segment */
    add       pTwi_iter, pTwi_iter, tmp1 /* bump pTwi */
    add       pIn0_iter, pIn0_iter, tmp1
    add       pOut0_iter, pOut0_iter, tmp1

    sub       avl, avl, vl
    bnez      avl, loop_i_load_transposed_store_transposed_ivec_last_l3


exit_l3:

#undef pOut
#undef pIn
#undef pTwi

#undef avl
#undef vl

#undef tmp0
#undef tmp1
#undef tmp2
#undef pOut0_iter
#undef pIn0_iter
#undef pTwi_iter

#undef one_by_N

#undef vY0_Re_write
#undef vY0_Im_write
#undef vY1_Re_write
#undef vY1_Im_write

#undef vX0_Re
#undef vX0_Im
#undef vX1_Re
#undef vX1_Im
#undef vU0_Re
#undef vU0_Im
#undef vU1_Re
#undef vU1_Im
#undef vY0_Re
#undef vY0_Im
#undef vY1_Re
#undef vY1_Im
#undef vTwi_Re
#undef vTwi_Im

#undef vColor0_Re
#undef vColor0_Im
#undef vColor1_Re
#undef vColor1_Im
#undef vColor2_Re
#undef vColor2_Im
   ret
.size  cfft_64, .-cfft_64
