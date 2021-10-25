
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

TESTNAME := $(patsubst %.rtd,%,$(wildcard *.rtd))

RESULTNAME := $(lastword $(subst /, ,$(shell pwd)))

.PHONY: test clean result update

test: $(TESTNAME).pass

clean:
	rm -f result.log $(TESTNAME).pass $(TESTNAME).fail
	rm -f $(TESTNAME).stdout $(TESTNAME).stderr $(TESTNAME).events
	rm -rf events
	rm -f reference/$(TESTNAME).$(PLATFORM).stdout reference/$(TESTNAME).$(PLATFORM).stderr
	rm -f reference/$(TESTNAME).events
	rm -f reference/$(TESTNAME).callret reference/$(TESTNAME).control reference/$(TESTNAME).periodic

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
	cp events/$(TESTNAME).callret reference/$(TESTNAME).callret
	cp events/$(TESTNAME).control reference/$(TESTNAME).control
	cp events/$(TESTNAME).periodic reference/$(TESTNAME).periodic
	cp $(TESTNAME).events reference/$(TESTNAME).events
	cd reference; zip -u $(TESTNAME).stdout.zip $(TESTNAME).$(PLATFORM).stdout
	cd reference; zip -u $(TESTNAME).stderr.zip $(TESTNAME).$(PLATFORM).stderr
	cd reference; zip -u $(TESTNAME).events.zip $(TESTNAME).callret
	cd reference; zip -u $(TESTNAME).events.zip $(TESTNAME).control
	cd reference; zip -u $(TESTNAME).events.zip $(TESTNAME).periodic
	cd reference; zip -u $(TESTNAME).events.zip $(TESTNAME).events

reference/$(TESTNAME).$(PLATFORM).stdout: reference/$(TESTNAME).stdout.zip
	cd reference; unzip -o $(TESTNAME).stdout.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).$(PLATFORM).stderr: reference/$(TESTNAME).stderr.zip
	cd reference; unzip -o $(TESTNAME).stderr.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).callret: reference/$(TESTNAME).events.zip
	cd reference; unzip -o $(TESTNAME).events.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).control: reference/$(TESTNAME).events.zip
	cd reference; unzip -o $(TESTNAME).events.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).periodic: reference/$(TESTNAME).events.zip
	cd reference; unzip -o $(TESTNAME).events.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).events: reference/$(TESTNAME).events.zip
	cd reference; unzip -o $(TESTNAME).events.zip $(notdir $@); touch $(notdir $@)

$(TESTNAME).pass: reference/$(TESTNAME).$(PLATFORM).stdout reference/$(TESTNAME).$(PLATFORM).stderr reference/$(TESTNAME).callret reference/$(TESTNAME).control reference/$(TESTNAME).periodic reference/$(TESTNAME).events
	rm -f $(TESTNAME).pass $(TESTNAME).fail
	$(DQREXE) -pf settings -trace -src -branches -callreturn -analytics=2 > $(TESTNAME).stdout 2> $(TESTNAME).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stdout reference/$(TESTNAME).$(PLATFORM).stdout \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stderr reference/$(TESTNAME).$(PLATFORM).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr events/$(TESTNAME).callret reference/$(TESTNAME).callret \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr events/$(TESTNAME).control reference/$(TESTNAME).control \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr events/$(TESTNAME).periodic reference/$(TESTNAME).periodic \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).events reference/$(TESTNAME).events \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	touch $(TESTNAME).pass
	@echo PASS: $(RESULTNAME)
