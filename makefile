MIPS_HOME ?=  .
DST ?= /tmp

install: bin include lib

.PHONY: bin include lib
bin:
	-mkdir -p ${DST}/bin 2> /dev/null
	-cp ${MIPS_HOME}/mips_subroutine.md  ${DST}/bin
	-cp ${MIPS_HOME}/bin/mips_subroutine ${DST}/bin
	-cp ${MIPS_HOME}/bin/java_subroutine ${DST}/bin

include:
	-cp -r ${MIPS_HOME}/include ${DST}/


lib:
	-mkdir -p ${DST}/lib 2> /dev/null
	# Don't copy over anything yet