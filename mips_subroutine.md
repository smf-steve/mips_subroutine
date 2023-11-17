### NAME
    mips_subroutine – execute a MIPS subroutine

### SYNOPSIS
    mips_subroutine [-A] [-S] [-L file ... ] [-s] [-r reg_list] [-t] [-v] name [ arg ... ]


### DESCRIPTION
    A MIPS subroutine is assemble and execute.  It is presumed that this subroutine is 
    defined within the file `name`.s, and has a label `name` which serves as the entry 
    point for code execution.  The subsequent command line arguments are processed and 
    then passed to as parameters to the subroutine `name`.

    Each of the `arg` values are passed to the subroutine the MIPS subroutine convention.
    That is to say the first 4 arguments are staged in $a0 - $a4 (for integers) or $f12
    and $f14 (for doubles), and subsequent arguments are positioned on top of the stack.
    The top of the stack holds the last argument.

    Each argument is converted, by default, to either an integer or a double, whenever
    possible. Otherwise, the argument is passed as a string. Command line options exist to
    override this default.
    
    After execution, the return value of the subroutine is printed on stdout. It is 
    presumed that this value is an integer.  Command line options exist to modify the 
    type of the output value.

    Two sets of command line options are available.  The first set, which are capitalized
    letters, are related to input.  Whereas the second set, which are lower case, are
    related to output.

### Command Line Options
    The following options are available to manage the input:

      -L : load/link the enumerated files to be part of the final program.  Note specifying 
           a directory causes all .s file to be linked in the final program.

      -S : converts each argument to a string. The address of each string
           is then stage in $a0 - $a3, and then onto the stack.

      -A : pass the input arguments as an heterogeneous array 
           - $a0: array.length
           - $a1: &array

      To mimic the argv structure, use the -A and -S argument together.


      -R type: specifies the return type from the subroutine.  The return value
         of the subroutine is emitted to stdout after the user output. The
         return types include:
           - none:    no return value is emitted
           - integer: an integer value (the value of $v0)
           - long:    a long integer value of (the value of $v1/$v0)
           - string:  a "string" 
            
         Future options include:
           - float:   a single precision real number (the value of $f0)
           - double:  a double precision real number (the value of $f0-$f1()

         Array data types are also support (the value of $v0 is the address of the array)
         (the value of $v1 needs to be the length of the array)
           - int[]:   an array of integers 
           - long[]:  an array of long integers
           - char[]:  an array of characters
           - float[]:  an array of single precision real numbers
           - double[]: an array of double precision real numbers

      -s : summarize the execution of the program 
           e.g., sub(1,2,3) returns $v0

      -r reg_list: dump the registers in the reg_list
        
          A reg_list is a comma separated list of registers numbers names,
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

    Alternatively the command `mars` must be located on your path.

### EXPECTION, LIMITATIONS and BUGS
    If an argument conforms to the syntax of a number, but is malformed,
    the shell will report an error and stop. For example,

       $ mips_subroutine func 4#456
       bash: 4#456: value too great for base (error token is "4#456")


### EXIT STATUS
    The mips_subroutine exits with the value of $v0 register.



