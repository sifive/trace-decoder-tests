/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>

char tb[8*1024];

int main() {
	printf("buffer at %08x, size %d\n",tb,sizeof tb);

    printf("Hello, World!\n");
}
