MIPS_HOME ?=  .
DST ?= /tmp

install: bin include

.PHONY: bin include
bin:
	-mkdir -p ${DST}/bin 2> /dev/null
	-cp ${MIPS_HOME}/bin/mips_subroutine.md bin/mips_subroutine bin/java_subroutine ${DST}/bin

include:
	-cp -r ${MIPS_HOME}/include ${DST}/


