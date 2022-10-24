#  example:  mips_sub  -A example 1 2 "hello there" boo 2.3

        .data

        .include ".data_segment"

# All command line args are placed in the data segment
enry:   .asciiz "example"
arg0:   .word 1
arg1:   .word 2
arg2:   .asciiz "hello there"
arg3:   .asciiz "boo"
arg4:   .double 2.3

argc:   .word 5
argv:   .word arg0, arg1, arg2, arg3, arg4


        .text
        .include "system/syscalls.s"
        .include "system/stack.s"
        .globl main

main:   nop

         # Place Random data into the T registers
         # Place Deadbeef into the S registers
         # Marshal the Input Arguements
         ##  Load the \"a\" registers
         ##  Push remaining args onto the stack
         
         # Call the subroutine
         la $at, entry_str

         # Exit the program
         exit $v0

         
         # The dumping of the registers are handled by the Shell script


         print_s $at
            jal reduce.s
         la $at, _return_str
         print_s $at
         print_d $v0
         print_ci '\n'
	# Dump the "v0" register
        # v0: value
        print_ci 'v'
        print_ci '0'
        print_ci ':'
        print_ci ' '
        print_d $v0
        print_ci '\n'


	# Dump the "t" registers
        # t0: value
        print_ci 't'
        print_ci '0'
        print_ci ':'
        print_ci ' '
        print_d $t0
        print_ci '\n'

        # t1: value
        print_ci 't'
        print_ci '1'
        print_ci ':'
        print_ci ' '
        print_d $t1
        print_ci '\n'

        # t2: value
        print_ci 't'
        print_ci '2'
        print_ci ':'
        print_ci ' '
        print_d $t2
        print_ci '\n'

        # t3: value
        print_ci 't'
        print_ci '3'
        print_ci ':'
        print_ci ' '
        print_d $t3
        print_ci '\n'

	# Exit the program
	exit $v0

	.include "reduce.s.s"

