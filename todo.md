Validate the semantics of read_s

# ToDo:

1. [x] Bugs:
   - 0b00100100 as a command line arg
     * ../java_subroutine: line 1149: 0b00100100: value too great for base (error token is "0b00100100")

1. Bug:
   - pop needs to be able to work with strings...
     * echo_list.j:16: error: incompatible types: int cannot be converted to char[]
     value = mips.pop();

1. [x] Bug:
   - MIPS_OS_Interface.{java,class} is force to be in COMP122_BIN

1. Write: 
   - sum_list.s
   - echo_cat_list.{j,s}

1. Cleanup README.md in examples after further along

1. io.s --> MIPS_OS_INTERFACE


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
 

## Output
1. v0 output is inconsistent when faced with large negative numbers
   - need to printf with a specific size for the first decimal number
   - obtain the code from mips_cli


## MIPS Processing

1. MIPS Macros  // MIPS_OS
   Modify marshal on stack
     - to use the mips.pop / mips.push macros
     - modify to be for all three languages

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
   - print_register($t1)
   - print_registers(bitfield)
   - print_registers.s(bitfield)
   - print_registers.d(bitfield)

   - null: do I still need a blank line for the ouptut in mips-subroutine
   - print_quoted_s($v0)
     - prints "{the string pointed to $v0}"

## Test Cases:
  1. examples/echo4.s: 
     bug in core program

## C processing
1. write: build_c_source

--

  
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


   * examples
     - mips_subroutine  entry [ one, two, three, \0 ]   
       * $a0 is the address of an array -- homgenours
     - mips_subroutine  entry { one two three }
       * $a0 is the address of a recored - hetergenous



## Bugs



# Notes found elsewhere... need to review
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

mips_subroutine 

  --after program.s   .... this must be called with the program to have access to memory.

   ```mips
   jal main
   jal post_filter
   ```
   yes, share registers

rather than marshalling arguements..
  just presume the subroutine has access to all the registers as is..

1. --after and --before option
   - mips_subroutine --after post_filter  main 1 2 3 4
     -- register share is allowed ?
     ```mips
     jal main
     mv $a0, $v0
     jal post_filter
     ```

   - mips_subroutine --before pre_filter main 1 2 3 4
     -- register share is allowed ?
     ```mips
     jal pre_filter     # pre_filter is effectively entry
     mv $a0, $v0
     jal main           # main is effectively --after
     ```
  - do you need to do both..
     ```
     jal pre_filter     # pre_filter is effectively entry
     mv $a0, $v0
     jal main           # main is effectively --after
     mv $a0, $v0
     jal post_filter
     ```

1. reframe output flags
   - v : v0 & v1
   - t : dumpt t registers (special case of)
   - r : dump list of registres
   - s : summarize  "value = name ( arg, ... ) "

   * each can be handled by a --after
   * make the default to be
     - exit($v0)
     - print_register($v0)
     after must be a macro
     --after call func arg1, arg, ...  # is okay
     --after null                      #  don't print print_register
     --after "print_register($v0)"     # the defualt
     --after "print_register.w($v0)"   # the defualt
     --after "print_register.h($v0)"   # 
     --after "print_register.b($v0)"   # 
       ```mips
       jal {entry}
       print_register($v0)
       ```
     --after "print_register.s($f12)"
     --after "print_register.d($f12)"
     --after "print_s($v0)"
     --after "print_register.dw($v1,$v0)"
     --after "\t instruct1\n\t instruct2"
     --after "print_t_registers()"
     --after "print_register_map( bitfield )"

     No need for these to be written for Java / C 

     - dump all the afters to...  entry.after
     - leave stdout and stderr to the program

1. the --before  
     - must have knowledge of the entry subroutine
     - may ignore, or process the cl-args
     - must pass onto the entry subroutine what it needs

1. -A -S change
   - S keep the same
   - A : pass the input arguments as an heterogeneous array 
     * use { a a a a a }
     * if the flag is given -- have it mimic the argv struction
       - which is realy just  5 [ "string" string string ]


1. move:   #  1. validate param passing conventions 
   to inside the subroutine... print to stderr entry.blay

1. Files

   subroutine entry 1 2 3 4
      - entry.stdout: users stdout
      - entry.stderr: users stderr
      - entry.after:  output for the "after routine"
      - boot.s:  boot file that calls entry, etc
