.text


.globl menu






menu:
    li $v0, 4
    la $a0, msge1
    syscall

    li $v0, 8
    la $a0, str1
    li $a1, 99
    syscall

    li $v0, 4
    la $a0, msgeg1
    syscall

    li $v0, 8
    la $a0, strg1
    li $a1, 99
    syscall


    li $v0, 4
    la $a0, msge2
    syscall

    li $v0, 8
    la $a0, str2
    li $a1, 99
    syscall

    li $v0, 4
    la $a0, msgeg2
    syscall

    li $v0, 8
    la $a0, strg2
    li $a1, 99
    syscall


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
	#addi $a0,$a0,3
	#syscall             # print int

	#li $v0, 10      # Finish the Program	
	#syscall
	li $v0,16
	syscall



indice:

	
    la $a0,buffer
    jal findLengthString
    move $a2, $v0
    

    la $a0, str1
    jal findLengthString
    move $a3, $v0 # M
    sub $a2, $a2, $a3 # N-M
    

    
    la $a0, buffer
    la $a1, str1 

    jal subStringMatch
    move $t1, $v0
#While busca todos los numeros de las lineas
    while:
    	add $a0,$a0,$a3
    	add $a0,$a0,$t1
    	addi $a0,$a0,1
 	
 	move $t2,$a0
 	
 	jal findLengthString
    	move $a2, $v0

 	la $a0, separator
 	

    	
    	jal findLengthString
    	move $a3, $v0 # M
    	sub $a2, $a2, $a3 # N-M

    	move $a0,$t2
    	la $a1, separator 

    	jal subStringMatch
    	move $t1, $v0
	
	move $a1,$t2
	la $a2,string
	move $a3,$t1
	addi $a3,$a3,1
	
	jal substring_f
	# Printing File Content
	li  $v0, 4          # system Call for PRINT STRING
	la  $a0, string    # buffer contains the values
    	syscall

	




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
 












.data


myFile: .asciiz "/home/cloja/Documents/ESPOL/6S/organizacion/proyecto/TablaIni.txt"      # filename for input
buffer: .space 1000

string: .space 1000

msge1: .asciiz "Ingrese nombre de equipo 1:  "
msgeg1: .asciiz "Ingrese de goles de equipo 1:  "
msge2: .asciiz "Ingrese nombre de equipo 2: "
msgeg2: .asciiz "Ingrese goles de equipo 2: "

separator: .asciiz ","

str1: .space 100
strg1: .space 100
str2: .space 100
strg2: .space 100

endline: .asciiz "\n"
		
		