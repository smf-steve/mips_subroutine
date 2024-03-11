# README.md:

This directory contains a set of macros for MIPS.
The cononical location of these macros are defined in 
http://www.github.com/smf-steve/mips_subroutine/macros


## Files:
1. syscalls.s: macros that directly wrap syscalls
1. io.s: macros that extend IO operatons related syscalls
1. stack.s: macros that perform stack operations
1. frames: macros that support subroutine calls
   - frames_ad-hoc.s:  using ad-hoc frames
   - frames_register.s: using  the MIPS convention with registers
   - frames_full.s: using frames that don't use registers
* subroutine.s: removed
* bit_manipulation.s:  to be removed  

