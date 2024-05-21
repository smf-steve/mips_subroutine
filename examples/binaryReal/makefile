COMMITS=$(shell git log --oneline | wc -l)
MIN_COMMITS=20
SHELL=/bin/bash
MAKEFILE ?= makefile

# The following are the file to be created by the student
J_SRC=strtol.j whole2bin.j fractional2bin.j
M_SRC=strtol.s whole2bin.s fractional2bin.s


ARG_CASE1=10 "\#"  1234 "." 4321
OUTPUT_CASE1="2\# 10011010010.01101110100111100001101"
RESULT_CASE1="10"

ARG_CASE2=16 "\#"  FACE "." DEAF
OUTPUT_CASE2="2\# 1111101011001110.11011110101010110011011"
RESULT_CASE2="16"

ARG_CASE3=8 "\#"  1234 "." 43
OUTPUT_CASE3="2\# 1010011100.10001010001111010111000"
RESULT_CASE3=" 8"

ARG_CASE4=8 "\#"  1234 "." 4300000
OUTPUT_CASE4="2\# 1010011100.100011"
RESULT_CASE4=" 8"


test: tags number_commits
	@echo 
	@echo \"make test_java\" to test your current version of binaryReal.j
	@echo \"make test_mips\" to test your current version of binaryReal.s
	@echo \"make final\" to test all your final versions of binaryReal.\*
	@echo \"make validate\" to validate your final submission
	@echo 
	@echo Make sure you are in the correct directory when you type the above commands

test_java: $(J_SRC)
	@echo $(OUTPUT_CASE1) "<- Correct output"
	@java_subroutine -L . -S binaryReal $(ARG_CASE1)
	@echo "Correct V0:" $(RESULT_CASE1)
	@echo
	@echo $(OUTPUT_CASE2) "<- Correct output"
	@java_subroutine -L . -S binaryReal $(ARG_CASE2)
	@echo "Correct V0:" $(RESULT_CASE2)
	@echo
	@echo $(OUTPUT_CASE3) "<- Correct output"
	@java_subroutine -L . -S binaryReal $(ARG_CASE3)
	@echo "Correct V0:" $(RESULT_CASE3)
	@echo
	@echo $(OUTPUT_CASE4) "<- Correct output"
	@java_subroutine -L . -S binaryReal $(ARG_CASE4)
	@echo "Correct V0:" $(RESULT_CASE4)
	@echo

test_mips: $(M_SRC)
	@echo $(OUTPUT_CASE1) "<- Correct output"
	@mips_subroutine -L . -S binaryReal $(ARG_CASE1)
	@echo "Correct V0:" $(RESULT_CASE1)
	@echo
	@echo $(OUTPUT_CASE2) "<- Correct output"
	@mips_subroutine -L . -S binaryReal $(ARG_CASE2)
	@echo "Correct V0:" $(RESULT_CASE2)
	@echo
	@echo $(OUTPUT_CASE3) "<- Correct output"
	@mips_subroutine -L . -S binaryReal $(ARG_CASE3)
	@echo "Correct V0:" $(RESULT_CASE3)
	@echo
	@echo $(OUTPUT_CASE4) "<- Correct output"
	@mips_subroutine -L . -S binaryReal $(ARG_CASE4)
	@echo "Correct V0:" $(RESULT_CASE4)
	@echo

