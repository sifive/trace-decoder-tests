
CUTPATH := "\home\kevinm\fs-runtime-clear\cxops_1008_samsung_networks_mongoose_post_pr_systemc_v1p0_example_fft_64"
NEWROOT := .

ifeq ($(DQRPATH),)
    DQR := $(shell which dqr)
    DQRTP := $(realpath $(dir $(DQR))..)
else
    DQRTP := $(realpath $(DQRPATH))
endif

BINPATH := $(DQRTP)/bin
LIBPATH := $(DQRTP)/lib
JAVAPATH := $(DQRTP)/examples/java

ifeq ($(OS),Windows_NT)
    ifeq ($(DQREXE),)
        DQREXE := $(BINPATH)/dqr.exe
    endif

    ifeq ($(DQRLIB),)
        DQRLIB := $(LIBPATH)/dqr.dll
    endif

    PLATFORM := windows
else
    ifeq ($(DQREXE),)
        DQREXE := $(BINPATH)/dqr
    endif

    ifeq ($(DQRLIB),)
        DQRLIB := $(LIBPATH)/dqr.so
    endif

    PLATFORM := unix
endif

ifeq ($(RESULTPATH),)
    RSLTPATH := $(realpath .)
else
    RSLTPATH := $(realpath $(RESULTPATH))
endif

ifeq ($(LS),)
    LS := ls -l
endif

TESTNAME := $(patsubst %.sim,%,$(wildcard *.sim))

RESULTNAME := $(lastword $(subst /, ,$(shell pwd)))

.PHONY: test clean result update

test: $(TESTNAME).pass

clean:
	rm -f result.log $(TESTNAME).pass $(TESTNAME).fail
	rm -f $(TESTNAME).stdout $(TESTNAME).stderr
	rm -f reference/$(TESTNAME).$(PLATFORM).stdout reference/$(TESTNAME).$(PLATFORM).stderr

result:
	if [ -e $(TESTNAME).pass ]; then \
		echo PASS: $(RESULTNAME) `date -r $(TESTNAME).pass` >> $(RSLTPATH)/result.log; \
	else if [ -e $(TESTNAME).fail ]; then \
			echo FAIL: $(RESULTNAME) `date -r $(TESTNAME).fail` >> $(RSLTPATH)/result.log; \
		else \
			echo NOT RUN: $(RESULTNAME) >> $(RSLTPATH)/result.log; \
		fi \
	fi

update:
	cp $(TESTNAME).stdout reference/$(TESTNAME).$(PLATFORM).stdout
	cp $(TESTNAME).stderr reference/$(TESTNAME).$(PLATFORM).stderr
	cd reference; zip -u $(TESTNAME).stdout.zip $(TESTNAME).$(PLATFORM).stdout
	cd reference; zip -u $(TESTNAME).stderr.zip $(TESTNAME).$(PLATFORM).stderr

reference/$(TESTNAME).$(PLATFORM).stdout: reference/$(TESTNAME).stdout.zip
	cd reference; unzip -o $(TESTNAME).stdout.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).$(PLATFORM).stderr: reference/$(TESTNAME).stderr.zip
	cd reference; unzip -o $(TESTNAME).stderr.zip $(notdir $@); touch $(notdir $@)

$(TESTNAME).pass: reference/$(TESTNAME).$(PLATFORM).stdout reference/$(TESTNAME).$(PLATFORM).stderr
	rm -f $(TESTNAME).pass $(TESTNAME).fail
	$(DQREXE) -s $(TESTNAME).sim -e $(TESTNAME).elf -trace -src -branches -callreturn -cutpath=$(CUTPATH),$(NEWROOT) -analytics=2 > $(TESTNAME).stdout 2> $(TESTNAME).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stdout reference/$(TESTNAME).$(PLATFORM).stdout \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stderr reference/$(TESTNAME).$(PLATFORM).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	touch $(TESTNAME).pass
	@echo PASS: $(RESULTNAME)
