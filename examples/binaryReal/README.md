# Exam #4: Conversion Binary Real

This programming assignment is serving as your Exam #4.  


## Overview:

We can represent any real number in any base using sharp notation. Consider the following examples, which all represent the decimal number: `198.5`,

```bash
10#  198.5
8#   306.4
16#  C6.8
2#   1100 0110 . 1000
```
In this assignment, you are to write a MIPS program, binaryReal, that takes a real number, provided via sharp notation, and presents it as a binary real number -- also using sharp notation.

The program is provided with five command-line arguments that represent the five components of a real number written in sharp notation.  Consider the real number, `10#  198.5`.  The five components of the number are:

  |  Name        |  Value   | Description                  |
  |:-------------| --------:|------------------------------|
  |  base        |  10      | The base of the number       |
  |  sharp       |  #       | The sharp (hash) symbol      |
  |  whole       |  198     | The whole number component   |
  |  point       |  .       | The radix point              |
  |  fractional  |  5       | The fractional component     |

Each of these values are provided to the program as strings. The following demonstrates the use of your program. (Note that program also returns the value of the radix of the input number.)

   ```bash
   $ mips_subroutine -L . -S binaryReal 10 "#" 198 . 5 
   2# 11000110.1
   #########################################
   # Above is the output from your program
   #########################################
   
   v0:         10; 0x00 00 00 0A; 0b0000 0000 0000 0000 0000 0000 0000 1010;
   ```

The program is structured with the following files:

  * `strtol.{j,s}`: a refactored version of your nextInt method 
  * `whole2bin.{j,s}`: a method that converts a base10 integer to binary
  * `fractional2bin.{j,s}`: a method that converts base10 fractional value to binary
  * `binaryReal.{j,s}`: a driver method provided by the Professor
  * `strtofrac.{j,s}`: a conversion method provide by the Professor


As with previous assignments in COMP122, you are:
  1. to write the necessary code in Java
  1. to rewrite your Java code using the Java-TAC style
  1. to transliterate your Java-TAC code into MIPS

In short, you will be writing this program three times.  There is a separate subdirectory for each of your three programs: java, java_tac, and mips, respectively.

To start off, focus your attention on just writing the Java code.

   1. Review the code provided by the Professor.  The Professor's code, while also saving you time on this project, provides you with another set of examples that can guide you in your development work.

   1. Refactor your "nextInt" method to confirm to the following spec:
      - API: public static int strtol( char[] buffer, int radix);
      - Description: strtol is function associated with the C standard library.  It converts the string contained with the buffer to a long (integer) within the given base (radix).
      - Discussion: To refactor your nextInt method you mus
        1. Change the API of the method that includes the buffer as a parameter
        1. Remove the call to read_s(buffer)


   1. Review the slides on conversion between bases, as well as the 25-binary-addition assignment.

   1. Use the pseudo code provided on the slides, also presented here, to write the following two methods:
      1. public static int whole2bin(int whole);
         ```pseudo_code
         number = whole;
         while (number != 0) {
           push ( number % 2 )
           number = number / 2
         }
         pop_all();
         ```

      1. public static int fractional2bin(int fractional, int max_bits);
         ```pseudo_code
          max = 10 ** stringlength(fractional);
          number = fractional;
          while (number != 0 ) {
              number = number * 2 
              if ( number > max ) {
                 emit 1
                 number = number - max
              } else {
                 emit 0
              }
         }
         ```

         - max_bits is provided as a way to exit the loop if the number does not converge to zero.

         - a method called `int value_of_max(int n);` is provided to calculate the value of `max`, which is used within the pseudo code.


## Tasks:

### Task 0: Software Development and Configuration Management Process
   1. Remember to follow the incremental development process
   1. Remember to iteratively:
      * Edit your code
      * Test your code
      * Commit your code

   1. Use the following commands to perform unit testing
      ```
      $ java_subroutine strtol "198\0" 10
      $ java_subroutine whole2bin 198 
      $ java_subroutine fractional2bin 1234 23
      ```

   1. Use the make command to speed up and double check your work
      ```bash
      $ make
      Missing java_code tag
      Missing java_tac_code tag
      Missing mips_code tag
      You need a minimum of 20 commits
      make: [number_commits] Error 1 (ignored)

      "make test_java" to test your current version of binaryReal.j
      "make test_mips" to test your current version of binaryReal.s
      "make final" to test all your final versions of binaryReal.*
      "make validate" to validate your final submission
      ```

### Task 1: Write your three methods in Java.
   1. Change your working directory to the "java" subdirectory.
   1. Create the file the strtol.j to include your nextInt.j code.
   1. Refactor your `nextInt` method to be `strtol`.
   1. Create the file whole2bin.j that contains the associated method.
   1. Create the file fractional2bin.j that contains the associated method.
   1. Include the following code into fractional2bin.j
      ```java
      public static int value_of_max(int number) {

         int max;
      
         max = 10;
         for (int i=0;  number >= max ;i++) {
            if( i > 8) break;
            max = max * 10;
         }
         return max;
      }
      ```
   1. Perform appropriate unit testing.
   1. Test your binaryReal program.
   1. Tag your final commit from this section with the tag: java_code.
      ```bash
      git tag java_code      # To create your tag
      git tag -f java_code   # To move your tag after you discovered...
      ```

### Task 2: Rewrite your three methods using the Java-TAC style.
   1. Change your working directory to the "java_tac" subdirectory.
   1. Create the file strtol.j to include your nextInt.j code.
   1. Refactor your `nextInt` method to be `strtol`.
   1. Create the file whole2bin.j that contains the associated method.
   1. Create the file fractional2bin.j that contains the associated method.
   1. Include the following code into fractional2bin.j
      ```java
      public static int value_of_max(int number) {

               int _8;
               int _10;
      
               int max;
               int i;
      
               _8  =  8;
               _10 = 10;
      
               max = 10;
               i   =  0;
      
      loop2:   for (; number >= max ;) {
                  if( i > _8) break loop2;
                  max = max * _10;
                  i++;
                  continue loop2;
               }
      done2:   ;
               return max;
      }
      ```

   1. Perform appropriate unit testing.
   1. Test your binaryReal program.
   1. Tag your final commit from this section with the tag: java_tac_code.
      ```bash
      git tag java_tac_code      # To create your tag
      git tag -f java_tac_code   # To move your tag after you discovered...
      ```

### Preparation to Task 3. 
As part of Task 3, you need to ensure that your MIPS subroutines confirm to the MIPS calling convention.  Consider the following pseudo-code that outlines this process.

  1. Subroutine Construction
     ```java
     public static int method( ... ) {

        // Code

     return x;
     }
     ```

     -->

     ```mips
            .text
            .globl method

     method: nop
             # Save S registers
             # Demarshal input arguments

             # // Code

             # Marshal return value
             # Restore S registers
             jr $ra
     ```
    
  1. Subroutine Invocation:
     ```java
     x = method( ... );
     ```

     -->

     ```mips
           # Marshal arguments
           # Save T registers
           # Save special purpose registers

           jal method

           # Restore special purpose registers
           # Restore T registers
           # Demarshal return value
     ```

     You should already be well acquainted with how to marshal and demarshal arguments.  To save and restore registers, you can use the `push` and `pop` macros included in the "macros/stack.s" file.  You may also use the following macros:

      - push_t_registers()
      - pop_t_registers()
      - push_s_registers()
      - pop_s_registers()

### Task 3. Transliterate your Java-TAC code int MIPS

   1. Change your working directory to the "mips" subdirectory.
   1. Create the file strtol.s to include your nextInt.s code.
   1. Refactor your `nextInt` method to be `strtol`.
      - modify both the nextInt and glyph2int subroutines to conform to the MIPS subroutine calling convention.

   1. Create the file whole2bin.s that contains a copy of your whole2bin.j method
      - Transliterate (line by line) your whole2bin method into MIPS
      - Ensure the subroutine conforms to the MIPS subroutine calling convention

   1. Create the file fractional2bin.s that contains a copy of your fractional2bin.j method
      - Transliterate your fractional2bin method into MIPS
      - Ensure the subroutine conforms to the MIPS subroutine calling convention

   1. Include the following code into fractional2bin.s
      ```mips
      
             .globl value_of_max
              
      value_of_max: nop               #  public static int value_of_max(int       number) {
              # t0: number
              # t1: max               # int max;
              # t2: i                 # int i;
              # s0: 8                 # int _8;
              # s1: 10                # int _10;
            
              push_s_registers()      # Save S registers
              move $t0, $a0           # Demarshal input arguments
            
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
      ```

   1. Consider the following code equivalents for use in your program:

      -  x = n * 2  ==  x = n << 1
      -  x = n / 2  ==  x = n >>> 1
      -  x = n % 2  ==  x = n & 1   

   1. Perform appropriate unit testing.
   1. Test your binaryReal program.
   1. Tag your final commit from this section with the tag: mips_code.

      git tag mips_code      # To create your tag
      git tag -f mips_code   # To move your tag after you discovered...


### Task 4. Perform Final Testing
  Now that you have complete the assignment and have already performed extensive testing, it is time to do final testing.

   1. Change your working directory to the top-level directory.

   1. Utilize the following to make command to test your final set of code for submission:
      ```bash
      make final_java_code
      make final_java_tac_code
      make final_mips_code
      ```

   1. Make appropriate adjustments to your code and your tags, as needed!


### Task 5: Validation Final Submission

   1. Prior to your final submission to the repository, run the `make final` command to test the three versions of your 'binaryReal' method/subroutine.

   1. If you were careful and diligent with the steps above, all should be good.  If not make the necessary adjustments.

   1. If you are ready for your final commit, run the following commands:

      ```bash
      make final
      make validate
      git push
      git push --force --tags   # Force the updates of tags -- just in case
      ```
###  Task 6: Are you sure?

If you are not sure if the code you submitted is 100% correct you can run the following code to provide you with some assurances.

  ```bash 
  git clone $(git config remote.origin.url) prof-version
  cd prof-version
  make final
  ```

Note that it clones your code to a new directory, and executes the `make final` command.
