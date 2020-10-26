	.text
	.globl	main
main:
	move $fp, $sp
	subu $sp, $sp, 44
	sw $ra, -4($fp)
	li $v1 16
	move $s0 $v1
	move $a0 $s0
	jal _halloc
	move $s0 $v0
	move $s0 $s0
	li $v1 12
	move $s1 $v1
	move $a0 $s1
	jal _halloc
	move $s1 $v0
	move $s1 $s1
	la $s2 LS_Init
	sw $s2, 12($s0)
	la $s2 LS_Search
	sw $s2, 8($s0)
	la $s2 LS_Print
	sw $s2, 4($s0)
	la $s2 LS_Start
	sw $s2, 0($s0)
	li $v1 4
	move $s2 $v1
	move $s2 $s2
L0: 
	li $v1 11
	move $s3 $v1
	sle $s3, $s2, $s3
	beqz $s3 L1
	add $s3, $s1, $s2
	li $v1 0
	move $s4 $v1
	sw $s4, 0($s3)
	li $v1 4
	move $s4 $v1
	add $s4, $s2, $s4
	move $s2 $s4
	b  L0
L1: 
	sw $s0, 0($s1)
	move $s1 $s1
	lw $s2, 0($s1)
	lw $s2, 0($s2)
	li $v1 10
	move $s0 $v1
	sw $t0,  0($sp) 
	sw $t1,  4($sp) 
	sw $t2,  8($sp) 
	sw $t3,  12($sp) 
	sw $t4,  16($sp) 
	sw $t5,  20($sp) 
	sw $t6,  24($sp) 
	sw $t7,  28($sp) 
	sw $t8,  32($sp) 
	sw $t9,  36($sp) 
	move $a0 $s1
	move $a1 $s0
	jalr $s2
	lw $t0,  0($sp) 
	lw $t1,  4($sp) 
	lw $t2,  8($sp) 
	lw $t3,  12($sp) 
	lw $t4,  16($sp) 
	lw $t5,  20($sp) 
	lw $t6,  24($sp) 
	lw $t7,  28($sp) 
	lw $t8,  32($sp) 
	lw $t9,  36($sp) 
	move $s0 $v0
	move $a0 $s0
	jal _print
	lw $ra, -4($fp)
	addu $sp, $sp, 44
	jr $ra

	.text
	.globl	LS_Start
LS_Start:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0,  0($sp) 
	sw $s1,  4($sp) 
	sw $s2,  8($sp) 
	sw $s3,  12($sp) 
	sw $s4,  16($sp) 
	sw $s5,  20($sp) 
	sw $s6,  24($sp) 
	sw $s7,  28($sp) 
	move $s1 $a0
	move $s0 $a1
	move $s2 $s1
	lw $s3, 0($s2)
	lw $s3, 12($s3)
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s2
	move $a1 $s0
	jalr $s3
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s3 $v0
	move $v1 $s3
	move $s3 $s1
	lw $s2, 0($s3)
	lw $s2, 4($s2)
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s3
	jalr $s2
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s2 $v0
	move $v1 $s2
	li $v1 9999
	move $s2 $v1
	move $a0 $s2
	jal _print
	move $s2 $s1
	lw $s3, 0($s2)
	lw $s3, 8($s3)
	li $v1 8
	move $s0 $v1
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s2
	move $a1 $s0
	jalr $s3
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s0 $v0
	move $a0 $s0
	jal _print
	move $s0 $s1
	lw $s3, 0($s0)
	lw $s3, 8($s3)
	li $v1 12
	move $s2 $v1
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s0
	move $a1 $s2
	jalr $s3
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s2 $v0
	move $a0 $s2
	jal _print
	move $s2 $s1
	lw $s3, 0($s2)
	lw $s3, 8($s3)
	li $v1 17
	move $s0 $v1
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s2
	move $a1 $s0
	jalr $s3
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s0 $v0
	move $a0 $s0
	jal _print
	move $s1 $s1
	lw $s0, 0($s1)
	lw $s0, 8($s0)
	li $v1 50
	move $s3 $v1
	sw $t0,  32($sp) 
	sw $t1,  36($sp) 
	sw $t2,  40($sp) 
	sw $t3,  44($sp) 
	sw $t4,  48($sp) 
	sw $t5,  52($sp) 
	sw $t6,  56($sp) 
	sw $t7,  60($sp) 
	sw $t8,  64($sp) 
	sw $t9,  68($sp) 
	move $a0 $s1
	move $a1 $s3
	jalr $s0
	lw $t0,  32($sp) 
	lw $t1,  36($sp) 
	lw $t2,  40($sp) 
	lw $t3,  44($sp) 
	lw $t4,  48($sp) 
	lw $t5,  52($sp) 
	lw $t6,  56($sp) 
	lw $t7,  60($sp) 
	lw $t8,  64($sp) 
	lw $t9,  68($sp) 
	move $s3 $v0
	move $a0 $s3
	jal _print
	li $v1 55
	move $s3 $v1
	move $v0 $s3
	lw $s0,  0($sp) 
	lw $s1,  4($sp) 
	lw $s2,  8($sp) 
	lw $s3,  12($sp) 
	lw $s4,  16($sp) 
	lw $s5,  20($sp) 
	lw $s6,  24($sp) 
	lw $s7,  28($sp) 
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	.text
	.globl	LS_Print
LS_Print:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0,  0($sp) 
	sw $s1,  4($sp) 
	sw $s2,  8($sp) 
	sw $s3,  12($sp) 
	sw $s4,  16($sp) 
	sw $s5,  20($sp) 
	sw $s6,  24($sp) 
	sw $s7,  28($sp) 
	move $s0 $a0
	li $v1 1
	move $s1 $v1
	move $s1 $s1
L2: 
	lw $s2, 8($s0)
	li $v1 1
	move $s3 $v1
	sub $s3, $s2, $s3
	sle $s3, $s1, $s3
	beqz $s3 L3
	lw $v1, 4($s0)
	li $v1 4
	move $s3 $v1
	mul $s3, $s1, $s3
	move $s3 $s3
	lw $s2, 4($s0)
	lw $s4, 0($s2)
	li $v1 1
	move $s5 $v1
	li $v1 1
	move $s6 $v1
	sub $s6, $s4, $s6
	sle $s6, $s3, $s6
	sub $s6, $s5, $s6
	beqz $s6 L4
	li $v0 4
	la $a0, str_er
	syscall
	li $v0, 10
	syscall
L4: 
	nop
	li $v1 4
	move $s6 $v1
	add $s6, $s3, $s6
	add $s6, $s2, $s6
	lw $s6, 0($s6)
	move $a0 $s6
	jal _print
	li $v1 1
	move $s6 $v1
	add $s6, $s1, $s6
	move $s1 $s6
	b  L2
L3: 
	nop
	li $v1 0
	move $s1 $v1
	move $v0 $s1
	lw $s0,  0($sp) 
	lw $s1,  4($sp) 
	lw $s2,  8($sp) 
	lw $s3,  12($sp) 
	lw $s4,  16($sp) 
	lw $s5,  20($sp) 
	lw $s6,  24($sp) 
	lw $s7,  28($sp) 
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	.text
	.globl	LS_Search
LS_Search:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0,  0($sp) 
	sw $s1,  4($sp) 
	sw $s2,  8($sp) 
	sw $s3,  12($sp) 
	sw $s4,  16($sp) 
	sw $s5,  20($sp) 
	sw $s6,  24($sp) 
	sw $s7,  28($sp) 
	move $s0 $a0
	move $s1 $a1
	li $v1 1
	move $s2 $v1
	move $s2 $s2
	li $v1 0
	move $s3 $v1
	move $v1 $s3
	li $v1 0
	move $s3 $v1
	move $s3 $s3
L5: 
	lw $s4, 8($s0)
	li $v1 1
	move $s5 $v1
	sub $s5, $s4, $s5
	sle $s5, $s2, $s5
	beqz $s5 L6
	lw $v1, 4($s0)
	li $v1 4
	move $s5 $v1
	mul $s5, $s2, $s5
	move $s5 $s5
	lw $s4, 4($s0)
	lw $s6, 0($s4)
	li $v1 1
	move $s7 $v1
	li $v1 1
	move $t0 $v1
	sub $t0, $s6, $t0
	sle $t0, $s5, $t0
	sub $t0, $s7, $t0
	beqz $t0 L7
	li $v0 4
	la $a0, str_er
	syscall
	li $v0, 10
	syscall
L7: 
	nop
	li $v1 4
	move $t0 $v1
	add $t0, $s5, $t0
	add $t0, $s4, $t0
	lw $t0, 0($t0)
	move $t0 $t0
	li $v1 1
	move $s4 $v1
	add $s4, $s1, $s4
	move $s4 $s4
	li $v1 1
	move $s5 $v1
	sub $s5, $s1, $s5
	sle $s5, $t0, $s5
	beqz $s5 L8
	li $v1 0
	move $s5 $v1
	move $v1 $s5
	b  L9
L8: 
	li $v1 1
	move $s5 $v1
	li $v1 1
	move $s7 $v1
	sub $s7, $s4, $s7
	sle $s7, $t0, $s7
	sub $s7, $s5, $s7
	beqz $s7 L10
	li $v1 0
	move $s7 $v1
	move $v1 $s7
	b  L11
L10: 
	li $v1 1
	move $s7 $v1
	move $v1 $s7
	li $v1 1
	move $s7 $v1
	move $s3 $s7
	lw $s7, 8($s0)
	move $s2 $s7
L11: 
	nop
L9: 
	nop
	li $v1 1
	move $s7 $v1
	add $s7, $s2, $s7
	move $s2 $s7
	b  L5
L6: 
	nop
	move $v0 $s3
	lw $s0,  0($sp) 
	lw $s1,  4($sp) 
	lw $s2,  8($sp) 
	lw $s3,  12($sp) 
	lw $s4,  16($sp) 
	lw $s5,  20($sp) 
	lw $s6,  24($sp) 
	lw $s7,  28($sp) 
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	.text
	.globl	LS_Init
LS_Init:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0,  0($sp) 
	sw $s1,  4($sp) 
	sw $s2,  8($sp) 
	sw $s3,  12($sp) 
	sw $s4,  16($sp) 
	sw $s5,  20($sp) 
	sw $s6,  24($sp) 
	sw $s7,  28($sp) 
	move $s1 $a0
	move $s0 $a1
	sw $s0, 8($s1)
	li $v1 1
	move $s2 $v1
	add $s2, $s0, $s2
	li $v1 4
	move $s3 $v1
	mul $s3, $s2, $s3
	move $a0 $s3
	jal _halloc
	move $s3 $v0
	move $s3 $s3
	li $v1 4
	move $s2 $v1
	move $s2 $s2
L12: 
	li $v1 1
	move $s4 $v1
	add $s4, $s0, $s4
	li $v1 4
	move $s5 $v1
	mul $s5, $s4, $s5
	li $v1 1
	move $s4 $v1
	sub $s4, $s5, $s4
	sle $s4, $s2, $s4
	beqz $s4 L13
	add $s4, $s3, $s2
	li $v1 0
	move $s5 $v1
	sw $s5, 0($s4)
	li $v1 4
	move $s5 $v1
	add $s5, $s2, $s5
	move $s2 $s5
	b  L12
L13: 
	li $v1 4
	move $s2 $v1
	mul $s2, $s0, $s2
	sw $s2, 0($s3)
	sw $s3, 4($s1)
	li $v1 1
	move $s3 $v1
	move $s3 $s3
	lw $s2, 8($s1)
	li $v1 1
	move $s0 $v1
	add $s0, $s2, $s0
	move $s0 $s0
L14: 
	lw $s2, 8($s1)
	li $v1 1
	move $s5 $v1
	sub $s5, $s2, $s5
	sle $s5, $s3, $s5
	beqz $s5 L15
	li $v1 2
	move $s5 $v1
	mul $s5, $s5, $s3
	move $s5 $s5
	li $v1 3
	move $s2 $v1
	sub $s2, $s0, $s2
	move $s2 $s2
	li $v1 1
	move $s4 $v1
	li $v1 4
	move $s6 $v1
	mul $s6, $s4, $s6
	move $s6 $s6
	add $s4, $s1, $s6
	lw $v1, 0($s4)
	li $v1 4
	move $s4 $v1
	mul $s4, $s3, $s4
	move $s4 $s4
	li $v1 1
	move $s7 $v1
	li $v1 4
	move $t0 $v1
	mul $t0, $s7, $t0
	move $s6 $t0
	add $s6, $s1, $s6
	lw $s6, 0($s6)
	lw $t0, 0($s6)
	li $v1 1
	move $s7 $v1
	li $v1 1
	move $t1 $v1
	sub $t1, $t0, $t1
	sle $t1, $s4, $t1
	sub $t1, $s7, $t1
	beqz $t1 L16
	li $v0 4
	la $a0, str_er
	syscall
	li $v0, 10
	syscall
L16: 
	nop
	li $v1 4
	move $t1 $v1
	add $t1, $s4, $t1
	add $t1, $s6, $t1
	add $s2, $s5, $s2
	sw $s2, 0($t1)
	li $v1 1
	move $s2 $v1
	add $s2, $s3, $s2
	move $s3 $s2
	li $v1 1
	move $s2 $v1
	sub $s2, $s0, $s2
	move $s0 $s2
	b  L14
L15: 
	nop
	li $v1 0
	move $s0 $v1
	move $v0 $s0
	lw $s0,  0($sp) 
	lw $s1,  4($sp) 
	lw $s2,  8($sp) 
	lw $s3,  12($sp) 
	lw $s4,  16($sp) 
	lw $s5,  20($sp) 
	lw $s6,  24($sp) 
	lw $s7,  28($sp) 
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra

	.text
	.globl	_halloc
_halloc:
	li $v0, 9
	syscall
	jr $ra

	.text
	.globl	_print
_print:
	li $v0, 1
	syscall
	la $a0, newl
	li $v0, 4
	syscall
	jr $ra

	.data
	.align   0
newl:   .asciiz "\n"
	.data
	.align   0
str_er: .asciiz " ERROR: abnormal termination\n "
