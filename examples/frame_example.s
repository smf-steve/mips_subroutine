# File: sum8.s
#
# Description:  This file contains two subroutines that test and validate the operation of
#               calling a subroutine under three different frame types:  ad-hoc, register, and full.
#
# Operation:    Returns the sum of the 8 integers provided via the command-line

                .include "./include/syscalls.s"
                .include "./include/stack.s"
                .include "./include/${FRAME_TYPE}_frames.s"

# #####  
                .globl name            # int name( int a, int b, int c, int d, int e, int f, int g)
 name:          nop

                # Register Allocation:
                # t0: a, and sum of a..h
                # t1: b
                # t2: c
                # t3: d
                # t4: e
                # t5: f
                # t6: g
                # t7: h

                ####################################################
                # Subroutine Setup

                load_additional_inputs $t4, $t5, $t6, $t7            # In lieu of accessing via memory
                add_locals 0                                         # Space for locals
                push $ra                                             # (For Non-leaf): Save the return address
                push_s_registers                                     # (For Non-leaf): Save the "Callee" saved registers
                demarshal_inputs $t0, $t1, $t2, $t3                  # 

#               ####################################################
#               # Note: obtain the additional inputs via the stack via direct memory access
#               #   ad-hoc frame:   nope: must use 'load_additional_inputs'
#               #   register frame: access additional args from stack via $fp 
#               #   full frame:     access all args from the stack via the $fp

                add $t0, $t0, $t1
                add $t0, $t0, $t2
                add $t0, $t0, $t3
                add $t0, $t0, $t4
                add $t0, $t0, $t5
                add $t0, $t0, $t6
                add $t0, $t0, $t7

                ####################################################
                # The Pre-call

                marshal_inputs $t0, $t1, $t2, $t3 
                push_t_registers
                push $fp
                stage_formals $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7
                alloc_return                                    # Space for return: alloca_i(4)

                ####################################################
                # The Call

                set_frame() 
                jal func                                       # {retval} = {func}({arg1}..{arg3});
                unset_frame()
    
                ####################################################
                # The Post-call

                unstage_return $v0                              # Only if return is on the stack    
                unstage_formals  $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7
                pop $fp
                pop_t_registers                                 # Restore T registers 
                demarshal_return $zero                         
                ####################################################


                ####################################################
                # Subroutine Cleanup
 
                marshal_return $t0
                pop_s_registers
                pop $ra
                remove_locals 0
                stage_return $t0
                ####################################################

                jr $ra
 #####


func:           nop
                jr $ra

