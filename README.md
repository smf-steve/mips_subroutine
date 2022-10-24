# Program: mips_subroutine

A program to facilitate the testing and execution of a MIPS subroutine.


## Purpose

The mips_subroutine program has been designed to facilitate the learning of MIPS assembly language.  With the use of this program, a student can focus their efforts on a single subroutine.  Then they can execute this subroutine from the command line, without worrying about the development of a corresponding `main` subroutine.  

The mips_subroutine creates the necessary code to bootstrap the execution of the subroutine, assembles and executes the associated MIPS code, and then performs some
post processing to validate that the MIPS calling conventions are observed.

The program, in total, performs the following:
  1. transforms command-line arguments to the correct type
  1. marshals the arguments to conform to the MIPS argument transmission convention
  1. calls the the subroutine via the `(jal)` instruction
  1. validates that the subroutine conforms to the MIPS register preservation convention
  1. prints the return value from the subroutine onto stdout
  1. conditionally dumps the values of defined set of registers


The mips_subroutine can also be used by more experience programs to perform unit testing.


## Examples

  1. Subroutine Name: add4
     1. Type Signature:  int x int x int x int -> int
     1. Description:
        * The subroutine returns the sums of its first 4 arguments together
     1. Usage example:
        ```
        $ mips_subroutine add4 1 2 3 4
        10
        $
        ```
     1. MIPS Register Assignment:  $a0=1, $a1=2, $a2=3, $a3=4; $v0=10

     1. Comments: The command line arguments are automatically transformed to integers

  1. Subroutine Name: vector-add
     1. Type Signature: int[] -> int
     1. Description:
        * The subroutine returns the a flattend string from the command-line arguments
     1. Usage example:
        ```
        $ mips_subroutine -A flatten 1 2 3 4 5 6
        this is 1 flatten   string
        $
        ```
     1. Comments: The `-S` option specifies that all command-line arguments are passed as strings.


1. Subroutine Name: flatten
     1. Type Signature: String[] -> String
     1. Description:
        * The subroutine returns the a flattend string from the command-line arguments
     1. Usage example:
        ```
        $ mips_subroutine -S flatten "this is " 1 "flatten   " string
        this is 1 flatten   string
        $
        ```
     1. Comments: The `-A` option specifies that all command-line arguments are within an array
