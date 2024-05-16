1. update OS_INTERFACE to include macros


# ToDo:
1. [x] Rework the syscall macros to be register preserving
       - potentially
         - move syscalls to xxx
         - make \_print  that does not preserve registers

1. [ ] Document the flag --frame / -f for frames in mips_subroutine

1. [ ] Work on floating point support for subroutine calling (deferred)


1. [ ] For to mips/include/syscalls.s and Java OS Inteferace: add the  following routines, or move these to io.s

Issue with namespace...
  Students will need to creat strtol....
  Do I ned to call with this i_strtol, i for internal

1. [ ] Create test case for alloca and test

1. [] Review all examples for different frame support
   -- or just make sure they only use ad-hoc frames

1. [x] Modify println_register to print like
      - $v0         0           0x0000 0000  0b0000 0000 0000 0000 0000 0000 0000 0000
      and not
      - $v0         0           0x00000000  00000000000000000000000000000000



# Bugs:

dwarf:examples steve$ java_subroutine -R string caesar_cypher hello
Error: Subroutine caesar_cypher not declared as "public static int".
dwarf:examples steve$ 




## MIPS_subroutine
   - [ ] create a makefile to drive testing of examples
   - [ ] ensure examples test all current input types
     * to validate the change in char verse string
   - [x] write macros associate with printing arrays
     - print_c(reg, count)
   - [ ] rewrite print_register

   - [x] add the --after for print out
     - print_x
     - print_ax

  - add arrays as inputs
    - mips_subroutine  vector_add  4 [ 1 2 3 4 ]
      * an array of 4 is built, with a \0 after it

  - add arrays as the only output
     ```
     $ mips_subroutine -R int[4] vector_add 4 [ 1 2 3 4 ] [ 1 2 3 4 ]
     2
     3
     6
     8
     ```


1. Review and Conform files within ./include
   1. [ ] io.s --> MIPS_OS_INTERFACE
   1. [ ] stack.s --> ensure pop/push is able to work with strings
      * echo_list.j:16: error: incompatible types: int cannot be converted to char[]
      * value = mips.pop();
   1. [ ] println_binary32
      - [ ] mips:
      
      - [ ] java:
   1. validate the semantics of read_s

   1. Modify marshal on stack:  frames.s
      - to use the mips.pop / mips.push macros
      - modify to be for all three languages
      * This is changed based upon frames...
      * i.e., the args should not be pop, but read
        - x = fp(1)

    1. create support macros in MIPS_OS_INTERFACE for 
       - print_registers(...)

1. CLI
   1. [x] add the --after, --before ability, -a & -b

   1. [ ] Define / Validate Environment variables for CLI options
      -  {BEFORE}, {AFTER}, etc

   1. -A -S change
      - S keep the same
      - A : pass the input arguments as an heterogeneous array 
        * use { a a a a a }
        * if the flag is given -- have it mimic the argv structure
          - which is realy just  5 [ "string" string string ]


1. CLI Output
   1. v0 output is inconsistent when faced with large negative numbers
      - need to printf with a specific size for the first decimal number
      - obtain the code from mips_cli

   1. [ ] java:  update to handle -R code generation
      - ? should the default --after be:  print_register($v0) based upon type


1. Bootstrap
   - [x] cleanup the post processing, etc. 

1. Test Cases
   1. [ ] Write: 
      - sum_list.s
      - echo_cat_list.{j,s}

1. Documentation 
   1. [ ] Cleanup README.md in examples after further along



1. Frames
   1. [ ] Review MIPS convention for subroutine calling...
      - [x] Create a small frames.md document
      - [x] Write macros for the MIPS approach
      - [x] Write/validate macros for a Dynamic Frame
      - [x] Write a MIPS subroutine that uses these macros
      - [ ] Update the process for Java subroutines
        - Deferred: only use ad-hoc frames
          * x = (int) fp[4];   -->  lw x, 16($fp)

   1. Should the main Java program always return $v0
      - yes, it should be via the exit...
      - it is what it is... 
      - -R defines out to print out the value that is requested

   ```
   $ java_subroutine sum_list 5 1 1 1 1 1 1 
   sum_list.j:43: error: cannot find symbol
      mips.println_register("$v0", $v0);
          ^
    symbol:   method println_register(String,int)
    location: variable mips of type MIPS_OS_Interface
  1 error
  ```




## Command Line Arguments

1. Put in a check for illegal escape sequences
   ```
   $ java_subroutine binaryReal 10 "\#"  1234 "." 4321
   binaryReal.j:36: error: illegal escape character
       String string_1 = "#";
   ```
   Notice that the "\#" is placed into the generated java code
   But the java compile does not emit it correctly in its output
   The code is doing the right thing.
   Just the error message is not good, but its a javac thing

1. calling java_subroutine using a non-plain file
   ```
   $ java_subroutine examples/echo4 h 3 l o
   cat: echo4.j: No such file or directory
   ```

1. Add the ability to have scientific notation for input

     34.23 E 34      # base 10
     0x34.23 P 344   # base 16 with base 10 exponent
     34.23 x 8^ 23 # base 8
       ==> 011 100 . 010 011 00 2^ 010 011
       ==> 1C.8C P 19   // is this correct
     16# 34.23 P 344 # base 16 with base 10 exponent
     16# 34.23 E 344 # does not make sense can't be both 16 and 10
 

## Enhancements:

1. [ ] Use of Stderr for I/O
   ```mips
        .macro print_error(%label)
            # Update this macro to print to stderr
            print_si(%label)
        .end_macro
    ```

## MIPS Processing


## Java Processing
  1. Java Error Consistency
     - Issue: a multi-file project may have invalid line numbers reported
     - approach:
       - make post processing read this line
         - // #line 888  "filename.s"


  1. update build_java_source -- this is cleanup work
     - to call marshal in registers
     - to call marshal on stack


## Macro Definitions

1. Add the following macros
   - println_register("name", reg)
   - println_registers("name", $v0)
   - println_registers("name", $v0, $v1)
   - println_registers("name", bitfield)  # This presents a problem because we need names
   - println_registers.s("name", bitfield)
   - println_registers.d("name", bitfield)

   - null: do I still need a blank line for the ouptut in mips-subroutine
   - print_quoted_s($v0)
   - println_quoted_s($v0)
     - prints "{the string pointed to $v0}"

## Test Cases:
  1. examples/echo4.s: 
     bug in core program

## C processing
1. write: build_c_source

--


## CLI Inputs
  
1. inputs overrides
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






# Unit Test with output validation
Need a way to have an validate the output of mips_subroutine
perhaps this is not part of mips_subroutine but a supporting program.
Consider driving this functionality for a JSON object

{
  subroutine: name,
  description: ,
  test_case: 
     {
       input:  %filename
       output: [ command ]
          # command to validate output
          # it expects to take from stdin the outputfile
          # e.g.,  diff filename -
       
  argument: []
  return: [ ]
  after: [ ]

}


# File Support

1. FILES:  Add additional support to handle i/o Files from the user
   - this now might not be necessary given the way --after & --before works
   - this needs to be flushed out.

   - example:  mips_subroutine $entry 1 2 3 4
      - boot.s:  boot file that calls entry, etc
      - $entry.stdout: the file that contains the users stdout
      - $entry.stderr: the file that contains the users stderr
      - ~$entry.after:  output for the "after routine"~
        * this presume that it is a routine..
        * the routine should held this file output


# Documentation Notes

## Before and After
1. the --before  
   - must have knowledge of the entry subroutine
   - may ignore, or process the cl-args
   - must pass onto the entry subroutine what it needs

1. the --after
   - must have knowledge of what is left in registers after the call
   - may ignore or manipulate individual registers

1. Recipes:  we can always add "quick - recipes" to simplify any of the following
   1. -v : print_registers($v0, $v1)
   1. -t : print_registers($t0, ..., $t9)
   1. -r : print_registers( list of registers )

   * consider -after token
     - if [[ -f token.s ]]
       * include token.s
       * jal token
     - uses shared variables for whatever it wants


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


## Frames

1. Add Frames for Java
   - [ ] write the series of macros of mips.set_frame, etc. 
      - set_frame
      - mips.fp = mips.sp
   - [ ] arg_4 =  mips.STACK[ mips.$fp + 4 + 1];
