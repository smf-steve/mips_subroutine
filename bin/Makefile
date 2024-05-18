DST=${HOME}/classes/comp122
SRC=${HOME}/repositories/mips_subroutine

install:
	sed "s|${SRC}|${DST}|" mips_subroutine >${DST}/bin/mips_subroutine
	cp ${DST}/bin/mips_subroutine ${DST}/bin/java_subroutine
	cp -r ../include/* ${DST}/include/
	cp -r ../lib/* ${DST}/lib/