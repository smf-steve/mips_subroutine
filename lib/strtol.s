        .text
        .include "../include/syscalls.s"
        .include "../include/stack.s"

        .text
        .globl i_strtol

i_strtol: nop     # int strtol(char[] buffer, char[] end, int radix) {
        # t0 : & buffer
        # t1 : radix
        # t2 : retval;
        # t3 : digit;
        # t4 : value;
        # t5 : i;
        # t6 : glyph;
        # t7 : &buffer + i
        # s0 : -1

        push_s_registers                # Save S registers
        move $t0, $a0                   # Demarshal input arguments
        move $t1, $a1
        move $t1, $a2                   # The formal arg end is Ignored.

        li $s0, -1                      # neg_one = -1;
        li $t4, 0                       # value = 0;
        li $t5, 0                       # i = 0;
        add $t7, $t0, $t5               # glyph = buffer[i];
        lbu $t6, 0($t7) 
loop1:  beq $t6, $zero, done1           # for (;  glyph != '\0' ;) {

           ##############################   digit = glyph2int(glyph, radix);

           move $a0, $t6                # Marshal input arguments
           move $a1, $t1
           push_t_registers()           # Save T registers
           push $ra, $sp, $fp, $gp      # Save special registers  
           jal glyph2int                  
           pop $ra, $sp, $fp, $gp       # Restore special registers
           pop_t_registers()            # Restore T registers
           move $t3, $v0                # Demarshal return value
           ##############################

           beq $t3, $s0, done1          #   if (digit == neg_one ) break loop1;
           mul $t4, $t4, $t1            #   value = value * radix; 
           add $t4, $t4, $t3            #   value = value + digit;
           addi $t5, $t5, 1             #   i++;
           add $t7, $t0, $t5            #   glyph = buffer[i];
           lbu $t6, 0($t7) 
        b loop1                         #   continue loop1;
                                        # }
done1:  nop                             # ;
                                        # return value;
        move $v0, $t4                   # Marshal return values  
        pop_s_registers()               # Restore S registers                 
        jr $ra
                                        # }



#       .globl glyph2int

glyph2int:  nop             # int glyph2int(char c, int radix){
        # t0 : c
        # t1 : radix
        # t2 : value;
        # s0 : char_0;
        # s1 : char_9;
        # s2 : char_a;
        # s3 : char_f;
        # s4 : char_A;
        # s5 : char_F;

        push_s_registers()      # Save S registers 
        move $t0, $a0           # Demarshal input arguments
        move $t1, $a1

        li $t2, -1              # value = -1;
        li $s0, '0'             # char_0 = '0';
        li $s1, '9'             # char_9 = '9';
        li $s2, 'a'             # char_a = 'a';
        li $s3, 'f'             # char_f = 'f';
        li $s4, 'A'             # char_A = 'A';
        li $s5, 'F'             # char_F = 'F';

        bgt $s0, $t0, fi_1      # if (char_0 <= c ) {
        bgt $t0, $s1, fi_1      #  if (c <= char_9) {
          subi $t2, $t0, '0'    #    value = c - '0';
                                #  }
                                #  // goto fi_1
                                # }
fi_1:   nop                     # ;
        bgt $s2, $t0, fi_2      # if (char_a <= c ) {
        bgt $t0, $s3, fi_2      #     if (c <= char_f) {
          subi $t2, $t0, 'a'    #       value = c - 'a'
          addi $t2, $t2, 10     #       value = value + 10;
                                #     }
                                #     // goto fi_2
                                # }
fi_2:   nop                     # ;
        bgt $s4, $t0, fi_3      # if (char_A <= c ) {
        bgt $t0, $s5, fi_3      #     if (c <= char_F) {
          subi $t2, $t0, 'A'    #       value = c - 'A' 
          addi $t2, $t2, 10     #       value = value + 10;
                                #       // goto fi_3
                                #     }
                                # }
fi_3:   nop                     # ;
        blt $t2, $t1, fi_4      # if (value >= radix) {
          li $t2, -1            #     value = -1;
                                #     // goto fi_4
                                # }
fi_4:   nop                     # ;
                                # return value;
        move $v0, $t2           # Marshal return value
        pop_s_registers()       # Restore S registers
        jr $ra                        
                                # }

