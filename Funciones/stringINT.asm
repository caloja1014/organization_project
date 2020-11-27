
.data 
			### CHANGE THIS STRING TO TEST DIFFERENT ONES... ###
	string: .asciiz "-1" 
.text


	li $a0,3
	la $a1,string
	jal convertDigit
	move $a0,$v0
	li $v0,1
	syscall

exit:
    li $v0, 10
    syscall


# a0 lenght of number
# a1 address of string
#v0 is the final value
convertDigit:
	li $v0,0
	li $t0,0
	convertNext:
		addi $a0,$a0,-1
		add $t3,$a1,$a0
		lb $a2,($t3)
		beq $a2,'-',negative
		addi $a2, $a2, -48
		mul $t2,$t0,10
		
		bne $t2,0,seguir
		addi $t2,$t2,1
		seguir:
		mul $a2,$a2,$t2
		add $v0,$v0,$a2
		
		addi $t0,$t0,1
		bne $a0,0,convertNext
		jr $ra
	negative:
		mul $v0,$v0,-1
		jr $ra

		
		


