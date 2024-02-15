# This file contains the macros to support the defined COMP122 standard frame. The frame provides space formal 
# arguments, local variables, temporary storage, and all relevant registers.

# Macro List
########################
#
# marshal_inputs %arg0, %arg1, %arg2, %arg3 
#   - IF IN_REGS: moves the values into the $a0, ... $a3, respectively
#   - OTHERWISE:  nop
#
# demarshal_inputs %arg0, %arg1, %arg2, %arg3
#   - IF IN_REGS: moves the values from $a0, ... $a3, respectively
#   - OTHERWISE:  nop
#
# add_locals     %counts
# remove_locals  %counts
#   - adds or removes the space for local variables
#
# marshal_return %reg
#    - moves %reg into $v0
# demarshal_return %reg
#   - moves $v0 into %reg
#
# stage_formals    [ {arg4} ... {argN} ]  
# unstage_formals  [ {arg4} ... {argN} ]
#   - stores/loads formals into appropriate registers
#   - IF IN_REGS, starts at 20($fp), i.e., the location for arg4
#   - OTHERWISE, starts at   4($fp), i.e., the location for arg0
#
# set_frame   $fp, $sp
#   - sets the frame pointer to be current top of the stack
# unset_frame $fp
#   - effectively a nop
#   - defined to be symmetrical to set_frame
#
# push_t_registers
# pop_t_regiters
# push_s_registers
# pop_s_regiters
#   - push and pop the set of identified registers


###############################################
#
# ACTIVATION FRAMES, or simply, FRAMES
#
# A call stack is used to support the execution of subroutines.  Each subroutine invocation results in a activation frame, 
# or simply a frame, is provide be created and stored on top of the stack. The frame contains the formal arguments, locals 
# variables, temporary variables, etc.
#
# There are many possible conventions that can defined sued by many different programmers, assemblers, and compilers.  
# These conventions are typically machine dependent and ABI dependent[^abi].  
#
# While there are some document conventions associated with parameter passing, etc., for the MIPS architecture, there is 
# no such thin as THE "MIPS Calling Convention" that defined _in total_ the structure of a frame.
#
# In COMP122, utilize two different calling convention.  The first utilizes a full frame structure (which is documented here),
# while the second is a simplified form of the first. This simpler form has the following restrictions.
#
#  1. There is at most 4 formal arguments provided to a subroutine
#  2. Each of these arguments are passed via the registers: $a0, ... $a3
#  3. Each of these arguments are then, by the programmer, moved to a temporary register
#  4. There are no local variables (as are typical defined for high-level languages) 
#     - all variables associated with the subroutine are mapped, a prior, to registers
#  5. The single return value is passed via the register: $v0
#  6. All functions that return a value that is not a "word", is returned as a pointer to the actual return value.
#
# Because of these restrictions, there is no need to create a "structured" form which utilizes a frame pointer.
# This simplified form is used for most of COMP122.
#
# The rest of this file, documents this full frame structure.
#
# [^abi]: application binary interface


# DESIGN CRITERIA
#
# The convention and structure of a frame is based upon a number of Design Criteria.  Here is a list of questions, 
# along with our answers, that influence the final structure
#
# Questions:
#   - Who is responsible, the Caller or the Callee, for pushing formal arguments onto the stack?
#     * the Caller
#   - Who is responsible for popping the arguments of the stack?
#     * the Caller
#   - Are varargs function supported?
#     * Yes, and this implies that the Caller is responsible for pushing and popping formal arguments.
#   - Is alloca supported?
#     * Yes, alloca allows the programmer to allocate additional space on the stack for dynamic data.
#   - Who is responsible for saving which registers?
#     - Using the MIPS convention:
#       * The Caller is responsible for saving the T registers
#       * The Callee is responsible for saving the S registers
#       * The Callee is responsible for saving any used special registers: i.e., $ra, $fp
#   - Who is responsible for setting the frame pointer?
#     * Typically, the Callee is responsible, BUT we decided the Caller is responsible
#   - Where is the frame pointer set:  start of the frame, at arg0, or other?
#     * The frame pointer is set to the return value, thus
#       1. Formals are reference as:  pos($fp)
#       1. Locals are reference as:   neg($fp)
#   - Can special rules be used for leaf nodes for optimization purposes?
#     * Yes, specific defined steps can be eliminated
#   
#   - What values can be stored on the stack: word, dword, doubles?
#     * Only words are stored on the stack
#
#   - Is padding needed to ensure alignment
#     * No, because only words can be stored on the stack
#
#   - Can registers be used for parameter passing?
#     * Yes, $a0 ... $a3 for formal arguments.
#     * Yes, $v0 ... $v1 for return values.
#   - Can both $v0 and $v0 be used to return values
#     * Yes, but only for the simplified form  
#     * No, for the full frame structure.  The $v0 value can be a pointer to actual return value
#

# FRAME Layout
#
# See below for a picture layout of the Frame
#
# The layout of the frame contains three major areas:
#
#  1. a static area that contains 
#     - the formal arguments
#       * space for the first 4 arguments (i.e., for $a0 ... $a4) 
#       * actual values of the  
#       * note that the formal arguments are also part of the previous subroutine's dynamic space
#     - space for the return value
#     - the local variables
#
#  1. a dynamic area that contains 
#     - space for the $ra register
#       * which can be eliminated if the subroutine is a leaf node
#     - space for callee saved registers ($s7 .. $s0)
#
#     - space for a subroutine stack  (see: man alloca)
#
#     - space for caller saved registers ($t9..$t0)
#     - space for the $fp register
#       * the location of $fp register is well defined within the Callee's frame
#       * the location below the last formal argument contains the location parent's $fp value
#
#  1. parameter passing for a subordinate subroutine
#     - space for the actual arguments associated with a subroutine call
#
#  * Note the following registers are not stored within the stack frame
#    - $zero: it's a constant
#    - the reserved registers:
#      - $at: it is the responsibility of the assembler
#      - $k1, $k2: it is the responsibility of the kernel
#      - $gp: it is the responsibility of the compiler
#      - $sp: its previous values can be restored algebraically 

#
# EXAMPLE PICTURAL LAYOUT
#
#   Given the example of 
#     ```
#     int name( int a, int b, int c, int d, int e, int f) {
#
#       int x, y, z;
#       z = sub2(x, y, z, a, f);
#     }
#     ```

# Static Space:
#
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    f     | Formal |          |  24($fp) |  local# << 2       |
#         |    e     | Formal |          |  20($fp) |  local# << 2       |
#         |    d     | Formal |  $a3     |  16($fp) |  local# << 2       |
#         |    c     | Formal |  $a2     |  12($fp) |  local# << 2       |
#         |    b     | Formal |  $a1     |   8($fp) |  local# << 2       |
#         |    a     | Formal |  $a0     |   4($fp) |  local# << 2       |
#  $fp->  |  return  | Return |  $v0     |   0($fp) |                    |
#         ---------------------------------------------------------------
#         |    x     | Local  |  --      |  -4($fp) |  - local# << 2     |
#         |    y     | Local  |  --      |  -8($fp) |  - local# << 2     |
#         |    z     | Local  |  --      | -12($fp) |  - local# << 2     |
#         |--------------------------------------------------------------|

# Dynamic Space:
#
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    -     | Callee |  $ra     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $s7     |  ?       | pushed onto stack  |
#         |    -     | Callee |  ...     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $s0     |  ?       | pushed onto stack  |
#         ----------------------------------------------------------------
#         |    -     | IStack |          |  ?       | alloca(size)       |   # Can repeated any number of times
#         ----------------------------------------------------------------
#         |    -     | Caller |  $t9     |  ?       | pushed onto stack  |
#         |    -     | Caller |  ...     |  ?       | pushed onto stack  |
#         |    -     | Caller |  $t0     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $fp     |  ?       | pushed onto stack  |

# Parameter Passing Space:
#
#         ----------------------------------------------------------------
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    f     | Actual |  ---     |  ?       |  push onto stack   |
#         |    a     | Actual |  $a3     |  ?       |  alloca_i(4)       |
#         |    z     | Actual |  $a2     |  ?       |  alloca_i(4)       |
#         |    y     | Actual |  $a1     |  ?       |  alloca_i(4)       |
#         |    x     | Actual |  $a0     |  ?       |  alloca_i(4)       |
#  $sp->  |  return  | Return |  $v0     |  ?       |  alloca_i(4)       |
#         ---------------------------------------------------------------



# PROCESSES
#
# Subroutine Setup/Cleanup Process

# #####  
#               .globl name            
# name:         nop
#
#               ####################################################
#               # Subroutine Setup
#
#               add_locals 3                                    # Space for x, y, and z 
#               push $ra                                        # (opt): Unless this is a leaf node
#               push_s_registers                                # Save the "Callee" saved registers
#               demarshal_inputs $t0, $t1, $t2, $t3
#
#               ####################################################
#
#               < Main Subroutine Code >
#
#               ####################################################
#               # Subroutine Cleanup
# 
#               marshal_return
#               pop_s_registers
#               pop $ra
#               remove_locals 5
#               ####################################################
#
#               stage_return $t1
#               jr $ra
# #####



# Subroutine Invocation Process
#
#               ####################################################
#               # The Pre-call
#
#               marshal_inputs({arg1}.. {arg3})
#               push_t_registers()
#               push $fp
#               stage_formals({arg4} ... {argN})
#               push $v0                                        # Space for return: alloca_i(4) -- always
#
#               ####################################################
#               # The Call
#
#               set_frame() 
#               jal {func}                                      # {retval} = {func}({arg1}..{arg3});
#    
#               ####################################################
#               # The Post-call
#
#               pop $v0                                         # Only if return is on the stack    
#               unstage_forms({arg4} ... {argN}) 
#               pop $fp
#               pop_t_registers()                               # Restore T registers 
#               demarshal_return({reg})                         
#               ####################################################



# Macros for IN_REG
#    - for ON_STACK approach, these are NOPs

.macro marshal_inputs(%arg0, %arg1, %arg2, %arg3)
        move $a0, %arg0
        move $a1, %arg1
        move $a2, %arg2
        move $a3, %arg3
.end_macro
.macro demarsh_inputs(%arg0, %arg1, %arg2, %arg3)
        move %arg0, $a0
        move %arg1, $a1
        move %arg2, $a2
        move %arg3, $a3
.end_macro


.macro add_locals(%count)
        addiu  $sp, $sp, -%count
.end_macro
.macro add_locals(%count)
        subiu  $sp, $sp, %count
.end_macro


.macro marshal_return(%reg)
        move $v0, %reg
.end_macro
.macro demarshal_return(%retval)
        move %retval, $v0 
.end_macro


.macro set_frame(%fp, %sp)
        move %fp, %sp
.end_macro
.macro unset_frame(%fp)
        nop
.end_macro


## For IN_REGS approach
#    - for ON_STACK approach,  arg4 --> arg0 and stack offset is changed
#    
.macro stage_formals(%arg4, arg5, %arg6, %arg7, arg8)
       addiu $sp, $sp, -36
       lw arg8, 32($sp)
       lw arg7, 28($sp)
       lw arg6, 24($sp)
       lw arg5, 20($sp)
       lw arg4, 16($sp)
.end_macro
.macro stage_formals(%arg4, arg5, %arg6, %arg7)
       addiu $sp, $sp, -32
       lw arg7, 28($sp)
       lw arg6, 24($sp)
       lw arg5, 20($sp)
       lw arg4, 16($sp)
.end_macro
.macro stage_formals(%arg4, arg5, %arg6)
       addiu $sp, $sp, -28
       lw arg6, 24($sp)
       lw arg5, 20($sp)
       lw arg4, 16($sp)
.end_macro
.macro stage_formals(%arg4, arg5)
       addiu $sp, $sp, -24
       lw arg5, 20($sp)
       lw arg4, 16($sp)
.end_macro
.macro stage_formals(%arg4)
       addiu $sp, $sp, -20
       lw arg4, 16($sp)
.end_macro
.macro stage_formals()
       addiu $sp, $sp, -16
.end_macro


## For IN_REGS approach
#    - for ON_STACK approach,  arg4 --> arg0 and stack offset is changed
#
.macro unstage_formals(%arg4, arg5, %arg6, %arg7, arg8)
       subiu $sp, $sp, -36
.end_macro
.macro unstage_formals(%arg4, arg5, %arg6, %arg7)
       subiu $sp, $sp, -32
.end_macro
.macro unstage_formals(%arg4, arg5, %arg6)
       subiu $sp, $sp, -28
.end_macro
.macro unstage_formals(%arg4, arg5)
       subiu $sp, $sp, -24
.end_macro
.macro unstage_formals(%arg4)
       subiu $sp, $sp, -20
.end_macro
.macro unstage_formals()
       subiu $sp, $sp, -16
.end_macro


.macro stage_return 
        sw $v0 -4($sp) 
.end_macro


## Aggregate macros to save/restore registers
.macro push_t_registers()
        nop                     # Push all of the T registers
        push $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9
.end_macro

.macro pop_t_registers()
        nop                     # Pop all of the T registers
        pop $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9
.end_macro

.macro push_s_registers()
        nop                     # Push all of the S registers
        push $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7
.end_macro

.macro pop_s_registers()
        nop                     # Pop all of the S registers
        pop $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7
.end_macro
