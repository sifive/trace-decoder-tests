/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>

#include "itc_utils.h"
#include "sifive_trace.h"

int fib(int a)
{
    if (a == 0) {
    	return 0;
    }

    if (a == 1) {
    	return 1;
    }

    return fib(a-2) + fib(a-1);
}

int main() {
    itc_printf("Hello, World!\n");
    printf("beans stinkwater rocks!\n");

    int f;

    for (int i = 0; i < 10; i++) {
    	f = fib(10);
    }

    traceOn();

    f = fib(10);
    printf("fib(10)=%d\n",f);
}
