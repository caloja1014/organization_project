.text

la $a1,myFile
la $a2,string
li $a3,10

jal substring_f
# Printing File Content
li  $v0, 4          # system Call for PRINT STRING
la  $a0, string     # buffer contains the values
#addi $a0,$a0,3
syscall 






exit:
    li $v0, 10
    syscall

    lb $t9, endline
    
    
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
endline: .asciiz "\n"
string: .space 1000
myFile: .asciiz "/home/cloja/Documents/ESPOL/6S/organizacion/proyecto/TablaIni.txt"      # filename for input
buffer: .space 1000