        .text
        .globl main
        
_main: 
        # result = surface_area_box($a0, $a1, $a2)
        li $a0, 20          # height of the box
        li $a1, 20          # length of the box
        li $a2, 20          # width of the box
        jal surface_area_box
        move $v0, $v0       # Noop: just pointing out the return value is in $v0

        # System.out.printf("%d", return_value);
        move $a0, $v0
        li $v0, 1
        syscall           

        # System.out.printf("%c", '\n');
        li $a0, '\n'
        li $v0, 11
        syscall       


        # System.exit(0)
        li $a0, 0
        li $v0, 17      
        syscall       



	.globl surface_area_box

surface_area_box:
        # $a0:  height of the box
        # $a1:  length of the box
        # $a2:  width of the box
        # $v0:  surface area
    
        # $t0:
        # $t1:
        # $t2:
        # $t3:
    
        ## Insert your TAC and Java code here to compute:
        ##    `the surface area of a box`
    
        
        jr $ra

