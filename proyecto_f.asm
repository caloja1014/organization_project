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
	li   $a2, 1000      # hardcoded buffer length
	syscall             # read from file


	# Printing File Content
	li  $v0, 4          # system Call for PRINT STRING
	la  $a0, buffer     # buffer contains the values
	addi $a0,$a0,3
	syscall             # print int

	li $v0, 10      # Finish the Program	
	syscall


.data


myFile: .asciiz "/home/cloja/Documents/ESPOL/6S/organizacion/proyecto/TablaIni.txt"      # filename for input
buffer: .space 10

msge1: .asciiz "Ingrese nombre de equipo 1:  "
msgeg1: .asciiz "Ingrese de goles de equipo 1:  "
msge2: .asciiz "Ingrese nombre de equipo 2: "
msgeg2: .asciiz "Ingrese goles de equipo 2: "


str1: .space 100
strg1: .space 100
str2: .space 100
strg2: .space 100

endline: .asciiz "\n"
