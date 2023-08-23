                .globl encode_binary32
                .include "macros/syscalls.s"
                .include "macros/bit_manipulation.s"
test:           nop                
                li $a0, '+'    # 0x2b (43)
                li $a1, 0x34E1 # (0011 0100 1110 0001) 
                li $a2, '-'    # 0x2d   (45)
                li $a3, 0x29   # (41)

                jal encode_binary32

                move $a0, $v0
                li $v0, 17
                syscall

encode_binary32: nop
                # Prototype:  encode_binary32( sign, num, expon_sign, expon )
            # Formal Parameters:
            # a0: sign -- an ASCII character
            # a1: number (representing, in total,:  1.\<mantissa\>) 
            # a2: expon_sign -- an ASCII character
            # a3: exponent (unbiased)
            # v0: the encoded binary32 value
    
            # t0: sign
            # t1: number, mantissa
            # t2: expon_sign
            # t3: exponent
            # t4: amount
            # t5: final
    
    
            # 1. Demarshal your input args
            move $t0, $a0
            move $t1, $a1
            move $t2, $a2
            move $t3, $a3
    
            # 1. Decode and then encode the sign
            bne $t0, '+', skip1             # if (sign == '+') { sign = 0;} 
              li $t0, 0
 skip1:     nop 
    
            bne $t0, '-', skip2             # if (sign == '-') { sign = 1;}
              li $t0, 1
 skip2:     nop 
    
    
            # 1. Obtain the mantissa, by left-justifying the number while dropping the leading 1
            #    - shift the number to the left the appropriate number of positions
            #    - use the `position_of_msb` macro to determine this number 
            position_of_msb($t1)            # $v0 = position_of_msb(number);
            li $t4, 33                      # amount = 32 - $v0 + 1;
            sub $t4, $t4, $v0 
            
            sllv $t1, $t1, $t4              # mantissa = number << amount;
    
            # 1. Decode the sign of the exponent and then reencode the exponent
            bne $t2, '+', skip3             # if (exp_sign == '+') { 
              li $t2, 0                     #   exp_sign = 0; 
              move $t3, $t3                 #   expon = expon;
                                            # }
 skip3:     nop
    
            bne $t2, '-', skip4             # if (exp_sign == '-') { 
              li $t2, 1                     #   exp_sign = 1;
              nor $t3, $t3, $zero           #   expon =  ~ expon + 1;
              addi $t3, $t3, 1
                                            # }
 skip4:     nop
    
            # 1. Add the bias to the exponent
            addi $t3, $t3, 127              # expon = expon + bias;  // bias == 127
    
            # 1. Shift the pieces into place
            sll $t0, $t0, 31                # sign     = sign << (32 - 1);
            sll $t3, $t3, 23                # expon    = expon << 32 - (1 + 8);
            srl $t1, $t1, 9                 # mantissa = mantissa >> (1 + 8);
    
    
            # 1. merge the pieces together
    
            or $t5, $t0, $t3                # final = sign | expon;
            or $t5, $t5, $t1                # final = final| mantissa;
    
            # 1. call print_t to print the value
            print_t($t5)                    # print_t(final)
            print_ci '\n'
    
            # 1. Marshal your output arguments 
            move $v0, $t5                   # $v0 = final
    
            # 1. Return from the subroutine `jr $ra`
            #    - Note, as explained in class, the return will when using MARS -- that is Okay
            jr $ra
    
    
