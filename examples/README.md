# Examples

This directory contains a number of subroutines written in both MIPS and Java.  The purpose of these examples is both to illustrate the use of and to test the mips_subroutine and java_subroutine utilities.  


The primary focus is placed on the comand-line interface for both input and output arguments. The MIPS code conforms to the style typically used in assembly language program.  Whereas, the Java subroutines are written to mirror the MIPS approach. 

The Makefile provides the information on how to 


# File Summary:
  | Name/API                     | Description                          | 
  |------------------------------|--------------------------------------|
  | empty                        | the typical no-op program            |
  | hello_world                  | emits "Hello World" to stdout        |
  | summation N                  | computes the sum of 1, 2, .. N       |
  | binaryReal                   | converts a real number in any base   |
  | * 16 "\#"  FACE "." DEAF     | to the equivalent binary real        |
  | binary32 char int int char   | scientific notation to binary32      |


-- these require frames
  | echo_int N int ... int       | echos N command line integers        |
  | echo N str ... str           | echos N command line args            |



# Bug: currently push, pop only works with ints, not strings

  | read_echo_int()              | reads from stdin and emits to stdout |
This request special handling on the Java side, ?  mips.read


echo_cat_list N {arg}^N : catenates the cl args into a single string


encode_binary32
checksum 

strcat
strcat_return
strchr

This directory contains a set of MIPS subroutines used for the testing of the mips_subroutine utility, as well as the companion java_subroutine utility.  A key feature of these routines is that they exercise the MIPS Argument Transmission Convention.  This helps to validate that the marshaling of the actual arguments is performed correctly.  These routines also help to validate that the return value, of various types, are presented to stdout.

The MIPS Argument Transmission Convention is summarized via the following table.  In short, a maximum of 4 words (16 bytes) are stored in registers, with all subsequent values stored on the stack.  The first two floating point values (single or double) are always transmitted in $f12 and $f12, respectively.  Integer values are always placed into the `a` register that corresponding to their argument position. For example, the third (3) argument, if it is an integer value, is placed into `$a2`. 


| Position: | 1st   | 2nd   | 3rd   | 4th   | 5th   | Nth   |
|-----------|-------|-------|-------|-------|-------|-------|
| w w w w   | $a0   | $a1   | $a2   | $a3   | stack | stack |
| d d *     | $f12  | $f14  | stack | stack | stack | stack |
| l l *     | $a0-1 | $a2-3 | stack | stack | stack | stack |

We have extended the convention to include longs.  Here we follow the pattern of floating point values, where specific registers are paired (``(a0 && $a1) and ($a2 && a3)``). Under this scheme a maximum of two values can be transmitted in registers if one of them is a long value -- which is also consistent with the transmission of floating point values.

An alternative approach would be to place a `long int` into two consecutive registers and then place the next integer value into the subsequent `a` register. 



Under this scheme, technically, subsequent 
Subsequent integer values 

An alternative approach would be to pack the registers

| w l w *  | $a0  | $a1-2 | $a3   | stack | stack | stack | ? pack the registers
| w l l    | $a0  | $a2-3 | stack | stack | stack | stack | ? convention of paired registers

| w d d *  | $a0  | $f14  | $a2   | $a3   | stack | stack |


| w w l *  | $a0  | $a1   | $a2-3 | stack | stack | stack | ? 


| d w w w  | $f12 | $a1   | $a2   | $a3   | stack | stack |
| d w w d  | $f12 | $a1   | $a2   | stack | stack | stack |
| d w d    | $f12 | $a1   | stack | stack | stack | stack |
| d d      | $f12 | $f14  | stack | stack | stack | stack |




We have extended this table to work with `double words`, the following is our interpretation on how such double words are to be transmitted 

| l l *    | $a0  | $a3   | stack | stack | stack | stack |


| w l w *  | $a0  | $a1-2 | $a3   | stack | stack | stack | ? pack the registers
| w l *    | $a0  | $a2-3 | stack | stack | stack | stack | ? convention of paired registers

| w d w w  | $a0  | $f14  | $a2   | $a3   | stack | stack |


| w w l *  | $a0  | $a1   | $a2-3 | stack | stack | stack | ? 


| d w w w  | $f12 | $a1   | $a2   | $a3   | stack | stack |
| d w w d  | $f12 | $a1   | $a2   | stack | stack | stack |
| d w d    | $f12 | $a1   | stack | stack | stack | stack |
| d d      | $f12 | $f14  | stack | stack | stack | stack |

w: an integer value stored with a single word (which includes addresses)
d: a floating point value (single or double) stored 
l: an integer value stored within two words


The following table enumerates the example subroutines 

| Filename | Subroutine |  Description                                           |
| -------- | ---------- |  ----------------------------------------------------- |
| sum_8.s  | sum_8      |  Returns the sum of  8 `int`s                          |
| sum_a.s  | sum_a      |  Reduces an array of `long int` via addition           |
   
| sum_l_4.s  | dsum_4   |  Returns the sum of 4 `long int`s                      |
| sum_l_a.s  | dsum_a   |  Reduces an array of `long int`s via addition          |
   
| sum_d_4.s  | sum_4    |  Returns the sum of 4 `double`s                        | 
| sum_d_a.s  | sum_a    |  Reduces an array of `double`s via addition            |
   
| concat_8.s  | sum_8   |  Returns the concatenated string of 8 substrings       |
| concat_a.s  | sum_a   |  Reduces an array of strings via concatenation         | 

| sum_didi.s
| sum_idid.s
| sum_iidd.s



  - only the first 4 words are stored in registers
  - floats are counted as doubles


|          | 1st  | 2nd  | 3rd   | 4th   | 5th   | Nth   |
|----------|------|------|-------|-------|-------|-------|
| integer* | $a0  | $a1  | $a2   | $a3   | stack | stack |
| i d i i  | $a0  | $f14 | $a2   | $a3   | stack | stack |
| d i i i  | $f12 | $a1  | $a2   | $a3   | stack | stack |
| d i i d  | $f12 | $a1  | $a2   | stack | stack | stack |
| d i d    | $f12 | $a1  | stack | stack | stack | stack |
| d d      | $f12 | $f14 | stack | stack | stack | stack |



In short, 
  - floats can only be passed via a register if they are the 1st or 2nd arguement
    - subsequently parameters -- regardless of type are passed via the stack
  - once two floats are passed, all subsequent parameters are passed via the stack

