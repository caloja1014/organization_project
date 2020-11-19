.data
	mdArray:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	size:     .word 2
	
	.eqv DATA_SIZE 4

	myFile: .asciiz "/home/cloja/Documents/ESPOL/6S/organizacion/proyecto/TablaIni.txt"      # filename for input
	buffer: .space 1000
	

.text

lectura_archivo:   
	li   $v0, 13          # system call for open file
	la   $a0, myFile      # input file name
	li   $a1, 0           # flag for reading
	li   $a2, 0           # mode is ignored
	syscall               # open a file 
	move $s0, $v0         # save the file descriptor  


	# reading from file just opened

	li   $v0, 14        # system call for reading from file
	move $a0, $s0       # file descriptor 
	la   $a1, buffer    # address of buffer from which to read
	li   $a2, 999      # hardcoded buffer length
	syscall             # read from file


	# Printing File Content
	#li  $v0, 4          # system Call for PRINT STRING
	#la  $a0, buffer     # buffer contains the values
	#addi $a0,$a0,36
	#syscall             # print int

	#li $v0, 10      # Finish the Program	
	#syscall
	li $v0,16
	syscall


	main:
	    la $a0,mdArray
	    lw $a1,size
	    jal sumDiagonal
	    move $a0, $v0
	    li $v0, 1
	    syscall
	    
	    #End of the program
	    li $v0, 10
	    syscall
	
	
	
	
	sumDiagonal:
		li $v0, 0 #sum v0
		li $t0, 0
		sumLoop:
			
			mul $t1,$t0,$a1 # t1= rowIndex*colSize
			add $t1,$t1,$t0 #   	+colIndex
			mul $t1, $t1, DATA_SIZE #  *DATA_SIZE
			add $t1, $t1, $a0 	# +base address

			lw $t2,($t1)	
			add $v0, $v0, $t2
			
			addi $t0, $t0, 1     #i = i+1
			blt $t0, $a1, sumLoop 	#if i<size go to the sumLoop again
	jr $ra
			
		
		
		