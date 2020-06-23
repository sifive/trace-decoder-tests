# Use "make --always-make test" to run all tests
# Use "make --keep-going test" to keep running if there is a test failure
# Each test must have its own Makefile with the targets test, clean, report

# Note: make does not like '\' for directory separators; use '/'
# But if running on windows, set paths with `\` on command line args, such as
# make DQRPATH=\foo\dog

# usage: make [ DQRPATH=<path> ] [ REPORTPATH=<path> ] [clean] [test] [report]

# check if abspath should be realpath?

CURRENTDIR := $(realpath .)

ifeq ($(DQRPATH),)
    DQRTOOLSPATH := $(CURRENTDIR)
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

ifeq ($(REPORTPATH),)
    RPTDIR := $(CURRENTDIR)
else
    RPTDIR := $(realpath $(REPORTPATH))
endif

TESTDIRS = $(wildcard *.btm.test) $(wildcard *.htm.test) $(wildcard *.general.test)

.PHONY: test clean report

test:
	for dir in $(TESTDIRS); do \
		make -C $$dir test DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) REPORTPATH=$(RPTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH); \
	done

clean:
	rm -rf report.txt
	for dir in $(TESTDIRS); do \
		make -C $$dir clean DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) REPORTPATH=$(RPTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH); \
	done

report:
	mkdir -p $(RPTDIR)
	rm -rf $(RPTDIR)/report.txt
	for dir in $(TESTDIRS); do \
		make -C $$dir report DQREXE=$(DQREXE) DQRLIB=$(DQRLIB) REPORTPATH=$(RPTDIR) LS=$(LS) DQRPATH=$(DQRTOOLSPATH); \
	done
