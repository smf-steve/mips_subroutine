SRC =  .
DST ?= /tmp

install: bin include

.PHONY: bin include
bin:
	mkdir ${DST}/bin 2> /dev/null
	cp bin/mips_subroutine.md bin/mips_subroutine bin/java_subroutine ${DST}/bin

include:
	cp -r include ${DST}/


