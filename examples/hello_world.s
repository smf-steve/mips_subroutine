# This example MIPS program performs the traditional "hello-world" example. 
# 
#   1. the variable str is placed into to .data segment
#   1. the variable str is initialized with "Hello World\n"
#   1. the subroutine "main" is placed into the .text segment
#   1. the subroutine "main" performs the following steps
#      - load the lval of str (i.e., its address) into a0
#      - load the value 4 into v0 with 
#      - trap to the kernel requesting Service #17
#
# You can test the hello_world subroutine via the mips_subroutine facility 
#
# $ mips_subroutine hello_world
#
                .data
                .align 0                # Set alignment to be on byte boundary
str:            .asciiz "Hello World\n" # H,e,l,l,o, ,W,o,r,l,d,\n,\0

                .text
                .globl hello_world

test:           # A hard code subroutine to test "hello_world"
                jal hello_world

                li $a0, 0       # a0 contains the return value        
                li $v0, 17      # Service #17: exit with a value
                syscall 


hello_world:    nop
                la $a0, str     # load the lval (i.e., the address) into a0
                li $v0, 4       # Service #4: print string
                syscall         

                li $v0, 0       # return the value "0" for success
                jr $ra          # Return from the subroutine

