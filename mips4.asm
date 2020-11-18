.data

entmsg: .asciiz "Enter a string:\n"
ui1: .space 20
counter: .space 20
outmsg: .asciiz "The value +5 is:\n"

.text
 main:
    #Printing the message
    li $v0, 4
    la $a0, entmsg
    syscall

    #Saving the text
    li $v0, 8
    la $a0, ui1
    li $a1, 20
    syscall
    #Count the length of the string 
    la $t0, ui1  # la means load address (so we load the address of str into $t0)  
        li $t3, 0    # $t1 is the counter. set it to 0  
 countChr:  
        lb $t2, 0($t0)  # Load the first byte from address in $t0  
        beqz $t2, pot   # if $t2 == 0 then go to label end  
        add $t0, $t0, 1      # else increment the address  
        add $t3, $t3, 1 # and increment the counter of course  
        j countChr      # finally loop  
 pot:


    li $t1, 1    # $t1 is the counter. set it to 1  
    li $t2, 0   #$t2 is the sum
    sub $t3, $t3, $t1
getint:  
    lbu $t0, ui1($t1)  # Load the first byte from address in $t0    
    beq $t1, $t3, end     #NULL terminator found
    addi $t0, $t0, -48   #converts t1's ascii value to dec value
    mul $t2, $t2, 10    #sum *= 10
    add $t2, $t2, $t0    #sum += array[s1]-'0'
    addi $t1, $t1, 1     #increment array address
    j getint      # finally loop  

    #in the loop take the ascii value of the char and then convert it to an int and then add it to the answer

end:
    #Add 5 to number
    addi $t2, $t2, 5

    #print out second message and text
    li $v0, 4
    la $a0, outmsg
    syscall

    #Print out number
    #Gets the right answer now I just need to be able to output it
    li $v0, 1
    add $a0, $zero, $t2
    syscall

    #Close program
    li $v0, 10
    syscall