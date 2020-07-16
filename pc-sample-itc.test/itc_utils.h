/* Copyright 2020 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#ifndef ITC_UTILS_H
#define ITC_UTILS_H
#include <stdio.h>

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

#endif // ITC_UTILS_H
