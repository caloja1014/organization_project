
 
.data 
			### CHANGE THIS STRING TO TEST DIFFERENT ONES... ###
	string: .asciiz "6"  

.text

la $a1,string
li $a2,0


jal isdigit
move $a0,$v0
li $v0,1
syscall

exit:
    li $v0, 10
    syscall


# $a0 char val
# $a1 address pointer
# $a2 PERIOD_HIT_FLAG
# $a3 HAS_DIGITS_FLAG
	isdigit:
		set_up: #test for 0th char == 45 or 46 or 48...57
		
		lb $a0,($a1)
		beq $a0,45,loop # == '-'
		beq $a0,46,loop # == '.'
		blt $a0,48,exit_false # isn't below the ascii range for chars '0'...'9'
		bgt $a0,57,exit_false # isn't above the ascii range for chars '0'...'9'
		
		loop:
		la $a3,1 #set the HAS_DIGITS flag. This line is only reached because the
			 #    tests for period and - both jump back to start.
		addi $a1,$a1,1
		lb $a0,($a1)
		beqz $a0,exit_true # test for \0 null char
		beq $a0,46,period_test #test for a duplicate period
		blt $a0,48,exit_false  #test for 
		bgt $a0,57,exit_false
		 
		j loop
 
	exit_true:
		beqz $a3,exit_false
		la $v0,1
		jr $ra
	exit_false:
		la $v0,0
		jr $ra
 
	period_test:
		beq $a2,1,exit_false
		li $a2,1
		j loop


	Exit:
		li $v0, 10
		syscall
 