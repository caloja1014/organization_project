.text
.globl main



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
	
	li $v0,16
	syscall



main:

	la $s2,buffer
	addi $s2,$s2,36


	li $t8,0   # Numero de linea en el archivo
	
	leer_lineas:
		move $t7,$s2
		#li $v0,4
		#move $a0,$t7
		#syscall
		li $t6,0
		loop_m: 
			lb $t2,($s2) 
			beq $t2,',',loop_m1 
			addi $s2,$s2,1
			j loop_m 
		loop_m1:
			addi $s2,$s2,1
			 move $s7,$t7
			leer_col:
			
			move $a0,$s7
			
			#li $v0,4
			#syscall
			
			jal findLengthString
			move $a2, $v0
			
			#li $v0,1
			#move $a0,$a2
			#syscall
			
 			la $a0, separator
    			jal findLengthString
    			move $a3, $v0 # M
    			addi $a3,$a3,1
    			sub $a2, $a2, $a3 # N-M
    			
			#li $v0,1
			#move $a0,$a2
			#syscall
    			
    			move $a0,$t7
    			la $a1, separator 

    			jal subStringMatch
    			move $t5, $v0
    			
    			#add $s7,$s7,$t5
			
			#li $v0,4
			#move $a0,$s7
			#syscall			
			
			move $a1,$t7
			la $a2,numero
			move $a3,$t5
			jal substring_f
			
			


			
			move $t1,$t7
			
			# Printing number Content
			li  $v0, 4          # system Call for PRINT STRING
			la  $a0, numero    # buffer contains the values
    			syscall
    			

	 		jal clean_buffer

			#addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        		#addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        		#syscall
        		
        		addi $t6,$t6,1
        		#bne $t6,8,leer_col
		
		addi $t8,$t8,1
		bne $t8,16,leer_lineas
	
	
	
	



	#loop1:
	#	sub $t1,$t1,1
	#	lb $a0,($t1)
	#	li $v0,11
	#	syscall 
	##	li $v0,1
	#	move $a0,$t0
	#	syscall
	#	li $v0,10 
	#	syscall


exit:
    li $v0, 10
    syscall

    lb $t9, endline


findLengthString:
    li $t0, -1
    move $s0, $a0

    loop_fls:
        lb $t1, 0($s0)
        beq $t1, $t9, foundLength

        addi $t0, $t0, 1
        addi $s0, $s0, 1
        j loop_fls

    foundLength:
        move $v0, $t0
        jr $ra

subStringMatch:
    li $t0, 0 #i
    loop1:
        bgt $t0,$a2, loop1done  
        li $t1, 0 #j
        loop2:
            bge $t1, $a3, loop2done
            add $t3, $t0, $t1
            add $t4, $a0, $t3
            lb $t3, 0($t4) # main[i+j] 

            add $t4, $a1, $t1
            lb $t4, 0($t4) # sub[j]
            # if a0[i + j] != a1[j]
            bne $t3, $t4, break1

            addi $t1, $t1, 1
            j loop2
        loop2done:
            beq $t1, $a3, yesReturn
            j break1
        yesReturn:
            move $v0, $t0
            jr $ra
    break1:
        addi $t0, $t0, 1
        j loop1
    loop1done:
        li $v0, -1
        jr $ra


#$a1 must have the complete string
#$a2 must have the substring
#$a3 must have the final indiceloop:
substring_f:
	li $t2,0
	loop:
		add $t4,$t2,$a2
		add $t3,$t2,$a1
	
		lb $s1,0($t3)
		sb $s1,0($t4)

		addi $t2,$t2,1
		bne $t2,$a3,loop
	jr $ra



clean_buffer:

	li $s5,0
	 loop_clean:
	 	add $a0,$a0,$s5
	 	sb $zero,($a0)
	 	addi $s5,$s5,1
	 	bne $s5,100,loop_clean
	 jr $ra 	
   
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
	separator: .asciiz ","
	myFile: .asciiz "C://Users//Laptop//Documents//6S//organizacion//proyecto//TablaIni.txt"      # filename for input
	buffer: .space 1000
	numero: .space 40
	endline: .asciiz "\n"
