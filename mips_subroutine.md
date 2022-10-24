#### Status
  - floats are not handled

### NAME
    mips_sub – execute a MIPS subroutine

### SYNOPSIS
    mips_subroutine [-S] [-s] [-d] [-t] [-v] name [ arg ... ]


### DESCRIPTION
    The file `name`.s that contains the subroutine `name` is excuted.

    Each of the `arg` values are passed to the subroutine following
      the MIPS subroutine convention.  That is to say the first 4
      arguments are staged in $a0 - $a4 or $f12 and $f14, and 
      subsequent arguments are positioned on top of the stack. 
      The top of the stack holds the last argument.

    Each argument is converted to either an integer or a double, 
      when possible. The argument is then passed as either an 
      integer, a double, or the address of the corresponding string.
    
    The following options are available. The associated output for
      options are placed on stdout after any output from the subroutine.


      -A : pass the input arguements as an array of strings
           - $a0: argc
           - $a1: &argv

      -S : pass all input arguments / elements as strings

      -s : summarize the execution of the program 
           e.g.  sub(1,2,3) returns $v0

      -r reg_list: dump the registers in the reg_list
        
          a reg_list is a comma separted list of register numbers
          or register names, a range may also be provided.
          Examples:
           * -r s0,s2,t1-t5,f2
           * -r 16,18,9-15,f2

      -t  : dump the $t0 - $t9 registers 
      -v  : dump the $v0 and $v1 registers 


 ### WARNINGS
    It is expected thea the subroutine follows the MIPS convention
    regarding the restoration of registers.  As such, the following
    messages may appear on stderr.

   *  Warning one or more of the S registers were not restored.
   *  Warning the $fp register was not restored.
   *  Warning the $sp register was not restored.

### EXPECTION and BUGS
    It is expected that the subroutine performs an appropriate
    return.  Otherwise, the options that produce output will
    not occur. 

    If an arg conforms to the syntax of a number, but is malformed,
    the shell will report and error and stop. For example,

       $ mips_subroutine func 4#456
       bash: 4#456: value too great for base (error token is "4#456")

### EXIT STATUS
    The mips_subroutine exits with the value of $v0 register.


