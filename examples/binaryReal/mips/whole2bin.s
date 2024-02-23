       .text
       .globl whole2bin
       .include "macros/syscalls.s"
       .include "macros/stack.s"

whole2bin:            # int whole2bin(int number);
        
        # a0 : number  # The value of number
        # v0 : 0       # The return value, which is zero

        # t0 : number      
        # t1 : n
        # t2 : b
        # t3 : count
        # t4 : r
   
        push_s_registers()         # Save S registers
        move $t0, $a0              # Demarshal input arguments
        

        move $t1, $t0            # int n = number; 
        li $t2, 2                # int b = 2;
        li $t3, 0                # int count = 0;
        li $t4, 0xDEADBEEF       # int r = 0xDEADBEEF;

 spot:  beq $t1, $zero, rover    #     for  (; n != 0 ;) {
 body:    nop                    #       ;  
          div $t1, $t2           #       (r, n) = n / b;
          mfhi $t4
          mflo $t1

          push($t4)              #       mips.push(r);
          addi $t3, $t3, 1       #       count = count + 1;
        b spot                   #       continue spot;
                                 #    }
 rover: nop                      #    ;
 apple: ble $t3, $zero, core     #    for ( ; count > 0 ;) {
          pop($t4)               #      r = mips.pop();
          print_d($t4)           #      mips.print_d(r);
          subi $t3, $t3, 1       #      count = count - 1;
        b apple                  #      continue apple;
                                 #    }
 core:  nop                      #    ;
        
       move $v0, $t1             # Marshal return value
       pop_s_registers()         # Restore S registers

       jr $ra

