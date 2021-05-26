/*
 * raster.c
 *
 *  Created on: Sep 10, 2020
 *      Author: kevin
 */
#include <math.h>
#include "mandel.h"

int iX, iY;

double Cx, Cy;

const double CxMin = -2.5;
const double CxMax = 1.5;
const double CyMin = -2.0;
const double CyMax = 2.0;

double PixelWidth = (CxMax - CxMin) / XRES;
double PixelHeight = (CyMax - CyMin) / YRES;

double Zx, Zy;
double Zx2, Zy2;

extern void iterate_px();

void setup_px() {
	Cx = CxMin + iX * PixelWidth;
	Zx = 0.0;
	Zy = 0.0;
	Zx2 = Zx * Zx;
	Zy2 = Zy * Zy;
}

int rasterize(char display[][YRES]) {
	for (iY = 0; iY < YRES; iY++) {
		Cy = CyMin + iY * PixelHeight;

		if (fabs(Cy) < PixelHeight / 2)
			Cy = 0.0;

		for (iX = 0; iX < XRES; iX++) {
			setup_px();
			iterate_px(display, iX, iY);
		}
	}
	return 0;
}

