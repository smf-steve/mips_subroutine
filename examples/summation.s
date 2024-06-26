# Demonstration MIPS code for the Java subroutine:
#
# public static int summation(int N) {
#
#   int sum = 0;
#   for(in i=1; i < N ; i++) {
#     sum += i;
#   }
#   return sum;
#
# }

                .include "include/syscalls.s"
                .globl summation

test:           nop             # A hard code subroutine to test "summation"
                li $a0, 4
                
                jal summation
                li $v0, 10      # v0 contains the number for exit, 10
                syscall         # trap: exit


summation:      nop                     # public static int summation(int $a0)

                # bookkeeping
                # t1: $a0: N
                # t2: i
                # t3: $l
                # t4: $r
                # t5: sum
                
                # De-marshall my inputs
                move $t1, $a0
                
                li $t5, 0               # int sum = 0;
        init:   nop                     # ;
                li $t2, 1               # int i = 1
                move $t3, $t2           # $l = i;
                move $t4, $a0           # $r = N;
        sam:    bgt $t3, $t4, done      # for(; $l < $r ;) {
        body:     nop                   #   ;  
                  add $t5, $t5, $t2     #   sum += i;
        next:     nop                   #   ;
                  addi $t2, $t2, 1      #   i++;
                  move $t3, $t2         #   $l = i;
                  move $t4, $t1         #   $r = $a0;
                b sam                   #   continue;
                                        # }
        done:   nop                     # ;
                move $v0, $t5           # return sum;
                jr $ra
                                