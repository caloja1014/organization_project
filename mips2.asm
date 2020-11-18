.data 

buffer: .space 1024
.text
.globl main
main:
la $a0,buffer 
li $v0,8 
syscall 

la $t1,buffer 

loop: 
lb $t2,($t1) 
beq $t2,'?',loop1 
add $t1,$t1,1 
j loop

loop1:
sub $t1,$t1,1
lb $a0,($t1)
li $v0,11
syscall 

li $v0,10 
syscall