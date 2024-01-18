# io.s
# an additional set of compond macros
# 
# Print a value that is in a register  (see syscalls.s)
#   -  print_<type>(%reg)
# Print the value with a newline at the end..
#   - printnl_type
# Print an array of values
#   - printnl_<type>(%reg, %count)


.macro  printnl_d(%reg)
        print_d (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_di(%imm)
        print_di(%imm)
        print_ci('\n')
.end_macro

.macro  printnl.s(%reg)
        print.s (%reg)
        print_ci('\n')
.end_macro

.macro  printnl.d(%reg)
        print.d(%reg)
        print_ci('\n')
.end_macro

.macro  printnl_f(%reg)
        print_f (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_s(%reg)
        print_s (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_si(%label)
        print_si(%label)
        print_ci('\n')
.end_macro

.macro  printnl_c(%reg)
        print_c (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_ci(%imm)
        print_ci(%reg)
        print_ci('\n')
.end_macro


.macro  printnl_x(%reg)
        print_x (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_xi(%imm)
        print_xi(%reg)
        print_ci('\n')
.end_macro


.macro  printnl_t(%reg)
        print_t (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_ti(%imm)
        print_ti(%reg)
        print_ci('\n')
.end_macro

.macro  printnl_u(%reg)
        print_u (%reg)
        print_ci('\n')
.end_macro

.macro  printnl_ui(%imm)
        print_ui(%imm)
        print_ci('\n')
.end_macro



# Array Macros
.macro printnl_d(%array, %count)
            nop  # printnl_d
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count            # count = count
            li $t2, 0                 # counter = 0 
  top:      beq $t2, $t1, done        # if (counter == count) break
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_d($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro printnl.s(%array, %count)
            # Not Implemented!
.end_macro

.macro printnl.d(%array, %count)
            # Not Implemented!
.end_macro

.macro printnl_s(%array, %count)
            nop  # printnl_s
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0
  top:      beq $t2, $t1, done        # if (counter == count) break
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_s($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro printnl_c(%array, %count)
            nop  # printnl_c
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0
  top:      beq $t2, $t1, done        # if (counter == count)
              add $t3, $t0, $t2       # addr = %arr + counter
              lb $t3, 0($t3)          # value = MEM[addr]
              print_c($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro printnl_x(%array, %count)
            nop  # printnl_x
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      beq $t2, $t1, done        # if (counter == count)
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_x($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro printnl_t(%array, %count)
            nop  # printnl_t
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      beq $t2, $t1, done        # if (counter == count)
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_t($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro printnl_u(%array, %count)
            nop  # printnl_u
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      bge $t2, $t1, done        # while (counter < count)
              sll $t3, $t2, 2         #   offset = counter * 4
              add $t3, $t0, $t3       #   addr = %arr + offset
              lw $t3, 0($t3)          #   value = MEM[addr]
              print_u($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro


.macro printnl_register( %name, %reg )
         .data
str:     .asciiz %name
         .text
         print_si(str)
         print_ci('\t')
         print_d(%reg)
         print_ci('\t')
         print_x(%reg)
         print_ci('\t')
         print_t(%reg)
         print_ci('\n')
.end_macro



# The above, presumes that each value is in a word -- except print_c
# Consider adding the size of the element if it is for arrays
#
# Register versions:
# print_x(v)  === print_wx(v)
#   print_wx(v)  -- don't provide, the default is word
#   print_hx(v)  -- don't provide, user required to ensure butes 4, 3, are zer
#   print_bx(v)  -- don't provide, user required to ensure bytes 4, 3, 2 are zero
#
# Array Versions
#   print_wx(v, c)   -- don't provide, its. the default
#   print_hx(v, c)   -- limitations, not implemented
#   print_bx(v, c)   -- okay provide some
# 
# Special case
#   print_c(v, c)  !==  print_wc(v, c)
#   print_c(v, c)  ===  print_bc(v, n)

# // .macro printnl_a*   arra  y of words of such things
# // .macro print_w*   array   of words of such thingst1 // .macro print_h*   array   of halfs of such things
# // .macro print_b*   array   of bytes of such thit1s
#   t1/  -R byte[]       lb
#   1//  -R half[]     lh
#    //  -R word[]   
# 
# $t1   



####### READ Macros
# some of these are to demostrate what the sycalls do within it.
## 
## # Thes are reading ascii data of a type from stdin
## read_byte_[tx]
## read_half_[tx]
## read_word_[tx]
## 
## # These are just reading binary data from file
## read_byte[_fd]
## read_half[_fd]
## read_word[_fd]
## 
## 
## # Support macros
## read_glyphs %num %type
## unpack %imm
## 
## 
## .macro read_byte()
##    read_byte(0)
## .end_macro
## 
## .macro read_byte_fd(%imm)
##    read(%imm, short_buff, 1)
##    tnei $v0, 1 
##    lb $v0, short_buff
## .end_macro
## 
## .macro read_half()
##    read_half_fd(0)
## .end_macro
## 
## .macro read_half_fd(%imm)
##    read(%imm, short_buff, 2)
##    tnei $v0, 2
##    unpack  2
## .end_macro
## 
## .macro read_word()
##   read_word_fd(1)
## .end_macro
## 
## .macro read_word_fd(%imm)
##    read(%imm, short_buff, 4)
##    tnei $v0, 4
##    unpack 4
## .end_macro
## 
## 
## 
## .macro unpack_2()
##    lb $v0, short_buff
##    lb $v1, short_buff +1
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
## .end_macro
## 
## .macro unpack_4()
##    lb $v0, short_buff +0    ## Load the first byte
##    lb $v1, short_buff +1        ## Load the second byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
##    lb $v1, short_buff +2        ## Load the third byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
##    lb $v1, short_buff +3        ## Load the third byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
## .end_macro
## 
## 
## 
## 
## read_byte_t
##    read_glyphs(8, 't')
## read_byte_x
##    read_glyphs(2, 'x')
## 
## read_half_t
##     read_glyphs(16, 't')
## 
## read_half_x
##     read_glyphs(4, 'x')
## 
## read_word_t
##     read_glyphs(32, 't')
## 
## read_word_x
##     read_glyphs(8, 'x')
## 
## 
## read_glyphs (num_glyphs)
##          value = 0;
##    loop: for (i=0; i < num_glyphs; i++) {
##            read_c();
##            x = retval();
##            
##            // skip over punch
##      punc: do { 
##              switch (x) {
##                case ' ':
##                case '|':
##                case '-':
##                case ':':
##                case '\n':
##                case '\t':
##                   read_char()
##                   x = retval;
##            continue punc;
##          }
##             }
## 
##      switch (%type) {
##          case 't':  
##            switch(x) {
##               case '0':
##               case '1':
##                   value = value << 1 + (x - '0');
##                   break glypy;
## 
##               default:
##                   teq $zero, $zero
##              }
##              break;
##          
## 
##          case 'x':
##            do { 
##               value = value << 4
##               test = index_within_range(x, '0', '9')
##               if test != -1 {
##                  value = value + ( x - '0')
##                  break;
##               }
## 
##               test = index_within_range(x, 'a', 'f')
##               if test != -1 {
##                  value = value + 10 + ( x = 'a')
##                  break;
##               }
##               test = index_within_range(x, 'A', 'F')
##               if test != -1 {
##                  value = value + 10 + ( x = 'A')
##                  break;
##               }
##               teq $zero, $zero
##             } while (false);
##             break;
##         }
##         return value;
##    }
## 
## 
##  
## ```mips
## .macro read_x()
##         .data 
## buff:   .space 5
##         .text
## 
##         read_s(buff, 5)
##         value = 0;
##         for (i=0; i<5; i++) {
##            digit = buff[i];
##            if (digit == '\n') break;
##            if (digit == '\0') break;
## 
##            position_in_range(digit, '0', '9');
##            digit = $v0;
## 
##            if (digit < 0) {
##              # Handle Hex...
## 
##              position_in_range(digit, 'a', 'f');
##              digit = $v0 + 10;
##            } else {
##              position_in_range(digit, 'A, 'F')
##              digit = $v0 + 10;
##            }
## 
##            if ($v0 < 0) break;
## 
##            value = value << 4;
##            value = value + digit;
##         }
##         return value;
## 
## 
## 
## 
##         li $at, 0                            #  value = 0;
##         li $v0, 0                            #  $v0 = 0;
## top:    nop                                  #  do { 
##           sll $v0, $v0, 4                    #    value = value << 4;
##                                              #    $v0 = $v0 - '0'
##           add $at, $at, $v0                  #    value = value + $v0;
##           li $v0, 11                         #    read_c();
##           syscall                           
##         bne $v0, '\n', top                   #  while ( $v0 != '\n');
##         
## .end_macro
## ```



