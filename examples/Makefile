# Makefile to test mips_subroutine

# summation: produces the sum of integers provided as cl arguments
# echo:  echos the command line arguments, argues are strings

INT_INPUT= 36 0x24 044 0o44 "\$" "\$"  "2\#100100" "0b0010 0100"
   # Note that in the Makefile $ and # are special so you need to escape
STR_INPUT= "a\0" "1234\0"  apple two three four 

TEST_CASES= empty hello_world sum_list summation echo_list binaryReal  # frame_mips

all: ${TEST_CASES}

empty: 
	mips_subroutine empty
	java_subroutine empty

hello_world:
	mips_subroutine hello_world
	java_subroutine hello_world

sum_list:
	#mips_subroutine sum_list 8 $(INT_INPUT)    # 36 * 8 = 288
	java_subroutine sum_list 8 $(INT_INPUT)    # 36 * 8 = 288

summation: 
	mips_subroutine summantion 20    # 210
	java_subroutine summantion 20    # 210


echo_list: echo_list.j echo_list.s
	# Uses the default frame, i.e., ad-hoc
	#mips_subroutine -S echo 8 $(INT_INPUT)
	java_subroutine -S echo 8 $(INT_INPUT)
	#mips_subroutine echo 6 $(STR_INPUT)
	java_subroutine echo 6 $(STR_INPUT)

.PHONY: binaryReal
binaryReal:
	cd binaryReal/java ; make test_java	
	cd binaryReal/mips ; make test_mips

.PHONY: binary32
binary32:
	cd binary32 ; make test_java	
	cd binary32 ; make test_mips


# Frames:

.PHONY: frames_mips
frames_mips:	
	sed 's/\$${FRAME_TYPE}/ad-hoc/'   frame_example.s >frame_example_ad-hoc.s
	sed 's/\$${FRAME_TYPE}/register/' frame_example.s >frame_example_register.s
	sed 's/\$${FRAME_TYPE}/full/'     frame_example.s >frame_example_full.s
	mips_subroutine -L frame_example_ad-hoc.s   -f ad-hoc   name 1 2 3 4 5 6 7 8
	mips_subroutine -L frame_example_register.s -f register name 1 2 3 4 5 6 7 8
	mips_subroutine -L frame_example_full.s     -f full     name 1 2 3 4 5 6 7 8
	rm -f frame_example_*.s

