### NAME
    mips_sub – execute a MIPS subroutine

### SYNOPSIS
    mips_subroutine [-A] [-S] [-s] [-r reg_list] [-t] [-v] name [ arg ... ]


### DESCRIPTION
    The file `name`.s that contains the subroutine `name` is executed.

    Each of the `arg` values are passed to the subroutine following
      the MIPS subroutine convention. That is to say the first 4
      arguments are staged in $a0 - $a4 or $f12 and $f14, and 
      subsequent arguments are positioned on top of the stack. 
      The top of the stack holds the last argument.

    Each argument is converted to either an integer or a double, 
      when possible. The argument is then passed as either an 
      integer, a double, or the address of the corresponding string.
    
    After execution, the return value of the function is printed on 
      stdout. It is presumed that this value is an integer.

    The following options are available. The associated output for
      options are placed on stdout after any output from the subroutine.


      -A : pass the input arguments as an array 
           - $a0: array.length
           - $a1: &array

      -S : pass all input arguments as strings
           - the default is to convert each argument when possible

      -R type: specifies the return type from the subroutine.  The return value
         of the subroutine is emitted to stdout after the user output. The
         return types include:
           - none:    no return value is emitted
           - integer: the value of $v0 (default)
           #- long:    the value of $v1/$v0
           #- float:  the value of $f0
           - double:  the value of $f0-$f1
           - string:  the "the string"

      -s : summarize the execution of the program 
           e.g., sub(1,2,3) returns $v0

      -r reg_list: dump the registers in the reg_list
        
          a reg_list is a comma separated list of registers numbers names,
          a range may also be provided.
          Examples:
           * -r s0,s2,t1-t5,f2
           * -r 16,18,9-15,f2

      -t  : dump the $t0 - $t9 registers 
      -v  : dump the $v0 and $v1 registers 


 ### WARNINGS
     It is expected that the subroutine follows the MIPS convention
     regarding the restoration of registers. As such, the following
     messages may appear on stderr.

   * Warning: One or more of the S registers were not restored.
   * Warning: The $fp register was not restored.
   * Warning: The $sp register was not restored.
   * Warning: Subroutine did not return properly"

### ENVIRONMENT_VARS
    The following environment variables affect the execution of mips_subroutine:

    MARS_JAR:  The location of the Mars jar file
    MARS:      The base command to invoke the Mars

### EXPECTION, LIMITATIONS and BUGS
    If an argument conforms to the syntax of a number, but is malformed,
    the shell will report an error and stop. For example,

       $ mips_subroutine func 4#456
       bash: 4#456: value too great for base (error token is "4#456")

    Any output from the user subroutine should ensure a newline ('\n') is the last
    character printed. 

    This ensures the return value of the function is printed 
    properly.  (This is fixed)

### EXIT STATUS
    The mips_subroutine exits with the value of $v0 register.


#### Status
  - floats are not handled
  - -r ranges not implemented
  - -R not implemented

