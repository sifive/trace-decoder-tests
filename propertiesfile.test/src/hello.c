/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>

/*
 * ITC Trace channel format strings
 */
#ident "0: %d is prime"
#ident "1: %d is not prime"

/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <metal/init.h>

int your_global = 0;

void metal_init_run() {
    /* Run our own init instead of the metal constructors */
    your_global = 1;
}

void metal_fini_run() {
    /* Don't run the metal destructors */
}

int main() {
    /* Check to make sure our custom constructor ran */
    if (your_global != 1) {
        return 1;
    }

    /* Now run the metal constructors to initialize standard I/O */
    metal_init();

	int prime_counter = 0;
	int countdown = 5;
	int notTrue = 0;

	while (1) {
		for (int i = 2; i > 0; i++) {
			int c = 0;
			for (int j = 1; j <= i; j++) {
				if (i % j == 0) {
					c++;
				}
			}

			if (c == 2) {
				// i is a prime number
				prime_counter++;
			}
		}
	}

    /* Now run the metal destructors */
    metal_fini();

    return 0;
}
