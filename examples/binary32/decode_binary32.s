# This file will be provided later by the professor. 

                .globl decode_binary32
                .include "macros/syscalls.s"

                .data

# Following is a record/struct/object for the decoding of a binary32

object32:       .align 2
sign:           .word
number:         .word
expon_sign:     .word
exponent:       .word

                .text

                li $a0, 726893568


decode_binary32: nop            # object32 = decode_binary32(encoding)
                nop
                # Formal Arguments
                # v0:  address of object32
                # a0:  encoding

        
                # Register Allocation
                # t0: encoding
                # t1: sign
                # t2: number, mantissa
                # t3: expon_sign
                # t4: exponent
                # t5: is_zero
                # t6: temp      # used to hold the value of exponent

                # Demarshal the input arguments
                move $t0, $a0

                # Separate the value into three parts: sign, exponent, mantissa
                andi $t1, $t0, 0x80000000  # sign = encoding     & 0x80000000; // 1000 0000 0000 0000 0000 0000 0000 0000
                andi $t4, $t0, 0x7F800000  # exponent = encoding & 0x7F800000; // 0111 1111 1000 0000 0000 0000 0000 0000
                andi $t2, $t0, 0x007FFFFF  # mantissa = encoding & 0x007FFFFF; // 0000 0000 0111 1111 1111 1111 1111 1111

                # Modify the mantissa to add back the "1"
                ori $t2, $t2, 0x00800000   # number = mantissa | 0x00800000;  // 0000 0000 1000 0000 0000 0000 0000 0000

                # Shift the values to be right justified
                srl $t1, $t1, 31           # sign = sign >> 31;
                srl $t4, $t4, 23           # expon = expon >> 23;

                # Simplify the number, to drop the superflous zeros on the right
                andi $t5, $t2, 0x01        # is_zero = number & 0x01;  // is it even
           top: bne $t5, $zero, done       # for (; is_zero == 0 ) {
                  srl $t2, $t2, 1          #   number = number >> 1;
                  andi $t5, $t2, 0x1       #   is_zero = number & 0x1;
                b top                      #   continue;
                                           # }
          done: nop

                # Decode the value of the sign
                bne $t1, $zero, skip1      # if (sign == 0 ) { sign = '+'; }
                  li $t1, '+'
                  b skip2
         skip1: nop
                beq $t1, $zero, skip2      # else { sign = '-'; }
                  li $t1, '-'
         skip2: nop


                # Remove the bias from the exponent
                addi $t4, $t4, -127        # exponent = exponent - 127;

                # Create the expon_sign and re-encode the exponent
                move $t6, $t4              # temp = exponent;
                bge $t6, $zero, skip3      # if ( temp < 0 ) {
                   li $t3, '-'             #   expon_sign = '-';
                   sub $t4, $zero, $t4     #   exponent = ~ exponent + 1;
                                           # }
         skip3: nop

                ble $t6, $zero, skip4      # if (temp >= 0 ) {
                   li $t3, '+'             #   expon_sign = '+';
                   nop                     #   exponent = exponent;
                                           # }
         skip4: nop
                # Write the components to memory
                sw $t1, sign               # MEM[ &sign ]       = sign;
                sw $t2, number             # MEM[ &number ]     = number;
                sw $t3, expon_sign         # MEM[ &expon_sign ] = expon_sign;
                sw $t4, exponent           # MEM[ &exponent ]   = exponent;

                # Print the coponents to stdout
                print_x  $t1
                print_ci '\n'
                print_x  $t2
                print_ci '\n'
                print_x  $t3
                print_ci '\n'
                print_x  $t4
                print_ci '\n'


                # Marshall the output arguements
                la $v0, object32           # $v0 = &object32;


                # Return from the subroutine `jr $ra`
                jr $ra