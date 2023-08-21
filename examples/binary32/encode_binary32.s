                .globl encode_binary32
                .include "macros/syscalls.s"
                .include "position_of_msb.s"


                # The following is test input to help you in your initial debugging
                li $a0, '+'    # 0x2b (43)
                li $a1, 0x34E1 # (0011 0100 1110 0001) 
                li $a2, '-'    # 0x2d   (45)
                li $a3, 0x29   # (41)



encode_binary32: nop
                # Prototype:  encode_binary32( sign, coefficient, expon_sign, expon )
                # Formal Parameters:
                # a0: sign -- an ASCII character
                # a1: coefficient (representing, in total,:  1.\<mantissa\>) 
                # a2: expon_sign -- an ASCII character
                # a3: exponent (unbiased)
                # v0: the encoded binary32 value
        
                # Initial Register Allocation
                # t0: sign
                # t1: coefficient
                # t2: expon_sign
                # t3: exponent

                # Additional Register Allocation
                # t4: encoded_sign
                # t5: encoded_mantissa
                # t6: encoded_exponent;
                # t7: pos_msb
                # t8: negative_sign
                # t9: reposition


                # Demarshall your input arguments
                move $t0, $a0
                move $t1, $a1
                move $t2, $a2
                move $t3, $a3

                # Insert a copy of your Java TAC code here and then comment it out!

                                        # /////////////////////////////////////////////////////////
                                        # // BEGIN CODE of INTEREST
                                        # /////////////////////////////////////////////////////////
                li $t8, '-'             # final int negative_sign = '-';
                    
                                        # /////////////////////////////////////////////////////////
                                        # // 1. Encode each of the three fields of the floating point format:
                    
                                        # // 1.1 Sign Encoding
                                        # //     - Based upon the sign, encode the sign as a binary value
                bne $t0, $t8, alt1      # if (sign == negative_sign) {
    cons1:      nop                     #   ;
                li $t4, 1               #   encoded_sign = 0b1;
                b done1                 #   // break;
                # End of Block          # } else {

    alt1:       nop                     #   ;
                li $t4, 0               #   encoded_sign = 0b0;
                b done1                 #   //break;
                # End of Block          # }

    done1:      nop                     # ;

                    
                                        # // 1.2 Exponent Encoding
                                        # //     - Make the exponed a signed quanitity
                                        # //     - Add the bias
                                        # // negative_sign = '-';
                bne $t2, $t8, alt2      # if (expon_sign == negative_sign) {
    cons2:      nop                     #   ;                        
                sub $t6, $zero, $t3     #   encoded_exponent = - exponent;
                b done2                 #   // break;
                # End of Block          # } else {

    alt2:       nop                     #   ;
                move $t6, $t3           #   encoded_exponent = exponent;
                b done2                 #   // break;
                # End of Block          # }

    done2:      nop                     # ;
                                        # // Add the bias to the exponent
                addi $t6, $t6, 127      # encoded_exponent = encoded_exponent + binary32_bias; // 127
                                        #                    
                                        # 
                                        # // 1.3  Mantissa Encoding
                                        # //      - Determ the number of bits in the coefficient
                                        # //      - Shift the coefficient to the left to obtain the mantissa
                position_of_msb($t1)    # pos_msb = position_most_significant_bit(coefficient);
                move $t7, $v0            
                                        # {
                li $t9, 32              #    int reposition = 32;
                sub $t9, $t9, $t7       #    reposition = reposition - pos_msb;
                addi $t9, $t9, 1        #    reposition = reposition + 1;
                sllv $t5, $t1, $t9      #    encoded_mantissa = coefficient << reposition;
                                        # }
                     
                                        # /////////////////////////////////////////////////////////
                                        # // 2. Shift the pieces into place: sign, exponent, mantissa
                sll $t4, $t4, 31        # encoded_sign     = encoded_sign      << sign_shift    ;  // (23 + 8)
                sll $t6, $t6, 23        # encoded_exponent = encoded_exponent  << expon_shift   ;  //
                srl $t5, $t5,  9        # encoded_mantissa = encoded_mantissa >>> mantissa_shift;  // (1 + 8)
                                        # 
                                        # /////////////////////////////////////////////////////////
                                        # // 3. Merge the pieces together
                or $v0, $t4, $t5        # $v0 = encoded_sign | encoded_exponent;
                or $v0, $v0, $t6        # $v0 = $v0 | encoded_mantissa;
                                        # /////////////////////////////////////////////////////////
                                        # // END CODE of INTEREST
                                        # /////////////////////////////////////////////////////////

                # Provide some output for initial testing
                print_t($v0)
                print_ci('\n')

                # Marshall  your output arguements
                move $v0, $v0

                jr $ra
                # With the test input, the value of v0 should be:
                # v0: 0x2B538400
