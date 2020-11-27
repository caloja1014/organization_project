
.data 
welc: .asciiz "Bienvenido a la Tabla loca del futbol \n"
opc1: .asciiz "1. Ver tabla de posiciones.\n"
opc2: .asciiz "2. Inrgesar datos de un partido.\n"
opc3: .asciiz "3. Salir\n"
ing: .asciiz "ingrese un numero: \n"
error: .asciiz "ingrese solo una de las 3 opciones \n\n"

.text 

	menuMain: 
		li $v0, 4
		la $a0, welc
		syscall
		
		li $v0, 4
		la $a0, opc1
		syscall
		
		li $v0, 4
		la $a0, opc2
		syscall
		
		li $v0, 4
		la $a0, opc3
		syscall
		
		li $v0, 4
		la $a0, ing
		syscall
		
		li $v0,5
		syscall
		
		move $t0, $v0
		
		beq $t0, 1, mostTable
		
		beq $t0, 2, ingrPart
		
		beq $t0, 3, Exit 
		
		li $v0, 4
		la $a0, error
		syscall
		
		j menuMain
		
	Exit:
		li $v0, 10
		syscall
		
	mostTable:
		addi $t4,$zero,1 
		j menuMain
		
	ingrPart:
		addi  $t4,$zero,1 
		j menuMain 
