# This example MIPS program performs the traditional "no-op" process.
#
# Simply put, it exercises the following operations
#   1. a process is created within the MIPS environment
#   1. a call is made to the main subroutine
#   1. the exit syscall is explicitly invoked
#   1. the process is then shutdown
#
#
# You can test the hello_world subroutine via the mips_subroutine facility 
#
# $ mips_subroutine empty
#
                .data
                # insert your data declarations

                .align 2           
                # ensure your data declarations are aligned appropriately
        
                .text           
                # insert your code declarations
        
                .globl empty     
                # define your default starting routine
 

test:           # A hard code subroutine to test "empty"
                jal empty

                li $v0, 10      # v0 contains the number for exit, 10
                syscall         # trap: exit


empty:          nop             # label for the main subroutine

                move $v0, $zero
                jr $ra
