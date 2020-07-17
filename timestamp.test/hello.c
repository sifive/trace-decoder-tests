/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include "itc_print.h"

unsigned int fib(unsigned int n)
{
    if (n == 0) {
        return 0;
    }

    if (n == 1) {
        return 1;
    }

    return (fib(n-1)+fib(n-2));
}

int main()
{
	unsigned int f;

	f = fib(15);

	itc_printf("fib #%u is %u\n",10,f);

	return 0;
}
