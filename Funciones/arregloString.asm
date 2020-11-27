.data
	lista: .word 0,0,0
	pala1: .asciiz "holaa000000000000000000000000a"
	pala2: .asciiz "Wenajjjjjjjjjjjjjjjjjss"
	pala3: .asciiz "Tardesjjjjjjjjjjjjjjj"
	
.text
	la $t0,pala1
	la $t1,pala2
	la $t2,pala3
	la $a1,lista
	
	sw $t0,0($a1)
	sw $t1,4($a1)
	sw $t2,8($a1)
	
	lw $a0,0($a1)
	li $v0,4
	syscall
	
	lw $a0,4($a1)
	syscall
	
	lw $a0,8($a1)
	syscall
	