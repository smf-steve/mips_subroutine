
            .data
str:        .space 1024

            .text
            .include "macros/stack.s"

            .globl echo4

strcpy:     nop                     #  end = strcpy(str,substr);
            # a0: & str
            # a1: & substr
            # t0: str_p, end
            # t1: substr_p
            # t2: (* str_p)         # Note: not used since it only occurs on the LHS
            # t3: (* substr_p)

            move $t0, $a0           # str_p = & str;
            move $t1, $a1           # substr_p = & substr_p;
                                      
            lbu $t3, 0($t1)         #       // $t2 = (* substr_p)
   loop:    beq $t3, $zero, done    # loop: for (; (* substr_p) != '\0' ;) {
              sb   $t3, 0($t0)      #         (* str_p) = ( * substr_p );
              addi $t0, $t0, 1      #         str_p ++;
              addi $t1, $t1, 1      #         substr_p ++
              lbu  $t3, 0($t1)      #         // $t2 = (* substr_p)
            b loop                  #         continue loop;
                                    #       }
    done:   nop                     # done: nop
            sb $zero, 0($t1)        # (* str_p) = '\0'

            move $v0, $t0           # return str_p;
            jr $ra

            .macro call_strcpy
              push $t0, $t1, $t2, $t3, $4, $t5, $t6
              jal strcpy              # str_p = strcpy(str_p, substr_p);
              pop $t0, $t1, $t2, $t3, $4, $t5, $t6
            .end_macro

echo4:      nop                     # Entry point of the echo4 subroutine
                                    # concatenate the four arguments
            # a0: &str0
            # a1: &str1
            # a2: &str2
            # a3: &str3
            #-------
            # t0: &str0
            # t1: &str1
            # t2: &str2
            # t3: &str3
            # t4: str_p
            # t5: substr_p
            # t6: return_address (ra)

            move $t6, $ra

            move $t0, $a0
            move $t1, $a1
            move $t2, $a2
            move $t3, $a3
            
            la $t4, str             # str_p = &str;
            
            move $t5, $t0           # substr_p = &str0;

            move $a0, $t4
            move $a1, $t5

            call_strcpy

            move $t4, $v0
                                    
            move $t5, $t1           # substr_p = &str1;
            
            move $a0, $t4
            call_strcpy             # str_p = strcpy(str_p, substr_p);
            move $t5, $t2           # substr_p = &str2;

            move $a0, $t4
            move $a1, $t5
            call_strcpy             # str_p = strcpy(str_p, substr_p);
            move $t4, $v0                       


            move $t5, $t3           # substr_p = &str3;

            move $a0, $t4
            move $a1, $t5
            call_strcpy             # str_p = strcpy(str_p, substr_p);
            move $t4, $v0

            la $v0, str             # return str;
            jr $t6




