
#include <math.h>
#include <riscv_vector.h>
#include <stddef.h>
#include <stdio.h>
#include <math.h>


 //need to create a set of indices for gathering pixel data from source image.
 __fp16 idxseq[512];
 __fp16 idxseq4[2048];

#define PI (float)(3.1415926535897932384626433832795)


 //This is the function we need to time
void img_rotate_get_quad_rangle_subpix_rgba_c (
		uint32_t *dst,
        uint32_t *src,
        uint16_t srcw,
        uint16_t srch,
        uint16_t dstw,
        uint16_t dsth,
		__fp16 *matrix)
{
    uint32_t* src_data = src;
    uint32_t* dst_data = dst;
    size_t vl, vl4;
    vfloat16mf2_t xindex;
//    vfloat16mf2_t 	yindex;
    vfloat16m2_t 	yindex4;


    int16_t x, y;

    __fp16 A11 = matrix[0], A12 = matrix[1], A13 = matrix[2];
    __fp16 A21 = matrix[3], A22 = matrix[4], A23 = matrix[5];

    int16_t src_step = srcw ;
    int16_t dst_step = dstw ;

//setup address offsets for 4 neighboring pixels
	uint32_t* base_q11 = src_data;
	uint32_t* base_q12 = src_data+1;
	uint32_t* base_q21 = src_data+src_step;
	uint32_t* base_q22 = src_data+src_step+1;

	vfloat16mf2_t xs;	//rotated x coordinate
	vfloat16mf2_t ys;	//rotated y coordinate
	vfloat16m2_t ys4;
    for (y = 0; y < dsth; y++)
    {
    	__fp16 xs0 = A12 * y + A13;
    	__fp16 ys0 = A22 * y + A23;

    	dst_data = dst + y * dst_step;

// not doing any out of range checking
// will process output image rows  512/32= 16 pixels per iteration
			for (x = 0; (vl=vsetvl_e32m1(dstw-x)); x+= vl)
			{
				vl4= vl * 4;	//we need to do vl pixel load/store operations but vl*4 pixel component math operations.

				xindex= vle16_v_f16mf2(idxseq+x,vl);
//				yindex= vle16_v_f16mf2(idxseq+x,vl);
				yindex4= vle16_v_f16m2(idxseq4+x,vl4);

				xs = vfmv_v_f_f16mf2 (xs0, vl);  //splat scalar to vector register
				xs = vfmacc(xs, A11, xindex, vl);
				ys = vfmv_v_f_f16mf2 (ys0, vl); //splat scalar to vector register
				ys = vfmacc(ys, A21, xindex, vl);
				ys4 = vfmv_v_f_f16m2 (ys0, vl4); //splat scalar to vector register
				ys4 = vfmacc(ys4, A21, yindex4, vl4);

				vuint16mf2_t ixs = vfcvt_xu(xs, vl);  //convert to Int16
				vuint16mf2_t iys = vfcvt_xu(ys, vl);
				vuint16m2_t iys4 = vfcvt_xu(ys4, vl4);

				//vuint16mf2_t qindex = ixs;
				vuint16mf2_t qindex = vsll_vx_u16mf2( ixs ,2,vl); //need to multiply by 4 due to byte addressing
				qindex = vmacc(qindex, src_step, iys, vl);

				//	sample 4 neighboring pixels
				// max input image size is 256x256 with 16-bit index values
				// might need to change to 32-bit for larger images
				vuint8m1_t q11 = vreinterpret_v_u32m1_u8m1(vluxei16 (base_q11, qindex, vl));
				vuint8m1_t q12 = vreinterpret_v_u32m1_u8m1(vluxei16 (base_q12, qindex, vl));
				vuint8m1_t q21 = vreinterpret_v_u32m1_u8m1(vluxei16 (base_q21, qindex, vl));
				vuint8m1_t q22 = vreinterpret_v_u32m1_u8m1(vluxei16 (base_q22, qindex, vl));

				//	calculate bilinear interpolation coefficients

				// uint8_t a = (int8_t)(255 * (xs - ixs) + 0.5f
				// need coefficients repeated 4x for the 4 pixel component

				vfloat16mf2_t t0 = vfcvt_f(ixs,vl);
				vfloat16mf2_t t1 = vfsub_vv_f16mf2(xs,t0,vl); 		//get the fractional pixel coordinate
				vfloat16mf2_t t2 = vfmul_vf_f16mf2(t1, 255.0,vl); 	//scale by 255
				vuint16mf2_t t3 = vfcvt_xu(t2,vl); 					//convert to int16
				vuint32m1_t t4 = vwmulu(t3,(uint16_t)0x0101,vl); 	//replicate coefficient 2 times
				vuint32m1_t t5 = vsll (t4,(size_t)16,vl); 			//replicate 2 more times
				vuint32m1_t t6 = vor (t5, t4, vl);
				vuint8m1_t a = vreinterpret_v_u32m1_u8m1 (t6);		//reinterpret as int8

//              uint8_t a1 = (int8_t)(255 * (1.f - (xs - ixs))+ 0.5f);
				vuint32m1_t t7 = vrsub (t6, 0xffffffff,vl);
				vuint8m1_t a1 = vreinterpret_v_u32m1_u8m1 (t7);

//              uint8_t b = (int8_t)(255 * (ys - iys) + 0.5f);

				vfloat16m2_t t8 = vfcvt_f(iys4,vl4);
				vfloat16m2_t t9 = vfsub(ys4,t8,vl4); //get the fractional pixel coordinate
				vfloat16m2_t t10 = vfmul_vf_f16m2(t9, 32767.0,vl4); //scale by 32767
				vuint16m2_t b = vfcvt_xu(t10,vl4); //convert to uint16

//                p0 =  (q11 * a1 + q12 * a);
				 vuint16m2_t p0 = vwmulu (q11, a1,vl4);
				 //vuint16m2_t vwmaccu (vuint16m2_t acc, vuint8m1_t op1, vuint8m1_t op2, size_t vl);
				 p0 = vwmaccu (p0, q12, a, vl4);
//				 vint16m2_t p0s = vreinterpret_v_u16m2_i16m2 (p0); //reinterpret as signed

//                p1 =  (q21 * a1 + q22 * a);
				 vuint16m2_t p1 = vwmulu (q21, a1,vl4);
				 p1 = vwmaccu (p1, q22, a, vl4);
//				 vint16m2_t p1s = vreinterpret_v_u16m2_i16m2 (p1); //reinterpret as signed

				 //p2 = (p0 * 32767 + b * (p1 - p0))>>15
				 vuint16m2_t p2a = vsub(p1,p0,vl4);
				 vuint32m4_t p2b = vwmulu (p2a, b, vl4);
				 vuint32m4_t p2 = vwmaccu(p2b, 32767, p0,  vl4 );
				 vuint16m2_t p3= vnclipu (p2, 16, vl4);
				 vuint32m1_t p4 = vreinterpret_v_u8m1_u32m1(vnclipu (p3, 8, vl4));

				 vse32(dst_data, p4, vl);
				 dst_data += vl;
//
            }



    }
}


#define angle 30
#define src_width 32
#define src_height 32

uint32_t src[src_height][src_width];
uint32_t dst[(int)(src_height * 1.5)][(int)(src_width * 1.5)];
int main (void)
{

	//initialize source
	uint32_t * dst_width;
	uint32_t * dst_height;
	int i,j;
	//create vertical bar test_image
	for (i=0;i<src_height;i++)
	{
		for (j=0;j<src_width;j++)
		{
			if ((j & 0xf)==0xf) src[i][j]= 0x7f7f7f7f;
			else src[i][j]= 0;
		}
	}
    float radian = (angle * PI / 180.0);
    float a = sin (radian), b = cos (radian);

    int16_t dstw = (src_height * fabs (a)) + (src_width * fabs (b)) + 1;
    int16_t dsth = (src_height * fabs (b)) + (src_width * fabs (a)) + 1;
    int16_t srcw = src_width;
	int16_t srch = src_height;
	//initialize index tables
	for (i=0;i<dstw;i++)  {
		idxseq[i]=i;
		idxseq4[i*4] =i;
		idxseq4[i*4+1] =i;
		idxseq4[i*4+2] =i;
		idxseq4[i*4+3] =i;

	}

    __fp16 m[6];
    __fp16 dx = (dstw - 1) * 0.5;
    __fp16 dy = (dsth - 1) * 0.5;

    m[0] = b; //a11
    m[1] = a; //a12
    m[3] = -m[1];
    m[4] = m[0];
    m[2] = srcw * 0.5f - m[0] * dx - m[1] * dy; //a13
    m[5] = srch * 0.5f - m[3] * dx - m[4] * dy;

	img_rotate_get_quad_rangle_subpix_rgba_c (dst, src, srcw, srch, dstw, dsth, m);

    return 0;
}
