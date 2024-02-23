        .text
        .include "macros/syscalls.s"
        .include "macros/stack.s"

        .globl binaryReal

binaryReal: nop         # int binaryReal(char[] arg0, char[] arg1, char[] arg2, char[] arg3) {
        # t0: arg0
        # t1: arg1
        # t2: arg2
        # t3: arg3
        # t4: char [] arg4 = null;     // Additional Formal Arguments which is on the static
        # t5: int  radix;
        # t6: char sharp;
        # t7: int  whole;
        # t8: int  point;
        # t9: int  fractional;
        # 
        .eqv max_bits 23        #    final int max_bits = 23;
 
        pop $t4                 #    arg4 = mips.pop(arg4);

        push_s_registers        # Save S registers
        move $t0, $a0           # Marshal input arguments
        move $t1, $a1        
        move $t2, $a2        
        move $t3, $a3        
                                # Shouldn't the pop of arg4
                                # be located here?
                                # See notes below.

        # pop $t4               #    arg4 = mips.pop(arg4);


        #########################    radix = strtol(arg0, 10);
        move $a0, $t0           # Marshal input arguments
        li   $a1, 10

        push_t_registers        # Save T Registers
        push $ra, $fp, $sp, $gp # Save special registers
        jal strtol              
        pop $ra, $fp, $sp, $gp  # Restore special registers
        pop_t_registers         # Restore T Registers
        move $t5, $v0           # Demarshal return value
        ########################

        lbu $t6 0($t1)          #    sharp      = arg1[0];

        #########################    whole      = strtol(arg2, radix);

        move $a0, $t2           # Marshal input arguments
        move $a1, $t5
        push_t_registers        # Save T Registers
        push $ra, $fp, $sp, $gp # Save special registers
        jal strtol              
        pop $ra, $fp, $sp, $gp  # Restore special registers
        pop_t_registers         # Restore T Registers
        move $t7, $v0           # Demarshal return value
        #########################

        lbu $t8, 0($t3)         #    point      = arg3[0];

        #########################    fractional = strtofrac(arg4, radix);
        
        move $a0, $t4           # Marshal input arguments
        move $a1, $t5
        push_t_registers        # Save T Registers
        push $ra, $fp, $sp, $gp # Save special registers
        jal strtofrac              
        pop $ra, $fp, $sp, $gp  # Restore special registers
        pop_t_registers         # Restore T Registers
        move $t9, $v0           # Demarshal return value
        #########################

        print_ci('2')           #    mips.print_ci('2'); 
        print_ci('#')           #    mips.print_ci('#');
        print_ci(' ')           #    mips.print_ci(' ');

        ##########################   whole2bin(whole);     

        move $a0, $t7           # Marshal input arguments
        push_t_registers        # Save T Registers
        push $ra, $fp, $sp, $gp # Save special registers
        jal whole2bin              
        pop $ra, $fp, $sp, $gp  # Restore special registers
        pop_t_registers         # Restore T Registers
        move $v0, $v0           # Demarshal return value
        #########################

        print_ci('.')           #    mips.print_ci('.');

        #########################    fractional2bin(fractional, max_bits);
        
        move $a0, $t9           # Marshal input arguments
        li   $a1, max_bits
        push_t_registers        # Save T Registers
        push $ra, $fp, $sp, $gp # Save special registers
        jal fractional2bin              
        pop $ra, $fp, $sp, $gp  # Restore special registers
        pop_t_registers         # Restore T Registers
        move $v0, $v0           # Demarshal return value
        #########################

        print_ci('\n')          #    mips.print_ci('\n');
 
                                #    return radix;
        move $v0, $t5           # Marshal return values
        pop_s_registers         # Restore S registers
        jr $ra
                                # }
                                # 


################################################################
# Note about the position of:  
#         pop $t4               #    arg4 = mips.pop(arg4);

# In your subroutines, you have four or less arguments.
# As such you don't need to build a frame for each of the 
# subroutines. Since of your formal and local variables are 
# allocated to registers. We only need the stack for temporary
# variables.
# 
# In binaryReal, there are five arguments. One of which (arg4) 
# must be placed on the stack. Are chooses are:
#   1. Pop the argument off the stack -- prior to saving temps
#   1. Use a frame for the subroutine's formal arguments
# 
# Under the frame approach, the structure of subroutine is as 
# follows:
# 
# binary2real: nop
# 
#         build_frame(5)    # Frame has 5 formal arguments,
#           - fp = sp - 5*4
#         push_s_registers()
#         demarshal input arguments                
#            - lw $t0,  0($fp)
#            - lw $t1,  4($fp)
#            - lw $t2,  8($fp)
#            - lw $t3, 12($fp)
#            - lw $t4, 16($fp)
# 
#         ... subroutine code ...
# 
#         marshal return value
#           - sw $t5,  0($fp) 
#         pop_s_registers()
#         jr $ra
# 
# For mips, however, we need to modify the above outline of statements
# to use $a0, .. $a3 for the first four arguments, and only use the 
# frame for the additional arguments
