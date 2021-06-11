/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>

#include "itc_utils.h"


#ident "1:Foo Bar"
#ident "2:uint 8: %u %u %u %u, and %%"
#ident "3:int 8: %d %d %d %d"
#ident "4:hex 8: 0x%02x 0x%02x 0x%02x 0x%02x"
#ident "5:oct 8: %o %o %o %o"
#ident "6:char 8: %c %c %c %c"

#ident "7:uint 11: %u %d %u"
#ident "8:int 11: %d %d %d"
#ident "9:hex 11: %03x %03x %03x"
#ident "10:oct 11: %o %o %o"

#ident "11:uint 16: %u %u"
#ident "12:int 16: %d %d"
#ident "13:hex 16: 0x%04x 0x%04x"

#ident "14:uint 32: %u"
#ident "15:int 32: %d"

int main() {
	printf("test start\n");

    itc_printf("Hello, World! %d\n",-42);

    itc_nls_printstr(1);

    itc_nls_print_i8(2,1,2,3,4);
    itc_nls_print_i8(3,-1, 2, -3, 4);
    itc_nls_print_i8(4,0xff,2,0xff,4);
    itc_nls_print_i8(5,21,42,63,84);
    itc_nls_print_i8(6,'a','b','c','d');

    itc_nls_print_i11(7,0x7ff,0xfff,42);
    itc_nls_print_i11(8,1,-2,-3);
    itc_nls_print_i11(9,0xfff,0xfff,0xfff);
    itc_nls_print_i11(10,123,456,42);

    itc_nls_print_i16(11,-1,65535);
    itc_nls_print_i16(12,-42,1234);
    itc_nls_print_i16(13,0x1234,0x5678);

    itc_nls_print_i32(14,0xffffffff);
    itc_nls_print_i32(15,-42);

    // check the alt-channel feature

    itc_nls_print_i32(ITC_TS_CHANNEL_OFFSET+15,12345678);

    itc_printf("goodbye world! %d\n",42);

    printf("test end\n");
}
