
CURRENTDIR := $(realpath .)

ifeq ($(DQRPATH),)
    DQR := $(shell which dqr)
    DQRTOOLSPATH := $(realpath $(dir $(DQR))..)
else
    DQRTOOLSPATH := $(realpath $(DQRPATH))
endif

ifeq ($(OS),Windows_NT)
    DQREXE := $(DQRTOOLSPATH)/bin/dqr.exe
    DQRLIB := $(DQRTOOLSPATH)/lib/dqr.dll
    LS := dir
else
    ifeq ($(CROSSPREFIX),x86_64-w64-mingw32-)
        #    if crossbuild, cannot test! exit with error
        $(error Cannot test crossbuild on build system)
    endif

    DQREXE := $(DQRTOOLSPATH)/bin/dqr
    DQRLIB := $(DQRTOOLSPATH)/lib/dqr.so
    LS := ls
endif

ifeq ($(OBJDUMP),)
    ifeq ($(RISCV_PATH),)
        RISCV_PATH := $(realpath .)
    endif

    OBJDUMPEXE := $(RISCV_PATH)/riscv64-unknown-elf-objdump
else
    OBJDUMPEXE := $(realpath $(OBJDUMP))
    $(info objdumpexe: $(OBJDUMPEXE))
endif

ifeq ($(RESULTPATH),)
    RSLTDIR := $(CURRENTDIR)
else
    RSLTDIR := $(realpath $(RESULTPATH))
endif

TESTDIRS = $(wildcard *.test)

.PHONY: test clean result

all: test result

test:
	if [ ! -x $(DQREXE) ]; then \
	  echo "dqr executable not found"; \
	  exit 1; \
	fi
	if [ ! -x $(OBJDUMPEXE) ]; then \
	  echo "objdump executable not found"; \
	  exit 1; \
	fi
	-for dir in $(TESTDIRS); do \
	    make -C $$dir test DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) RESULTPATH=$(RSLTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH) OBJDUMP="$(OBJDUMPEXE)"; \
	done

clean:
	rm -rf result.log
	for dir in $(TESTDIRS); do \
	    make -C $$dir clean DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) RESULTPATH=$(RSLTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH); \
	done

result:
	mkdir -p $(RSLTDIR)
	rm -rf $(RSLTDIR)/result.log
	for dir in $(TESTDIRS); do \
	    make -C $$dir result DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) RESULTPATH=$(RSLTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH); \
	done
	if grep -q FAIL $(RSLTDIR)/result.log; then exit 1; fi
