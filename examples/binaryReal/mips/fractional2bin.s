 .text
        .include "macros/syscalls.s"
        .include "macros/stack.s"

        .globl fractional2bin

fractional2bin: nop  #  int (int number, int max_bits) {
        # t0 : number
        # t1 : max_bits
        # t2 : int n;
        # t3 : int max;
        # t4 : int count;

            
        push_s_registers()          # Save S registers
        move $t0, $a0               # Demarshal input arguments
        move $t1, $a1

        move $t2, $t0               # n = number;

        ############################# max = value_of_max(n);
        move $a0, $t2               # Marshal input arguments    
        push_t_registers()          # Save T registers           
        push $ra, $fp, $sp, $gp     # Save special registers
        jal value_of_max
        pop $ra, $fp, $sp, $gp      # Restore special registers
        pop_t_registers()           # Restore T registers
        move $t3, $v0               # Demarshal return value
                    
        li $t4, 0                   # count=0;
loop1:  bge $t4, $t1, done1         # for (; count < max_bits ;) {
          sll $t2, $t2, 1           #   n = n << 1;
          beq $t2, $zero, done1     #   if (n == 0) break loop1;
          blt $t2, $t3, alt         #   if ( n >= max) {
cons:       nop                     #     ;               
            print_ci('1')           #     mips.print_ci('1');
            sub $t2, $t2, $t3       #     n = n - max; 
            b end_if                #     // goto end_if
                                    #   } else {
alt:        nop                     #     ;               
            print_ci('0')           #     mips.print_ci('0');
            b end_if                #     // goto end_if
                                    #   }
end_if:   nop                       #   ;
          add $t4, $t4, 1           #   count ++;
        b loop1                     #   continue loop1;
                                    # }
done1:  nop                         # ; 

                                    # return 0;
            move $v0, $zero         # Marshal return value
            pop_s_registers()       # Restore S registers
            jr $ra
                                    # }

            
value_of_max: nop                 #  public static int value_of_max(int       number) {
        # t0: number
        # t1: max                 # int max;
        # t2: i                   # int i;
        # s0: 8                   # int _8;
        # s1: 10                  # int _10;
            
        # Save S registers
        push_s_registers()
        # Demarshal input arguments
        move $t0, $a0
            
        li $t1, 10              # max = 10;
        li $t2, 0               # i=0;
        li $s0, 8               # _8 = 8;
        li $s1, 10              # _10 = 10;
            
loop2:  blt $t0, $t1, done2     # for (; number >= max ;) {
          bgt $t2, $s0, loop2   #    if( i > _8) break loop2;
          mul $t1, $t1, $s1     #    max = max * _10;
          addi $t2, $t2, 1      #    i++;
        b loop2                 #    continue loop2;
                                # }
done2:  nop                     # ;
                                # return max;
        move $v0, $t1           # Marshal output value
        pop_s_registers()       # Restore S registers                          
        jr $ra
                                # }
