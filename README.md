# trace-decoder-tests
Tests for SiFive trace decoder

Trace-decoder-tests is intended as a set of tests for the SiFive RiskV trace decoder (github.com/sifive/trace-decoder). The trace decoder tests run on Windows, Linux, and OS X.

### Getting the Trace Decoder Tests:
The trace-decoder-tests project is on github, in github.com/sifive/trace-decoder-tests. Use git to download the tests, as in:

git clone https://github.com/sifive/trace-decoder-tests.git

This will place the trace decoder tests in the trace-decoder-test directory.

### Test Folder Structure:
The parent folder for the trace decoder tests is trace-decoder-tests. Under that folder will be a number of sub-folders; one for each test. Each test folder ends in the name .test.

### Running the Tests:
To run the trace decoder tests, you must have a previously built SiFive trace decoder. When building the trace decoder, you need to do a "make install" after building to put all the built components in an install directory (see the trace decoder README on how to do this). When running the trace-decoder-tests, you tell it where the install directory is, and those components are tested to make sure they work.

The trace decoder tests are run by typing "make" in the trace decoder tests main directory trace-decoder-tests, and providing the path to the trace-decoder install directory. For example, if you have built the trace decoder and installed the components in "/path/to/trace-decoder/install", and have installed the trace decoder tests in the folder trace-decoder-tests, then execute:

/path/to/trace/decoder-tests/trace-decoder-tests$ make DQRPATH=/path/to/trace-decoder/install

Note: On a Windows system, use the \ character in paths.

The tests will be run and the results will be placed in result.log. There should be an entry in result.log for each test, indicating if it passed, failed, or was not run. Make will return 0 if all tests passed, or non-zero if there were failures.

Alternatively, if your path is set to include the trace decoder install bin directory, the DQRPATH argument can be omitted from the make command. For this to work, the path environment variable must be set to point to the bin directory in the install folder. The makefile will assume the other components can be found by searching for them in the folders one level up from the trace decoder bin directory.

### Interpreting the Results
When the makefile runs, it places the results of the tests in a file called result.log. This file will be located in the same directory as the makefile. Each line of the log file will indicate if a particular test passed, failed, or did not run. A test that did not run indicates that the makefile could not run that test, and is not a normal result.

### Trace Decoder Test Targets
Several targets are supported for the makefile; they are clean, test, and result. The clean target removes any intermediate files. The test target runs the tests, but does not accumulate the results in a result.log file. The result target scans the tests and computes the pass/fail/not run results of each test. The result target takes an optional RESULTPATH define of where to place the result.log file. It will normally be placed in the trace-decoder-tests directory.

Make with no targets is the same as "make test result".

### Running Individual Tests
To run an individual test cd into the folder for that test and run make. The makefile targets and defines are the same as the main makefile.

### Adding Tests
To add a test, first create a folder in the trace-decoder-tests directory. The name must end in .test. There are two makefile template files in the tracde-decoder-tests folder that can either be used as is, or as a starting point for doing something a little different. The file Makefile.dqrexe.templae can be used to create a test for the dqr.exe trace decoder executable. The file Makefile.jdqr.templae can be used to create a test for the Java jdqr program. The Java jdqr program is used to test the dynamic dll or so library. Copy the appropriate Makefile template into the new test folder, and make it Makefile.

Each test folder also has a subfolder names reference. This folder contains two zip files with the expected stdout and stderr for each test. The name of the zip files and their contents is based on the test name. The test name is taken from the first part of the test folder name. For example, the test itc_printf.htm.test has a test name of itc_printf. The zip files in the reference folder are named itc_printf.stderr.zip and itc_printf.stdout.zip. The files in the zip files are named similarly, but also include the platform name (either windows or unix). The unix platform name is used for Linux, OS X, and any other Unix-like OS. The reason windows is separated from the others is because of line endings and using the '\' path separator instead of '/'. So the itc_prints.stdout.zip file will contain itc_printf.unix.stdout and itc_printf.windows.stdout.

Also, if your test needs it (and it probably does), copy the trace file collected for the test along with the elf file used to create the trace and the source code for the project you traced to the new test directory. The trace file should be named with the name of the test with a .rtd extension and the elf file should be named similarly with a .elf extension. Leave the names of the source files (.c, .h, and anything else) as is.

When adding a test, you must run the dqr or jdqr program manually from the command line, capture the stdout and stderr output in files, and add those files to zip files in the results directory. And you must use the correct naming convention and test name! A makefile target to do this automatically may be added in the future.

### Other Information:
The makefiles do not support spaces in path names. The trace decoder install directory and the trace-decoder-tests directory must not be located in a path that includes any spaces in the folder names. This is a limitation of make.
