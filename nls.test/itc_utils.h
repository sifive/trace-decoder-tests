/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#ifndef ITC_UTILS_H
#define ITC_UTILS_H
#include <stdio.h>

#define ITC_TS_CHANNEL_OFFSET	(16)

/*
 * ITC Channel management. Generally you do not need to use these because the
 * debugger will take care of enabling and disabling channels via the trace
 * configuration dialog.  You may want to use these if you want to generate
 * ITC trace data on a target not being controlled by a debugger.
 */
int itc_enable(int channel);
int itc_disable(int channel);

/*
 * ITC Print functions.  If itc_set_print_channel() is not called
 * then channel 0 is assumed.
 */
int itc_set_print_channel(int channel);
int itc_puts(const char *f);
int itc_printf(const char *f, ... );

/*
 * General functions for writing data to an ITC channel.
 */
void itc_write_uint32(int channel, uint32_t data);
void itc_write_uint8(int channel, uint8_t data);
void itc_write_uint16(int channel, uint16_t data);

/* 
 * ITC No Load String Print Functions. Writes either no value, 1-32 bit value, 2-16 bit values, 
 * 2-11 bit and 1-10 bit values, or 4-8 bit values to the specified stimulus register to be used as arguments 
 * in a saved formattable string that will be printed in the trace file.
 * Channel should be between [1, 31]. returns 1 on success
 */
int itc_nls_printstr(int channel);
int itc_nls_print_i32(int channel, uint32_t data);
int itc_nls_print_i16(int channel, uint16_t data1, uint16_t data2);
int itc_nls_print_i11(int channel, uint16_t data1, uint16_t data2, uint16_t data3);
int itc_nls_print_i8(int channel, uint8_t data1, uint8_t data2, uint8_t data3, uint8_t data4);

#endif // ITC_UTILS_H
