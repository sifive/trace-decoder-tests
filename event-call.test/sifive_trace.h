/* Copyright 2020 SiFive, Inc */

#ifndef SIFIVE_TRACE_H_
#define SIFIVE_TRACE_H_

#define traceBaseAddress       (0x10000000)
#define te_control_offset      (0x00)
#define te_impl_offset         (0x04)
#define te_sinkbase_offset     (0x10)
#define te_sinkbasehigh_offset (0x14)
#define te_sinklimit_offset    (0x18)
#define te_sink_wp_offset      (0x1c)
#define te_sink_rp_offset      (0x20)
#define te_fifo_offset         (0x30)
#define te_btmcount_offset     (0x34)
#define te_wordcount_offset    (0x38)
#define ts_control_offset      (0x40)
#define ts_lower_offset        (0x44)
#define ts_upper_offset        (0x48)
#define xti_control_offset     (0x50)
#define xto_control_offset     (0x54)
#define wp_control_offset      (0x58)
#define itc_traceenable_offset (0x60)
#define itc_trigenable_offset  (0x64)

#define	caBaseAddress       (0x1000f000)
#define ca_control_offset   (0x00)
#define ca_impl_offset      (0x04)
#define ca_sink_wp_offset   (0x1c)
#define ca_sink_rp_offset   (0x20)
#define ca_sink_data_offset (0x24)

#define TEINSTRUCTION_NONE    0
#define TEINSTRUCTION_BTMSYNC 3
#define TEINSTRUCTION_HTM     6
#define TEINSTRUCTION_HTMSYNC 7

#define TEINSTRUMENTATION_NONE         0
#define TEINSTRUMENTATION_ITC          1
#define TEINSTRUMENTATION_OWNERSHIP    2
#define TEINSTRUMENTATION_OWNERSHIPALL 3

#define TESTALLENABLE_OFF 0
#define TESTALLENABLE_ON  1

#define TESTOPONWRAP_OFF 0
#define TESTOPONWRAP_ON  1

#define TEINHIBITSRC_OFF 0
#define TEINHIBITSRC_ON  1

#define TESYNCMAXBTM_32    0
#define TESYNCMAXBTM_64    1
#define TESYNCMAXBTM_128   2
#define TESYNCMAXBTM_256   3
#define TESYNCMAXBTM_512   4
#define TESYNCMAXBTM_1024  5
#define TESYNCMAXBTM_2048  6
#define TESYNCMAXBTM_4096  7
#define TESYNCMAXBTM_8192  8
#define TESYNCMAXBTM_16348 9
#define TESYNCMAXBTM_32768 10
#define TESYNCMAXBTM_65536 11

#define TESYNCMAXINST_32   0
#define TESYNCMAXINST_64   1
#define TESYNCMAXINST_128  2
#define TESYNCMAXINST_256  3
#define TESYNCMAXINST_512  4
#define TESYNCMAXINST_1024 5

#define TESINK_DEFAULT 0
#define TESINK_SRAM    4
#define TESINK_ATB     5
#define TESINK_PIB     6
#define TESINK_SBA     7
#define TESINK_FUNNEL  8

#define CASTOPONWRAP_OFF 0
#define CASTOPONWRAP_ON  1

#define _mww(addr,data) (*(volatile unsigned int*)(addr)=(data))
#define _mrw(addr) (*(volatile unsigned int*)(addr))

#define traceOn() { \
     uint32_t t; \
     t = _mrw(traceBaseAddress+te_control_offset); \
     t |= 0x00000003; \
     _mww(traceBaseAddress+te_control_offset,t); \
     t = _mrw(traceBaseAddress+te_control_offset); \
     t |= 0x00000005; \
     _mww(traceBaseAddress+te_control_offset,t); \
}

#define _caTraceOnHTMDefaults() {                          \
     _mww(traceBaseAddress+te_control_offset, 0x00000000); \
     _mww(caBaseAddress+ca_control_offset, 0x00000000);    \
     _mww(traceBaseAddress+te_control_offset, 0x00000001); \
     _mww(traceBaseAddress+te_sink_wp_offset, 0x00000000); \
     _mww(traceBaseAddress+te_sink_rp_offset, 0x00000000); \
     _mww(traceBaseAddress+xti_control_offset,0x04);       \
     _mww(traceBaseAddress+xto_control_offset,0x21);       \
     _mww(caBaseAddress+ca_control_offset,0x00000001);     \
     _mww(caBaseAddress+ca_sink_wp_offset,0x00000000);     \
     _mww(caBaseAddress+ca_sink_rp_offset,0x00000000);     \
     _mww(caBaseAddress+ca_control_offset,0x40004003);     \
     _mww(traceBaseAddress+te_control_offset,0x4153c077);  \
	}

#define _caTraceOnBTMDefaults() {                          \
     _mww(traceBaseAddress+te_control_offset, 0x00000000); \
     _mww(caBaseAddress+ca_control_offset, 0x00000000);    \
     _mww(traceBaseAddress+te_control_offset, 0x00000001); \
     _mww(traceBaseAddress+te_sink_wp_offset, 0x00000000); \
     _mww(traceBaseAddress+te_sink_rp_offset, 0x00000000); \
     _mww(traceBaseAddress+xti_control_offset,0x04);       \
     _mww(traceBaseAddress+xto_control_offset,0x21);       \
     _mww(caBaseAddress+ca_control_offset,0x00000001);     \
     _mww(caBaseAddress+ca_sink_wp_offset,0x00000000);     \
     _mww(caBaseAddress+ca_sink_rp_offset,0x00000000);     \
     _mww(caBaseAddress+ca_control_offset,0x40004003);     \
     _mww(traceBaseAddress+te_control_offset,0x4153c037);  \
	}

#define _caTraceOnDefaults() {                             \
     _mww(traceBaseAddress+te_control_offset, 0x00000000); \
     _mww(traceBaseAddress+te_control_offset, 0x00000001); \
     _mww(traceBaseAddress+te_control_offset, 0x00000077); \
     unsigned int t;                                       \
     t = _mrw(traceBaseAddress+te_control_offset);         \
     if (((t & (0xf<<4))>>4) == 0x7) {                     \
      _caTraceOnHTMDefaults();                             \
      _mww(traceBaseAddress+te_control_offset,0x4153c037); \
     }                                                     \
     else {                                                \
      _caTraceOnBTMDefaults();                             \
     }                                                     \
     t = _mrw(traceBaseAddress+te_control_offset);         \
	}

#define _caTraceOn(teInstruction,teInstrumentation,teStallEnable,teStopOnWrap,teInhibitSrc,teSyncMaxBTM,teSyncMaxInst,teSink,caStopOnWrap) { \
     _mww(traceBaseAddress+te_control_offset, 0x00000000);                   \
     _mww(caBaseAddress+ca_control_offset, 0x00000000);                      \
     _mww(traceBaseAddress+te_control_offset, 0x00000001);                   \
     _mww(traceBaseAddress+te_sink_wp_offset, 0x00000000);                   \
     _mww(traceBaseAddress+te_sink_rp_offset, 0x00000000);                   \
     _mww(traceBaseAddress+xti_control_offset,0x04);                         \
     _mww(traceBaseAddress+xto_control_offset,0x21);                         \
     _mww(caBaseAddress+ca_control_offset,0x00000001);                       \
     _mww(caBaseAddress+ca_sink_wp_offset,0x00000000);                       \
     _mww(caBaseAddress+ca_sink_rp_offset,0x00000000);                       \
     _mww(caBaseAddress+ca_control_offset,(4<<28)|((caStopOnWrap)<<14)|(3)); \
     _mww(traceBaseAddress+te_control_offset,((teSink)<<28)|((teSyncMaxInst)<<20)|((teSyncMaxBTM)<<16)|((teInhibitSrc)<<15)|((teStopOnWrap)<<14)|((teStallEnable)<<13)|((teInstrumentation)<<7)|((teInstruction)<<4)|7); \
	}

#define _caTraceOff() {                                                    \
	 unsigned int t;                                                       \
     t = _mrw(traceBaseAddress+te_control_offset);                         \
     _mww(traceBaseAddress+te_control_offset,t & ~(1<<1));                 \
     t = _mrw(caBaseAddress+ca_control_offset);                            \
     _mww(caBaseAddress+ca_control_offset,t & ~(1<<1));                    \
     while ((_mrw(traceBaseAddress+te_control_offset) & (1<<3)) == 0) {}   \
     while ((_mrw(caBaseAddress+ca_control_offset) & (1<<3)) == 0) {}      \
	}

#endif // SIFIVE_TRACE_H_
