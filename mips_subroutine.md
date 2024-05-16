-f frame  
only ad-hoc or unspecified frame is used within JAVA..

-t, -r, -f : not allowed in Java version

### NAME
    mips_subroutine – execute a MIPS subroutine

### SYNOPSIS
    mips_subroutine [-A] [-S] [-L file ... ] [-s] [-a after] [-b before] name [ arg ... ]


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

### COMMAND LINE OPTIONS
    The following options are available to manage the input:

      -L : load/link the enumerated files to be part of the final program.  Note specifying 
           shell globing characters has be used
           e.g. '*.s" denotes all .s files in the current directory are to be included in the final program.

      -S : converts each argument to a string. The address of each string
           is then stage in $a0 - $a3, and then onto the stack.

      -A : pass the input arguments as an heterogeneous array 
           - $a0: array.length
           - $a1: &array

      To mimic the argv structure, use the -A and -S argument together.


      -R type: specifies the return type from the subroutine.  The return value
         of the subroutine is emitted to stdout after the user output. The
         return types include:
           - null:    no return value is emitted
           - integer: an integer value (the value of $v0)
           - long:    a long integer value of (the value of $v1/$v0)
           - string:  a "string" 
            
         Future options include:
           - float:   a single precision real number (the value of $f0)
           - double:  a double precision real number (the value of $f0-$f1()

         Array data types are also support (the value of $v0 is the address of the array)
         (the value of $v1 needs to be the length of the array)
           - int[n]:   an array of integers 
           - long[n]:  an array of long integers
           - char[n]:  an array of characters
           - float[n]:  an array of single precision real numbers
           - double[n]: an array of double precision real numbers
           (where n is a number)

      -s : summarize the execution of the program 
           e.g., sub(1,2,3) returns $v0

      -r reg_list: dump the registers in the reg_list
        
          A reg_list is a comma separated list of registers numbers names,
          a range may also be provided -- but not implemented yet.
          Examples:
           * -r s0,s2,t1-t5,f2
           * -r 16,18,9-15,f2

      -t  : dump the $t0 - $t9 registers 


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

    MARS_JAR:          The location of the Mars jar file
    MIPS_VALIDATE:     TRUE (default)
    MIPS_SUB_FRAME:    adhoc
    MIPS_SUB_AFTER:    The default after
    MIPS_SUB_BEFORE:   The default before
    MIPS_SUB_RETURN:   The default return value 

### BEFORE and AFTER INSTRUCTIONS

    exit_status
    restore_return_values()
    validate() 
    sw $reg, exit_status

#### ADDITIONAL INTERNAL MACROS
    To further simply the creation of BEFORE and AFTER instructions a set of interal macros 
    have been developed.  These macros include (but not limited to)

    | Name     | Description            |
    |----------|------------------------|
    | Name     | Description            |
    | Name     | Description            |
    | Name     | Description            |

print_banner()
print_print_error()
restore_return_values()
restore_exit_status()
store_return_values()
restore_return_values()   |  sw $v0, exit_status)



### EXPECTION, LIMITATIONS and BUGS
    If an argument conforms to the syntax of a number, but is malformed,
    the shell will report an error and stop. For example,

       $ mips_subroutine func 4#456
       bash: 4#456: value too great for base (error token is "4#456")

### EXIT STATUS

    Upon success, the mips_subroutine exits with the value of $v0.
    This value, however, is restricted to the range 0..255

    Upon failure, the mips_subroutine exits with the value of 255.
    Possible failures include:
      - MARS assemble error:
        * various syntax errors have been detected
      - MARS linkage error
        * one or more subroutines are not defined
      - MIPS Calling Convention error
        * one or more of the save registers have not been restored
        * the stack or frame point have not been restored

    Refer to the stdout for additional information related to errors.  Ideally,
    such messages should be sent to stderr. However, bother Java and MARS
    (which is used internally) emit error messages to stdout.

    An "AFTER" routine may modify the original 'exit status' by storing
    a new value into the variable exit_status (e.g., sw $v0, exit_status)


