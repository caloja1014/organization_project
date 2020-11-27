

.text

la $t0,buffer
la $t1, buffer2
addi $sp,$sp,-16

sw $t0,0($sp)
sw $t1,4($sp)

lw $t2,0($sp)
lw $t3,4($sp)

move $a0,$t2
li $v0,4
syscall

move $a0,$t3
syscall


addi $sp,$sp,16







.data

	buffer: .asciiz "Hola que hace\n"
	buffer2: .asciiz "WENAS TARDES"
