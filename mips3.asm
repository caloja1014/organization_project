.text
.globl main

main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 8
    la $a0, strMain
    li $a1, 99
    syscall

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 8
    la $a0, strSub
    li $a1, 99
    syscall

    la $a0,strMain
    jal findLengthString
    move $a2, $v0

    la $a0, strSub
    jal findLengthString
    move $a3, $v0 # M
    sub $a2, $a2, $a3 # N-M
    

    la $a0, strMain
    la $a1, strSub 

    jal subStringMatch
    move $t1, $v0


    li $v0, 1
    move $a0, $t1
    syscall
    
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

.data

msg1: .asciiz "Enter Main String: "
msg2: .asciiz "Enter String to Check SubString: "

strMain: .space 100
strSub: .space 100
endline: .asciiz "\n"