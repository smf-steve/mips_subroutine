Consider including a -C option
  -- to include other class files with java code
  -- perhaps, you just need to have the \*.class file in the current directory


# ToDo:

<<<<<<< HEAD
java_subroutine does not handle the stack for input for arg4
build c_subroutine

=======
v0 output is incosisent when faced with large negative number 
   need to printf with a specific size for the first decimal number
>>>>>>> 19842ab567bce96d4c439134a89dcc16962a203b

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
     1. mips_subroutine -L files.s     entry [args]       # explict of the primary use
     1. mips_subroutine -L .           entry [args]       # load all .s file in the current directory
     1. maybe use a path-spec like git
        1. mips_subroutine -L 'a.*'         entry [args]


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




option override
  --string : all elements are forced to be strings
  --argv ( string of string)
  defualt, looks like a duck its a duck  

refined input
  1. idividusla elements -- the default
  1. { ... }
  1. [ ... ]  : array, home,   size + elements
  1. ( ... )  : list, heter,   null

input types:
  integer:  0b, 0, 0x, 0x, [1-9][0-9]*  n#
  double:  4.2
    -- all floats move to doubles
  char : looks like a char
  string:    
     -note "a" and 'a' are the same to the shell
     - string must be "a\0"

  scientific
     34.23E34      # base 10
     0x34.23P344   # base 16 with base 10 exponent
     34.23 x 8^ 2323
   