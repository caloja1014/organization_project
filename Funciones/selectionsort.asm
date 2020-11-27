    

.data
	mdArray:  .word 15, 1, 1,1,1,1,1,1
		  .word 9, 0, 0,1,1,1,1,1
		  .word -10, 0, 0,1,1,1,1,1
		  .word 15, 2, 2,1,1,1,1,1
		  .word 15, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
		  .word 16, 2, 2,1,1,1,1,1
	.eqv DATA_SIZE 4

.text 

li $a0,8
li $a1,16
la $a2,mdArray
jal selection_sort


   

la $a0, mdArray
	li $a1, 8 #columns
	li $a2, 16 #rows
	jal printArray
	j exit
   
 printArray: 
	li $t0, 0 #rowIndex
	
	move $s1, $a0
	
	loop1: 
	li $t1, 0 #columIndex
	
		loop2:
		
		mul $t2, $t0, $a1
		add $t2, $t2, $t1
		mul $t2, $t2, DATA_SIZE
		add $t2,$t2, $s1
		
		lw $t3, 0($t2)
		move $a0, $t3
		li $v0, 1
		syscall
		#la $a0, separador
		#li $v0, 4
		#syscall
		addi $t1, $t1, 1
		blt $t1, $a1, loop2
	
	#li $v0,4
	#la $a0, salto
	#syscall
	addi $t0, $t0, 1
	blt $t0, $a2, loop1
	jr $ra


exit:
    
    li $v0, 10
    syscall


# a0 is the number of columns
# a1 is the number of rows
# a2 is the address of the matrix
selection_sort:
   
   li $t1,0 #contador i
   
   move $t3,$a1
   addi $t3,$t3,-1 #MAX-1	
   
   loop_1:
   	
   	move $t0,$t1 #valor indiceMin
   	
   	mul $t5,$t1,4
   	mul $t5,$t5,$a0
   	
   	add $t5,$t5,$a2
   	
   	addi $t2,$t1,1 #contador j
   	lw $a3,($t5)
	
   	loop_2:
   	   	mul $t6,$t2,4
   		mul $t6,$t6,$a0
   		
   		add $t6,$t6,$a2
   		lw $s1,($t6)
   		
   		mul $s3,$t0,4
   		mul $s3,$s3,$a0
   		
   		add $s3,$s3,$a2
   		lw $s4,($s3)
   		
   		bgt $s1,$s4,reasign_index   		
   		j continue
   		
   		reasign_index:
   		    move $t0,$t2
   		
   		continue:
   	
   	addi $t2,$t2,1
   	bne $t2,$a1,loop_2
   	
   	
   	bne $t0,$t1,swap
   	j continue_2
   	swap:
   		li $t7,0
   		
   		
   		loop_columns:
   		move $s6,$t5
   		mul $s5,$t7,4  #numero de columna
   		
   		mul $t6,$t0,4 #numero de fila
   		mul $t6,$t6,$a0
   		add $t6,$t6,$s5
   		
   		add $t6,$t6,$a2
   		lw $s1,($t6)
   		
   		add $s6,$s6,$s5
   		
		addi $sp,$sp,-4
		
		sw $a3,($sp)
		lw $a3,($s6)
		sw $a3,($t6)
   		sw $s1,($s6) 	
	
		lw $a3,($sp)
		addi $sp,$sp,4
   		
  		
   		addi $t7,$t7,1
   		bne $t7,$a0,loop_columns
   		
   		
   	continue_2:
 
   addi $t1,$t1,1
   bne $t1,$t3,loop_1
   
   jr $ra
   
   	
