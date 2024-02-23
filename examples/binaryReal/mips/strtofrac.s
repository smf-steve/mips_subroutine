        .text
        .include "macros/syscalls.s"
        .include "macros/stack.s"

        .macro li.d( %freg, %imm)
           li $at, %imm
           mtc1 $at, %freg
           cvt.d.w %freg, %freg
        .end_macro


        .globl strtofrac

strtofrac: nop        # int strtofrac(char[] buffer, int radix) {

        # t0 : &buffer
        # t1 : radix
        # t2 : &buffer + index // buffer[*]
        # t3 : int i;
        # t4 : char glyph;
        # t5 : int digit;
        # t6 : int value;
        # t7 : int neg_one


        # f0 : double d_value;
        # f2 : double d_radix;
        # f4 : double d_denom;
        # f6 : double d_fraction;
        # f8 : double d_digit;
        # f10: double d_10;

        # Save S registers
        push_s_registers()
        # Demarshal input args
        move $t0, $a0
        move $t1, $a1


        li  $t7, -1                     # neg_one = -1;

        li.d $f10, 10                   # d_10 = (double) 10;

        li.d $f0, 0                     # d_value = (double) 0;
        mtc1 $t1, $f2                   # d_radix = (double) radix;
        cvt.d.w $f2, $f2

        mov.d $f4, $f2                  # d_denom = (double) d_radix;

        li $t3, 0                       # i = 0;
        add $t2, $t0, $t3               # glyph = buffer[i];
        lbu $t4, 0($t2)

loop1:  beq $t4, $zero, done1           # for (; glyph != '\0' ;) {

          ###############################   digit = glyph2int(glyph, radix);
          
          move $a0, $t4                 # Marshal arg
          move $a1, $t1
          push_t_registers()            # Save T registers
          push $ra, $sp, $fp, $gp       # Save special registers
          jal glyph2int                 
          pop $ra, $sp, $fp, $gp        # Restore special registers
          pop_t_registers()             # Restore T registers
          move $t5, $v0                 # Demarshal return value
          
          #############################

          beq $t5, $t7, done1           # if (digit == neg_one ) break loop1;

          mtc1 $t5, $f8                 # d_digit    = (double) digit;
          cvt.d.w $f8, $f8

          div.d  $f6, $f8, $f4          # d_fraction = (double) d_digit / d_denom;
          add.d  $f0, $f0, $f6          # d_value  = (double) d_value + d_fraction;
          mul.d $f4, $f4, $f2           # d_denom  = (double) d_denom * d_radix;

          addi $t3, $t3, 1              # i++;
          add $t2, $t0, $t3             # glyph = buffer[i];
          lbu $t4, 0($t2)
          b loop1                       # continue loop1;
                                        # }
done1:  nop                             # ;
loop2:  ble $t3, 0, done2               # for (; i > 0 ;) {
          mul.d $f0, $f0, $f10          #   d_value = (double) d_value * 10.0;
          subi $t3, $t3, 1              #   i--;
        b loop2                         #   continue loop2;
                                        # }
done2:  nop                             # ;
        cvt.w.d $f0, $f0                # value = (int) d_value;
        mfc1 $t6, $f0

        # Marshal return value          # return value;
        move $v0, $t6 
        # Restore S registers
        pop_s_registers()
        jr $ra 
                                        # }

