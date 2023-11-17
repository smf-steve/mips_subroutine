# ToDo:

java_subroutine does not handle the stack for input for arg4
build c_subroutine


## Bugs

1. calling java_subroutine using a non-plain file

$ java_subroutine examples/echo4 h 3 l o
cat: echo4.j: No such file or directory
echo4.j:10: error: cannot find symbol
    int $v0 = echo4($a0, $a1, $a2, $a3);
              ^
  symbol:   method echo4(char,int,char,char)
  location: class echo4
echo4.j:19: error: cannot find symbol
    system.exit($v0);
    ^
  symbol:   variable system
  location: class echo4
2 errors


# Test Cases:
  1. examples/echo4.s: 
     - bug in core program



## Enhancements

   * To support MARS's project mode:
     1. mips_subroutine entry [args]                  # entry is assume to be in entry.s
     1. mips_subroutine -e entry -L files.s [args]    # explict of the primary use
     1. mips_subroutine entry -L files.s [args]       # explict of the primary use
     1. mips_subroutine entry -L .       [args]       # load all .s file in the current directory
     1. mips_subroutine -e entry -L .    [args]       # load all .s file in the current directory


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


 entry





