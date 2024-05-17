# ToDo:

1. [ ] validate the semantics of read_s
1. [ ] Document the flag --frame / -f for frames in mips_subroutine
1. [ ] Document the flag -a -b options 
1. [ ] Write a macro:  print_nibbles(value, start, stop)
       - simpler version to print_bits (shifts by 4)
       - potentialy:  print_digits(value, base, start, stop)
         * print_bits(value, start, stop) -> print_digits(value, 2, start, stop)
         * print_nibbles(value, start, stop) -> print_digits(value, 16), start, stop

1. [ ] Update print_register to use print_nibbles 
1. [ ] Update print_register, etc.,
       - to ensure appropriate size of output values
         * 32 digits for binary, 8 digits for hex, 10 digits for decimal


1. [ ] Build out the lib directory with other supporting operations
       * [x] strtol
       * [ ] sprintf, etc


1. [ ] Frames
   1. [ ] Review MIPS convention for subroutine calling...
      - [x] Create a small frames.md document
      - [x] Write macros for the MIPS approach
      - [x] Write/validate macros for a Dynamic Frame
      - [x] Write a MIPS subroutine that uses these macros
      - [ ] Update the process for Java subroutines
        - Deferred: only use ad-hoc frames
          * x = (int) fp[4];   -->  lw x, 16($fp)

1. [ ] Determine the finale names of: bootrap.s --> .bootstrap.s, MIPS_library.class -> .MIPS_library.class
1. [ ] Force ? the students to have the correct version of java, and only have MIPS_library.class in lib
1. [ ] mov MIPS_library.class to the lib directory

# Testing ToDo:

1. [ ] Validate adhoc frame examples for Java
1. [ ] Review all examples for different frame support
   * or just make sure they only use ad-hoc frames

1. [ ] Create test case for alloca and test

1. [ ] examples/echo4.s: 
     bug in core program


# Bugs ToDo:

1. [ ] ensure pop/push is able to work with strings
      * echo_list.j:16: error: incompatible types: int cannot be converted to char[]
      * value = mips.pop();

      ```
      $ pwd
      /Users/steve/repositories/mips_subroutine/examples/binaryReal/java
      dwarf:java steve$ make test_java
      2# 10011010010.01101110100111100001101 <- Correct output
      ./bootstrap.java:16: error: method pop in class MIPS_library cannot be applied to given types;
         arg4 = mips.pop(arg4);
                    ^
        required: no arguments
        found:    char[]
        reason: actual and formal argument lists differ in length
      ./bootstrap.java:192: error: incompatible types: Object cannot be converted to int
           digit = mips.pop();
                           ^
      2 errors
      make: *** [test_java] Error 1
      ```


      > Java is presumed to be JUST adhoc, old stuff stated
      > 1. Modify marshal on stack:  frames.s
      >    - to use the mips.pop / mips.push macros
      >    - modify to be for all three languages
      >    * This is changed based upon frames...
      >    * i.e., the args should not be pop, but read
      >      - x = fp(1)

1. [ ] Return type in java needs to be addressed

   > $ java_subroutine -R string caesar_cypher hello
   > ./bootstrap.java:58: error: incompatible types: int cannot be converted to char[] mips.println_s($v0);
   > Error: Subroutine caesar_cypher not declared as "public static int".
   > $ 

   Here, the return value needs to be copied ot MEM, and then printed out within main
   -- Example where java return values will be handled differently then mips_return values


# Enhancements ToDo:

1. [ ] add arrays as inputs
   - mips_subroutine  vector_add  4 [ 1 2 3 4 ]
      * an array of 4 is built, with a \0 after it

1. [ ]  add arrays as the only output
     ```
     $ mips_subroutine -R int[4] vector_add 4 [ 1 2 3 4 ] [ 1 2 3 4 ]
     2
     3
     6
     8
     ```

1. [ ] Revise inputs.md and README.md based upon  array intputs

1. [ ] Add the ability to have scientific notation for input

     34.23 E 34      # base 10
     0x34.23 P 344   # base 16 with base 10 exponent
     34.23 x 8^ 23 # base 8
       ==> 011 100 . 010 011 00 2^ 010 011
       ==> 1C.8C P 19   // is this correct
     16# 34.23 P 344 # base 16 with base 10 exponent
     16# 34.23 E 344 # does not make sense can't be both 16 and 10
 
1. [ ] Work on floating point support for subroutine calling (deferred)

1. [ ] Abililty to reference non-plain files
   ```
   $ java_subroutine examples/echo4 h 3 l o
   cat: echo4.j: No such file or directory
   ```

1. [ ] Send error messages within bootstrap.s to stderr f
   ```mips
        .macro print_error(%label)
            # Update this macro to print to stderr
            print_si(%label)
        .end_macro
    ```

1. [] Inconsistent reporting of line numbers:
    1. Java Error Consistency
     - Issue: a multi-file project may have invalid line numbers reported
     - approach:
       - make post processing read this line
         - // #line 888  "filename.s"

1. [] Build a c_subroutine version


#
 ToDo:



   1. -A -S change
      - S keep the same
      - A : pass the input arguments as an heterogeneous array 
        * use { a a a a a }
        * if the flag is given -- have it mimic the argv structure
          - which is realy just  5 [ "string" string string ]




## CLI Inputs
  
1. inputs overrides

   -R for return
   -A for input:  A for arguments
      -A string : all elements are forced to be strings
      -A argv   : use the standard argv struction
        ```
        a0: count
        a1: pointer to array of strings
        ```
      -A list   : this is argv but with  -->   [ a b c ]
        ```
          v0: count   like a system call
          a0: A[0] -->  a3: A[3]
          rest on the stack 
       ```
      0r
        ```
        -4($a0) The count of the array
        0($a0)  A[0]
        4($a1)  A[1], ...
        ```

   -S   --string : all elements are forced to be strings
     - this is just a short cut since you can override the duck rule

   -A   --argv ( string of string)
   defualt, looks like a duck its a duck  

   * refined input
     1. individual elements -- the default
     1. { ... }
     1. [ ... ]  : array, home,   size + elements
     1. Nope.. not allowed in shell -- ( ... )  : list, heter,   null   

   * modify java_subroutine to allowing array input

   * examples
     - mips_subroutine  entry [ one, two, three, \0 ]   
       * $a0 is the address of an array -- homgenours
     - mips_subroutine  entry { one two three }
       * $a0 is the address of a recored - hetergenous






# Documentation Notes

## Before and After
1. the --before  
   - must have knowledge of the entry subroutine
   - may ignore, or process the cl-args
   - must pass onto the entry subroutine what it needs

1. the --after
   - must have knowledge of what is left in registers after the call
   - may ignore or manipulate individual registers

   * Examples of ...
     - default:  print_register("$v0", $v0)
     - exit($v0)
     - print_register("$v0", $v0)
     - 
     - --after "call func arg1, arg, ... " # is okay
     - --after null                        # don't print print_register
     - --after "print_register($v0)"       # the default
     - --after "print_register.w($v0)"     # the default
     - --after "print_register.h($v0)"     # 
     - --after "print_register.b($v0)"     # 
     - 
     ```mips
        jal {entry}
        print_register($v0)
     ```
     - --after "print_register.s($f12)"
     - --after "print_register.d($f12)"
     - --after "print_s($v0)"
     - --after "print_register.dw($v1,$v0)"
     - --after "\t instruct1\n\t instruct2"
     - --after "print_t_registers()"
     - --after "print_register_map( bitfield )"

     - --after "mv $a0, $v0\njal post_filter"
     - mips_subroutine --before "jal pre_filter\nmove $a0, $v0"

   * for java_subroutine, user needs to provide the correct code




