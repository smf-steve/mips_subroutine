Notes on Command Line Inputs

The program uses the duck rule to determine the type of inputs. That is
to say, 
   - integers are preferred over characters
   - doubles are preferred over strings
   - characters are preferred over strings

- Each numerical input value can be quoted to allow white space for readability.

- Due to the shell escaping rules, we presume that all inputs are double quoted.  But quotes my be removed if superfluous.

The following input types are supported:

 - integers
   - decimal: "456 123 123"
   - binary: "0b 1011 1101"
   - octal: 
     * 0456
     * 0o456
   - hex: 0xFACE
   - base notation:
     * "2# 1011 1101"
     * "8# 100 101 110"
     * "16# FACE"

 
 - characters
   - "a"  : single character on the command line
   - "'a" : single character with tick notation
   - "\a" : an legal C escape character

 - doubles:  a number with a radix point
   * example "5 125.434 34"
   * note only decimal numbers are supported

- string: two or more characters
   - "\0\0"
   - "a\0"
   - "ab"
   - "'\n"
   - "5 125.434 34\0"


Due to the quote rules associate with the shell, 


  {\*}\_subroutine: 

198      --> int
"198"    --> int
'198'    --> int
"198\0"  --> string
'198\0'  --> string

a        --> char
"a"      --> char
'a'      --> char
"a\0"    --> string
'a\0'    --> string

ab       --> string
'ab'     --> string
"ab"     --> string


[ a b c ]