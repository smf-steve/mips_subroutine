# Makefile to test mips_subroutine

# summation: produces the sum of integers provided as cl arguments
# echo:  echos the command line arguments, argues are strings

INT_INPUT= 36 0x24 044 0o44 "\$" "\$"  "2\#100100" "0b0010 0100"
   # Note that in the Makefile $ and # are speciall so you need to escape
STR_INPUT= "a\0" "1234\0"  apple two three four 

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
	#mips_subroutine -S echo 8 $(INT_INPUT)
	java_subroutine -S echo 8 $(INT_INPUT)
	#mips_subroutine echo 6 $(STR_INPUT)
	java_subroutine echo 6 $(STR_INPUT)

read_echo_int: read_echo_int.s
	mips_subroutine read_echo_int <<< 5