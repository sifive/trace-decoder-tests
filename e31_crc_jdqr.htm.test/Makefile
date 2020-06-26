
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
        DQRLIB := $(LIBPATH)/libdqr.so
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

.PHONY: test clean result

test: $(TESTNAME).pass

clean:
	rm -f result.log $(TESTNAME).pass $(TESTNAME).fail
	rm -f $(TESTNAME).stdout $(TESTNAME).stderr
	rm -f jdqr.java jdqr.class *.jar
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

ifeq ($(PLATFORM),windows)
    CLASSPATH := ".;TraceDecoder.jar"
else
    CLASSPATH := .:TraceDecoder.jar
endif

reference/$(TESTNAME).$(PLATFORM).stdout: reference/$(TESTNAME).stdout.zip
	cd reference; unzip -o $(TESTNAME).stdout.zip $(notdir $@); touch $(notdir $@)

reference/$(TESTNAME).$(PLATFORM).stderr: reference/$(TESTNAME).stderr.zip
	cd reference; unzip -o $(TESTNAME).stderr.zip $(notdir $@); touch $(notdir $@)

jdqr.class:
	cp $(realpath $(JAVAPATH)/jdqr.java) . || (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false);
	cp $(wildcard $(LIBPATH)/*) . || (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false);
	javac jdqr.java -cp TraceDecoder.jar || (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false);

$(TESTNAME).pass: reference/$(TESTNAME).$(PLATFORM).stdout reference/$(TESTNAME).$(PLATFORM).stderr jdqr.class
	rm -f $(TESTNAME).pass $(TESTNAME).fail
	java -Djava.library.path=`pwd` --class-path $(CLASSPATH) jdqr $(TESTNAME).rtd $(TESTNAME).elf > $(TESTNAME).stdout 2> $(TESTNAME).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stdout reference/$(TESTNAME).$(PLATFORM).stdout \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	diff -q --strip-trailing-cr $(TESTNAME).stderr reference/$(TESTNAME).$(PLATFORM).stderr \
		|| (echo FAIL: $(RESULTNAME); touch $(TESTNAME).fail; false)
	touch $(TESTNAME).pass
	@echo PASS: $(RESULTNAME)
