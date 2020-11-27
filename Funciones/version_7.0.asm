.data
	mdArray:  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
		  .word 0, 0, 0, 0, 0, 0, 0, 0
	lista_indices: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	size:     .word 2
	equipos:.space 320
	.eqv DATA_SIZE 4
	separator: .asciiz ","
	lineSeparator: .asciiz "\r\n"
	myFile: .asciiz "C://Users//Cloja//Documents//ESPOL//6S//organizacion//proyecto//TablaIni.txt"      # filename for input
	buffer: .space 1000
	#buffer: .asciiz "Au,3,4,5"
	numero: .space 40
	endline: .asciiz "\n"
	tab:	.asciiz "\t"
	
	equipo_1: .asciiz "U.Catolica"
	equipo_2: .asciiz "Barcelona"


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
	
	
	la $s5,equipos
	li $s3,0
	
	
	la $s2,buffer
	addi $s2,$s2,36

	li $s7,0# the position of the number
	li $t8,53   # Numero de linea en el archivo
	la $a0,buffer
	jal findLengthString
	move $t6, $v0
	
	la $v1,mdArray
	
	leer_lineas:
		la  $a0, numero    # buffer contains the values
	 	jal clean_buffer
		move $t7,$s2		
		loop_m: 
			lb $t2,($s2) 
			
			bne $t2,13,pr
			
			addi $s2,$s2,2
			
			move $a0,$t7
			
			jal findLengthString
			move $a2, $v0
			
 			la $a0, lineSeparator
    			jal findLengthString
    			move $a3, $v0 # M
    			addi $a3,$a3,1
    			sub $a2, $a2, $a3 # N-M
    			
    			move $a0,$t7
    			la $a1, lineSeparator 

    			jal subStringMatch
    			move $t5, $v0	
    			beq $t5,-1,correct
    			add $t8,$t8,$t5
    			correct:
			addi $t8,$t8,1
			beq $t8,$t6,fin_main
			
			move $a1,$t7
			la $a2,numero
			move $a3,$t5
			jal substring_f
			
			la $a1,numero
			li $a2,0
			jal isdigit

			move $a0,$v0
			beq $a0,0,leer_lineas
			
			move $a0,$t5
			la $a1,numero
			jal convertDigit
			##Almacenamiento del valor en la matriz
			mul $s4,$s7,DATA_SIZE
			add $s4,$s4,$v1
			sw $v0,($s4)			
			
			# Printing number Content
			move $a1,$t7
			la $a2,numero
			move $a3,$t5
			
			la  $a0, numero    # buffer contains the values
	 		jal clean_buffer
			addi $s7,$s7,1
			bne $t8,$t6,leer_lineas
			
			pr:
			seq $s6,$t2,','
			beq $s6,1,loop_m1
			 
			addi $s2,$s2,1
			j loop_m

			
		loop_m1:
			
			
			addi $s2,$s2,1
			leer_col:
			
			move $a0,$t7
			

			jal findLengthString
			move $a2, $v0

 			la $a0, separator
    			jal findLengthString
    			move $a3, $v0 # M
    			addi $a3,$a3,1
    			sub $a2, $a2, $a3 # N-M
    			
    			move $a0,$t7
    			la $a1, separator 

    			jal subStringMatch
    			move $t5, $v0
    						
			add $t8,$t8,$t5
			addi $t8,$t8,1
			
			
			move $a1,$t7
			la $a2,numero
			move $a3,$t5
			jal substring_f
			
			la $a1,numero
			li $a2,0
			jal isdigit


			move $a0,$v0
			beq $a0,0,agregar_equipo
			
			j no_agregar_equipo
			
			agregar_equipo:
				
				addi $sp,$sp,-8
				sw $a3,($sp)
				sw $t0,4($sp)
				
				la $a3,lista_indices
				mul $t0,$s3,4
				add $t0,$t0,$a3
				sw $s3,($t0)
				
				lw $a3,($sp)
				lw $t0,4($sp)
				addi $sp,$sp,8
				
				mul $t1,$s3,20
				add $t1,$t1,$s5
				la $a1,numero
				copy:
					lb $a0,($a1)
					sb $a0,	($t1)
					
					addi $a1,$a1,1
					addi $t1,$t1,1
					bne $a0,0,copy
	
				
				addi $s3,$s3,1
				
		

			j leer_lineas
			
			no_agregar_equipo:
			move $a0,$t5
			la $a1,numero
			jal convertDigit
			
			##Almacenamiento del valor en la matriz
			mul $s4,$s7,DATA_SIZE
			add $s4,$s4,$v1
			sw $v0,($s4)
			
			move $a1,$t7
			la $a2,numero
			move $a3,$t5
			
			
			addi $s7,$s7,1	
			la  $a0, numero    # buffer contains the values
	 		jal clean_buffer

		bne $t8,$t6,leer_lineas

		fin_main:
		la $a0,numero
		jal clean_buffer
		  
		move  $a0, $s2  
		jal findLengthString
		move $a0, $v0
		addi $a0,$a0,-1
		move $a1,$s2
		jal convertDigit

		mul $s4,$s7,DATA_SIZE
		add $s4,$s4,$v1
		sw $v0,($s4)
		
		li $a0,8
		li $a1,16
		la $a2,mdArray
		la $a3,lista_indices
		jal selection_sort


		li $a2, 319
 		la $a0, equipo_1	
		jal index_input
		
		# $a0 contains the array of numbers
		# $a1 is the number to find
		# $v0, is the result index
		la $a0,lista_indices
		move $a1, $v0
		jal find_index_number #Encontrar la posicion de la fila a ingresar
		


		# $a0 is the result of the sub of the goals of eveyteam
		# $a1 is the row index of the first element
		# $a2 is the row index of the second element
		# $a3 is the direction of the matriz
		#$t9 is the goals of the first team
		li $a0,-2
		li $a1,0
		li $a2,1
		la $a3,mdArray
		li $t9,2
		jal update_values
		li $a0,8
		li $a1,16
		la $a2,mdArray
		la $a3,lista_indices
		jal selection_sort		

		
		
		
		
		
		
		
		


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

findLengthString2:
    li $t0, -1
    move $s0, $a0

    loop_fls2:
        lb $t1, 0($s0)
        beq $t1, 0, foundLength2

        addi $t0, $t0, 1
        addi $s0, $s0, 1
        j loop_fls2

    foundLength2:
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



#### Function to get and substring for and string

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
############################################

# $a2 is the lenght of the buffer that contains the alll string
# $a0 is the sub string
# $v0 is the return value
index_input:
    addi $sp,$sp,-4
    sw $ra,($sp)
    jal findLengthString2
    move $a3, $v0 # M
    sub $a2, $a2, $a3 # N-M
    
    lw $ra,($sp)
    addi $sp,$sp,4
    la $a0,equipos
    la $a1, equipo_1 
    addi $sp,$sp,-4
    sw $ra,($sp)
    jal subStringMatch
    div $v0,$v0,20
    lw $ra,($sp)
    addi $sp,$sp,4
    
    jr $ra
############################################333
# $a0 contains the array of numbers
# $a1 is the number to find
# $v0, is the result index
find_index_number:
	li $t0,0
	
	loop_find_number:
		mul $t1,$t0,4
		add $t1,$t1,$a0
		lw $t2,($t1)
		addi $t0,$t0,1
		bne $t2,$a1,loop_find_number
	addi $t0,$t0,-1
	move $v0,$t0
	jr $ra
	
############################################
# $a0 is the result of the sub of the goals of eveyteam
# $a1 is the row index of the first element
# $a2 is the row index of the second element
# $a3 is the direction of the matriz
# $t9 is the goals of the first team
update_values:
	bgt $a0,0,update_fw
	beq $a0,0,update_tie
	blt $a0,0,update_fs
	
	update_fw:
	#ACTUALIZACION DE EQUIPO 1
		mul $t0,$a1,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		# Actualizacion de PUNTOS
		lw $t1,0($t0)
		addi $t1,$t1,3
		sw $t1,0($t0)
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS GANADOS(PG)
		lw $t1,8($t0)
		addi $t1,$t1,1
		sw $t1,8($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sub $t1,$t1,$a0
		sw $t1,24($t0)	
		#ACTUALIZACION DE GOLES DE DIFERENCIA(GD)
		lw $t1,28($t0)
		add $t1,$t1,$a0
		sw $t1,28($t0)		
	#ACTUALIZACION DE EQUIPO 2
		mul $t0,$a2,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS PERDIDOS(PP)
		lw $t1,16($t0)
		addi $t1,$t1,1
		sw $t1,16($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		sub $t1,$t1,$a0
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sw $t1,24($t0)	
		#ACTUALIZACION DE GOLES DE DIFERENCIA(GD)
		lw $t1,28($t0)
		sub $t1,$t1,$a0
		sw $t1,28($t0)	
	jr $ra
	
	update_fs:
	
	#ACTUALIZACION DE EQUIPO 2
		mul $t0,$a2,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		# Actualizacion de PUNTOS
		lw $t1,0($t0)
		addi $t1,$t1,3
		sw $t1,0($t0)
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS GANADOS(PG)
		lw $t1,8($t0)
		addi $t1,$t1,1
		sw $t1,8($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		sub $t1,$t1,$a0
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sw $t1,24($t0)	
		#ACTUALIZACION DE GOLES DE DIFERENCIA(GD)
		lw $t1,28($t0)
		sub $t1,$t1,$a0
		sw $t1,28($t0)	
	
	#ACTUALIZACION DE EQUIPO 1
		mul $t0,$a1,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS PERDIDOS(PP)
		lw $t1,16($t0)
		addi $t1,$t1,1
		sw $t1,16($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sub $t1,$t1,$a0
		sw $t1,24($t0)	
		#ACTUALIZACION DE GOLES DE DIFERENCIA(GD)
		lw $t1,28($t0)
		add $t1,$t1,$a0
		sw $t1,28($t0)	
	jr $ra
	
	update_tie:
	
	#ACTUALIZACION DE EQUIPO 2
		mul $t0,$a2,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		# Actualizacion de PUNTOS
		lw $t1,0($t0)
		addi $t1,$t1,1
		sw $t1,0($t0)
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS EMPATADOS (PE)
		lw $t1,12($t0)
		addi $t1,$t1,1
		sw $t1,12($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		add $t1,$t1,$a0
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sw $t1,24($t0)	

	
	#ACTUALIZACION DE EQUIPO 1
		mul $t0,$a1,32
		add $t0,$t0,$a3  #Direccion de la fila en el arreglo
		# Actualizacion de PUNTOS
		lw $t1,0($t0)
		addi $t1,$t1,1
		sw $t1,0($t0)
		#ACTUALIZACION DE PARTIDOS JUGADOS(PJ)
		lw $t1,4($t0)
		addi $t1,$t1,1
		sw $t1,4($t0)
		#ACTUALIZACION DE PARTIDOS EMPATADOS (PE)
		lw $t1,12($t0)
		addi $t1,$t1,1
		sw $t1,12($t0)
		#ACTUALIZACION DE GOLES ANOTADOS (GF)
		lw $t1,20($t0)
		add $t1,$t1,$t9
		sw $t1,20($t0)	
		#ACTUALIZACION DE GOLES QUE LES HAN ANOTADOS(GC)
		lw $t1,24($t0)
		add $t1,$t1,$t9
		sub $t1,$t1,$a0
		sw $t1,24($t0)	

	jr $ra



#####Function to verify is a string is digit

# $a0 char val
# $a1 address pointer
# $a2 PERIOD_HIT_FLAG
# $a3 HAS_DIGITS_FLAG
isdigit:
	set_up: #test for 0th char == 45 or 46 or 48...57
		
		lb $a0,($a1)
		beq $a0,45,loop_3 # == '-'
		beq $a0,46,loop_3 # == '.'
		blt $a0,48,exit_false # isn't below the ascii range for chars '0'...'9'
		bgt $a0,57,exit_false # isn't above the ascii range for chars '0'...'9'
	loop_3:
		la $a3,1
		addi $a1,$a1,1
		lb $a0,($a1)
		beqz $a0,exit_true # test for \0 null char
		beq $a0,46,period_test #test for a duplicate period
		blt $a0,48,exit_false  #test for 
		bgt $a0,57,exit_false
		 #set the HAS_DIGITS flag. This line is only reached because the
			 #    tests for period and - both jump back to start. 
		j loop_3
 
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
	j loop_3

####Function to convert string to digit

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

################################################

# a0 is the number of columns
# a1 is the number of rows
# a2 is the address of the matrix
# a3 is the address of the columns
selection_sort:
   
   li $t1,0 #contador i
   
   move $t3,$a1
   addi $t3,$t3,-1 #MAX-1	
   
   loop_1:
   	
   	move $t0,$t1 #valor indiceMin
   	
   	mul $t5,$t1,4
   	mul $t5,$t5,$a0
   	
   	add $t5,$t5,$a2
   	
   	addi $t2,$t1,1 #contador j
   	lw $t9,($t5)
	
   	loop_2:
   	   	mul $t6,$t2,4
   		mul $t6,$t6,$a0
   		
   		add $t6,$t6,$a2
   		lw $s1,($t6)
   		
   		mul $s3,$t0,4
   		mul $s3,$s3,$a0
   		
   		add $s3,$s3,$a2
   		lw $s4,($s3)
   		
   		bgt $s1,$s4,reasign_index   		
   		j continue
   		
   		reasign_index:
   		    move $t0,$t2
   		
   		continue:
   	
   	addi $t2,$t2,1
   	bne $t2,$a1,loop_2
   	
   	
   	bne $t0,$t1,swap
   	j continue_2
   	swap:
   		addi $sp,$sp,-16
   		sw $t2,0($sp)
   		sw $t3,4($sp)
   		sw $t4,8($sp)
   		sw $t5,12($sp)
   		
   		mul $t2,$t1,4
   		add $t2,$t2,$a3
   		mul $t3,$t0,4
   		add $t3,$t3,$a3
   		
   		lw $t4,($t2)
   		lw $t5,($t3)
   		
   		sw $t4,($t3)
   		sw $t5,($t2)
   		
   		lw $t2,0($sp)
   		lw $t3,4($sp)
   		lw $t4,8($sp)
   		lw $t5,12($sp)	 		
   		addi $sp,$sp,16

   		
   			
   		li $t7,0
   		
   		
   		loop_columns:
   		move $s6,$t5
   		mul $s5,$t7,4  #numero de columna
   		
   		mul $t6,$t0,4 #numero de fila
   		mul $t6,$t6,$a0
   		add $t6,$t6,$s5
   		
   		add $t6,$t6,$a2
   		lw $s1,($t6)
   		
   		add $s6,$s6,$s5
   		
		addi $sp,$sp,-4
		
		sw $t9,($sp)
		lw $t9,($s6)
		sw $t9,($t6)
   		sw $s1,($s6) 	
	
		lw $t9,($sp)
		addi $sp,$sp,4
   		
  		
   		addi $t7,$t7,1
   		bne $t7,$a0,loop_columns
   		
   		
   	continue_2:
 
   addi $t1,$t1,1
   bne $t1,$t3,loop_1
   
   jr $ra
   


################################################

clean_buffer:
	sb $zero,0($a0)
	sb $zero,1($a0)
	sb $zero,2($a0)
	sb $zero,3($a0)
	sb $zero,4($a0)
	sb $zero,5($a0)
	sb $zero,6($a0)
	sb $zero,7($a0)
	sb $zero,8($a0)
	sb $zero,9($a0)
	sb $zero,10($a0)
	sb $zero,11($a0)
	sb $zero,12($a0)
	sb $zero,13($a0)
	sb $zero,14($a0)
	sb $zero,15($a0)
	sb $zero,16($a0)
	sb $zero,17($a0)
	sb $zero,18($a0)
	sb $zero,19($a0)
	sb $zero,20($a0)
	sb $zero,21($a0)
	sb $zero,22($a0)
	sb $zero,23($a0)
	sb $zero,24($a0)
	sb $zero,25($a0)
	sb $zero,26($a0)
	sb $zero,27($a0)
	sb $zero,28($a0)
	sb $zero,29($a0)
	sb $zero,30($a0)
	sb $zero,31($a0)
	sb $zero,32($a0)
	sb $zero,33($a0)
	sb $zero,34($a0)
	sb $zero,35($a0)
	sb $zero,36($a0)
	sb $zero,37($a0)
	sb $zero,38($a0)
	sb $zero,39($a0)

	 jr $ra 	
   
