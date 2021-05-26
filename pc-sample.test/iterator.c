/*
 * iterator.c
 *
 *  Created on: Sep 10, 2020
 *      Author: kevin
 */
#include <stdio.h>
#include <math.h>
#include <metal/tty.h>
#include "mandel.h"

extern double Zx, Zy;
extern double Zx2, Zy2;
extern double Cx, Cy;

int Iteration;
const int IterationMax = 200;
const double EscapeRadius = 2;
double ER2 = EscapeRadius * EscapeRadius;

void iterate_p1() {
	Zy = 2 * Zx * Zy + Cy;
	Zx = Zx2 - Zy2 + Cx;
}

void iterate_p2() {
	Zx2 = Zx * Zx;
	Zy2 = Zy * Zy;
}

int is_inside() {
	return ((Zx2 + Zy2) < ER2);
}

void iterate_px(char display[][YRES], int iX, int iY) {
	for (Iteration = 0; Iteration < IterationMax && is_inside(); Iteration++) {
		iterate_p1();
		iterate_p2();
	};
}

