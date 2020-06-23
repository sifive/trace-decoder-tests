
ifeq ($(DQRPATH),)
    DQRTP := $(realpath .)
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
else
    ifeq ($(DQREXE),)
        DQREXE := $(BINPATH)/dqr
    endif

    ifeq ($(DQRLIB),)
        DQRLIB := $(LIBPATH)/dqr.so
    endif
endif

ifeq ($(REPORTPATH),)
    REPORTPATH := .
endif

ifeq ($(LS),)
    LS := ls -l
endif

TESTNAME := help

REPORTNAME := $(lastword $(subst /, ,$(shell pwd)))

.PHONY: test clean report

test: $(TESTNAME).pass

clean:
	rm -f report.txt $(TESTNAME).pass $(TESTNAME).fail

report:
	if [ -e $(TESTNAME).pass ]; then \
		echo PASS: $(REPORTNAME) `date -r $(TESTNAME).pass` >> $(REPORTPATH)/report.txt; \
	else if [ -e $(TESTNAME).fail ]; then \
			echo FAIL: $(REPORTNAME) `date -r $(TESTNAME).fail` >> $(REPORTPATH)/report.txt; \
		else \
			echo NOT RUN: $(REPORTNAME) >> $(REPORTPATH)/report.txt; \
		fi \
	fi

reference/$(TESTNAME).stdout: reference/$(TESTNAME).stdout.zip
	cd reference; unzip -o $(TESTNAME).stdout.zip; touch $(TESTNAME).stdout

reference/$(TESTNAME).stderr: reference/$(TESTNAME).stderr.zip
	cd reference; unzip -o $(TESTNAME).stderr.zip; touch $(TESTNAME).stderr

$(TESTNAME).pass: reference/$(TESTNAME).stdout reference/$(TESTNAME).stderr
	rm -f $(TESTNAME).pass $(TESTNAME).fail
	$(DQREXE) -h > $(TESTNAME).stdout 2> $(TESTNAME).stderr \
		|| (echo FAIL: $(REPORTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr reference/$(TESTNAME).stdout $(TESTNAME).stdout \
		|| (echo FAIL: $(REPORTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr reference/$(TESTNAME).stderr $(TESTNAME).stderr \
		|| (echo FAIL: $(REPORTNAME); touch $(TESTNAME).fail; false)
	touch $(TESTNAME).pass
	@echo PASS: $(REPORTNAME)
