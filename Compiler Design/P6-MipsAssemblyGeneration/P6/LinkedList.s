	.text
	.globl main
main:
	move $fp, $sp
	subu $sp, $sp, 44
	sw $ra, -4($fp)
	li $v1, 4
	move $s0, $v1
	move $a0, $s0
	jal _halloc
	move $s0, $v0
	move $s0, $s0
	li $v1, 4
	move $s1, $v1
	move $a0, $s1
	jal _halloc
	move $s1, $v0
	move $s1, $s1
	la $s2, LL_Start
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s1, $s1
	lw $s0, 0($s1)
	lw $s0, 0($s0)
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	sw $t7, 28($sp)
	sw $t8, 32($sp)
	sw $t9, 36($sp)
	move $a0, $s1
	jalr $s0
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	lw $t6, 24($sp)
	lw $t7, 28($sp)
	lw $t8, 32($sp)
	lw $t9, 36($sp)
	move $s0, $v0
	move $a0 $s0
	jal _print
	lw $ra, -4($fp)
	addu $sp, $sp, 44
	jr $ra
	 
	.text
	.globl Element_Init
Element_Init:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s2, $a0
	move $s0, $a1
	move $s1, $a2
	move $s3, $a3
	sw $s0, 4($s2)
	sw $s1, 8($s2)
	sw $s3, 12($s2)
	li $v1, 1
	move $s3, $v1
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl Element_GetAge
Element_GetAge:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 4($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl Element_GetSalary
Element_GetSalary:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 8($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl Element_GetMarried
Element_GetMarried:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 12($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl Element_Equal
Element_Equal:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $a1
	li $v1, 1
	move $s2, $v1
	move $s2, $s2
	move $s3, $s1
	lw $s4, 0($s3)
	lw $s4, 4($s4)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s4
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	move $s4, $s4
	li $v1, 1
	move $s3, $v1
	move $s5, $s0
	lw $s6, 0($s5)
	lw $s6, 20($s6)
	lw $s7, 4($s0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s5
	move $a1, $s4
	move $a2, $s7
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s7, $v0
	sub $s7, $s3, $s7
	beqz $s7 L2
	li $v1, 0
	move $s7, $v1
	move $s2, $s7
	b L3
L2:
	move $s7, $s1
	lw $s3, 0($s7)
	lw $s3, 8($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s7
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s3, $s3
	li $v1, 1
	move $s7, $v1
	move $s6, $s0
	lw $s5, 0($s6)
	lw $s5, 20($s5)
	lw $s4, 8($s0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s3
	move $a2, $s4
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	sub $s4, $s7, $s4
	beqz $s4 L4
	li $v1, 0
	move $s0, $v1
	move $s2, $s0
	b L5
L4:
	lw $s0, 12($s0)
	beqz $s0 L6
	li $v1, 1
	move $s0, $v1
	move $s1, $s1
	lw $s4, 0($s1)
	lw $s4, 12($s4)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s1
	jalr $s4
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	sub $s4, $s0, $s4
	beqz $s4 L8
	li $v1, 0
	move $s4, $v1
	move $s2, $s4
	b L9
L8:
	li $v1, 0
	move $s4, $v1
	move $v1, $s4
L9:
	nop
	b L7
L6:
	move $s4, $s1
	lw $s0, 0($s4)
	lw $s0, 12($s0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	jalr $s0
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s0, $v0
	beqz $s0 L10
	li $v1, 0
	move $s0, $v1
	move $s2, $s0
	b L11
L10:
	li $v1, 0
	move $s0, $v1
	move $v1, $s0
L11:
	nop
L7:
	nop
L5:
	nop
L3:
	nop
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	 
	.text
	.globl Element_Compare
Element_Compare:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $v1, $a0
	move $s1, $a1
	move $s0, $a2
	li $v1, 0
	move $s2, $v1
	move $v1, $s2
	li $v1, 1
	move $s2, $v1
	add $s2, $s0, $s2
	move $s2, $s2
	li $v1, 1
	move $s3, $v1
	sub $s3, $s0, $s3
	sle $s3, $s1, $s3
	beqz $s3 L12
	li $v1, 0
	move $s3, $v1
	move $s3, $s3
	b L13
L12:
	li $v1, 1
	move $s0, $v1
	li $v1, 1
	move $s4, $v1
	sub $s4, $s2, $s4
	sle $s4, $s1, $s4
	sub $s4, $s0, $s4
	beqz $s4 L14
	li $v1, 0
	move $s4, $v1
	move $s3, $s4
	b L15
L14:
	li $v1, 1
	move $s4, $v1
	move $s3, $s4
L15:
	nop
L13:
	nop
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_Init
List_Init:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	li $v1, 1
	move $s1, $v1
	sw $s1, 12($s0)
	li $v1, 1
	move $s1, $v1
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_InitNew
List_InitNew:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s2, $a0
	move $s1, $a1
	move $s3, $a2
	move $s0, $a3
	sw $s0, 12($s2)
	sw $s1, 4($s2)
	sw $s3, 8($s2)
	li $v1, 1
	move $s3, $v1
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_Insert
List_Insert:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $a1
	move $s0, $s0
	li $v1, 40
	move $s2, $v1
	move $a0, $s2
	jal _halloc
	move $s2, $v0
	move $s2, $s2
	li $v1, 16
	move $s3, $v1
	move $a0, $s3
	jal _halloc
	move $s3, $v0
	move $s3, $s3
	la $s4, List_Print
	sw $s4, 36($s2)
	la $s4, List_GetNext
	sw $s4, 32($s2)
	la $s4, List_GetElem
	sw $s4, 28($s2)
	la $s4, List_GetEnd
	sw $s4, 24($s2)
	la $s4, List_Search
	sw $s4, 20($s2)
	la $s4, List_Delete
	sw $s4, 16($s2)
	la $s4, List_SetNext
	sw $s4, 12($s2)
	la $s4, List_Insert
	sw $s4, 8($s2)
	la $s4, List_InitNew
	sw $s4, 4($s2)
	la $s4, List_Init
	sw $s4, 0($s2)
	li $v1, 4
	move $s4, $v1
	move $s4, $s4
L16:
	li $v1, 15
	move $s5, $v1
	sle $s5, $s4, $s5
	beqz $s5 L17
	add $s5, $s3, $s4
	li $v1, 0
	move $s6, $v1
	sw $s6, 0($s5)
	li $v1, 4
	move $s6, $v1
	add $s6, $s4, $s6
	move $s4, $s6
	b L16
L17:
	sw $s2, 0($s3)
	move $s3, $s3
	move $s4, $s3
	lw $s2, 0($s4)
	lw $s2, 4($s2)
	li $v1, 0
	move $s6, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	move $a1, $s1
	move $a2, $s0
	move $a3, $s6
	jalr $s2
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	 
	.text
	.globl List_SetNext
List_SetNext:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 8($s0)
	li $v1, 1
	move $s1, $v1
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_Delete
List_Delete:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $a1
	move $s2, $s0
	li $v1, 0
	move $s3, $v1
	move $s3, $s3
	li $v1, 0
	move $s4, $v1
	li $v1, 1
	move $s5, $v1
	sub $s5, $s4, $s5
	move $s5, $s5
	move $s4, $s0
	move $s6, $s0
	lw $s7, 12($s0)
	move $s7, $s7
	lw $s0, 4($s0)
	move $s0, $s0
L18:
	li $v1, 0
	move $t0, $v1
	move $t0, $t0
	li $v1, 1
	move $t1, $v1
	sub $t1, $t1, $s7
	beqz $t1 L20
	li $v1, 1
	move $t1, $v1
	sub $t1, $t1, $s3
	beqz $t1 L20
	li $v1, 1
	move $t1, $v1
	move $t0, $t1
L20:
	nop
	beqz $t0 L19
	move $t0, $s1
	lw $t1, 0($t0)
	lw $t1, 16($t1)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t0
	move $a1, $s0
	jalr $t1
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t1, $v0
	beqz $t1 L21
	li $v1, 1
	move $t1, $v1
	move $s3, $t1
	li $v1, 0
	move $t1, $v1
	move $t1, $t1
	li $v1, 1
	move $t0, $v1
	sub $t0, $t1, $t0
	move $t0, $t0
	sle $t0, $s5, $t0
	beqz $t0 L23
	move $t0, $s4
	lw $t1, 0($t0)
	lw $t1, 32($t1)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t0
	jalr $t1
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t1, $v0
	move $s2, $t1
	b L24
L23:
	li $v1, 0
	move $t1, $v1
	li $v1, 555
	move $t0, $v1
	sub $t0, $t1, $t0
	move $a0 $t0
	jal _print
	move $t0, $s6
	lw $t1, 0($t0)
	lw $t1, 12($t1)
	move $t2, $s4
	lw $t3, 0($t2)
	lw $t3, 32($t3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t2
	jalr $t3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t3, $v0
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t0
	move $a1, $t3
	jalr $t1
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t3, $v0
	move $v1, $t3
	li $v1, 0
	move $t3, $v1
	li $v1, 555
	move $t1, $v1
	sub $t1, $t3, $t1
	move $a0 $t1
	jal _print
L24:
	nop
	b L22
L21:
	li $v1, 0
	move $t1, $v1
	move $v1, $t1
L22:
	nop
	li $v1, 1
	move $t1, $v1
	sub $t1, $t1, $s3
	beqz $t1 L25
	move $s6, $s4
	move $t1, $s4
	lw $t3, 0($t1)
	lw $t3, 32($t3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t1
	jalr $t3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t3, $v0
	move $s4, $t3
	move $t3, $s4
	lw $t1, 0($t3)
	lw $t1, 24($t1)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t3
	jalr $t1
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t1, $v0
	move $s7, $t1
	move $t1, $s4
	lw $t3, 0($t1)
	lw $t3, 28($t3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t1
	jalr $t3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t3, $v0
	move $s0, $t3
	li $v1, 1
	move $t3, $v1
	move $s5, $t3
	b L26
L25:
	li $v1, 0
	move $t3, $v1
	move $v1, $t3
L26:
	nop
	b L18
L19:
	nop
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	 
	.text
	.globl List_Search
List_Search:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $a1
	li $v1, 0
	move $s2, $v1
	move $s2, $s2
	move $s3, $s0
	lw $s4, 12($s0)
	move $s4, $s4
	lw $s0, 4($s0)
	move $s0, $s0
L27:
	li $v1, 1
	move $s5, $v1
	sub $s5, $s5, $s4
	beqz $s5 L28
	move $s5, $s1
	lw $s6, 0($s5)
	lw $s6, 16($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s5
	move $a1, $s0
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	beqz $s6 L29
	li $v1, 1
	move $s6, $v1
	move $s2, $s6
	b L30
L29:
	li $v1, 0
	move $s6, $v1
	move $v1, $s6
L30:
	nop
	move $s6, $s3
	lw $s5, 0($s6)
	lw $s5, 32($s5)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s5, $v0
	move $s3, $s5
	move $s5, $s3
	lw $s6, 0($s5)
	lw $s6, 24($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s5
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $s4, $s6
	move $s6, $s3
	lw $s5, 0($s6)
	lw $s5, 28($s5)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s5, $v0
	move $s0, $s5
	b L27
L28:
	nop
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	 
	.text
	.globl List_GetEnd
List_GetEnd:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 12($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_GetElem
List_GetElem:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 4($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_GetNext
List_GetNext:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 40
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	lw $s0, 8($s0)
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 32($sp)
	addu $sp, $sp, 40
	jr $ra
	 
	.text
	.globl List_Print
List_Print:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $s0
	lw $s2, 12($s0)
	move $s2, $s2
	lw $s0, 4($s0)
	move $s0, $s0
L31:
	li $v1, 1
	move $s3, $v1
	sub $s3, $s3, $s2
	beqz $s3 L32
	move $s3, $s0
	lw $s4, 0($s3)
	lw $s4, 4($s4)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s4
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	move $a0 $s4
	jal _print
	move $s4, $s1
	lw $s3, 0($s4)
	lw $s3, 32($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s1, $s3
	move $s3, $s1
	lw $s4, 0($s3)
	lw $s4, 24($s4)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s4
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	move $s2, $s4
	move $s4, $s1
	lw $s3, 0($s4)
	lw $s3, 28($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s0, $s3
	b L31
L32:
	nop
	li $v1, 1
	move $s0, $v1
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
	jr $ra
	 
	.text
	.globl LL_Start
LL_Start:
	sw $fp, -8($sp)
	move $fp, $sp
	subu $sp, $sp, 80
	sw $ra, -4($fp)
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $v1, $a0
	li $v1, 40
	move $s0, $v1
	move $a0, $s0
	jal _halloc
	move $s0, $v0
	move $s0, $s0
	li $v1, 16
	move $s1, $v1
	move $a0, $s1
	jal _halloc
	move $s1, $v0
	move $s1, $s1
	la $s2, List_Print
	sw $s2, 36($s0)
	la $s2, List_GetNext
	sw $s2, 32($s0)
	la $s2, List_GetElem
	sw $s2, 28($s0)
	la $s2, List_GetEnd
	sw $s2, 24($s0)
	la $s2, List_Search
	sw $s2, 20($s0)
	la $s2, List_Delete
	sw $s2, 16($s0)
	la $s2, List_SetNext
	sw $s2, 12($s0)
	la $s2, List_Insert
	sw $s2, 8($s0)
	la $s2, List_InitNew
	sw $s2, 4($s0)
	la $s2, List_Init
	sw $s2, 0($s0)
	li $v1, 4
	move $s2, $v1
	move $s2, $s2
L33:
	li $v1, 15
	move $s3, $v1
	sle $s3, $s2, $s3
	beqz $s3 L34
	add $s3, $s1, $s2
	li $v1, 0
	move $s4, $v1
	sw $s4, 0($s3)
	li $v1, 4
	move $s4, $v1
	add $s4, $s2, $s4
	move $s2, $s4
	b L33
L34:
	sw $s0, 0($s1)
	move $s1, $s1
	move $s2, $s1
	lw $s0, 0($s2)
	lw $s0, 0($s0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s2
	jalr $s0
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s0, $v0
	move $v1, $s0
	move $s1, $s1
	move $s0, $s1
	lw $s2, 0($s0)
	lw $s2, 0($s2)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s0
	jalr $s2
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s2, $v0
	move $v1, $s2
	move $s2, $s1
	lw $s0, 0($s2)
	lw $s0, 36($s0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s2
	jalr $s0
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s0, $v0
	move $v1, $s0
	li $v1, 24
	move $s0, $v1
	move $a0, $s0
	jal _halloc
	move $s0, $v0
	move $s0, $s0
	li $v1, 16
	move $s2, $v1
	move $a0, $s2
	jal _halloc
	move $s2, $v0
	move $s2, $s2
	la $s4, Element_Compare
	sw $s4, 20($s0)
	la $s4, Element_Equal
	sw $s4, 16($s0)
	la $s4, Element_GetMarried
	sw $s4, 12($s0)
	la $s4, Element_GetSalary
	sw $s4, 8($s0)
	la $s4, Element_GetAge
	sw $s4, 4($s0)
	la $s4, Element_Init
	sw $s4, 0($s0)
	li $v1, 4
	move $s4, $v1
	move $s4, $s4
L35:
	li $v1, 15
	move $s3, $v1
	sle $s3, $s4, $s3
	beqz $s3 L36
	add $s3, $s2, $s4
	li $v1, 0
	move $s5, $v1
	sw $s5, 0($s3)
	li $v1, 4
	move $s5, $v1
	add $s5, $s4, $s5
	move $s4, $s5
	b L35
L36:
	sw $s0, 0($s2)
	move $s2, $s2
	move $s4, $s2
	lw $s0, 0($s4)
	lw $s0, 0($s0)
	li $v1, 25
	move $s5, $v1
	li $v1, 37000
	move $s3, $v1
	li $v1, 0
	move $s6, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	move $a1, $s5
	move $a2, $s3
	move $a3, $s6
	jalr $s0
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	move $s6, $s1
	lw $s3, 0($s6)
	lw $s3, 8($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s2
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s1, $s3
	move $s3, $s1
	lw $s6, 0($s3)
	lw $s6, 36($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	li $v1, 10000000
	move $s6, $v1
	move $a0 $s6
	jal _print
	li $v1, 24
	move $s6, $v1
	move $a0, $s6
	jal _halloc
	move $s6, $v0
	move $s6, $s6
	li $v1, 16
	move $s3, $v1
	move $a0, $s3
	jal _halloc
	move $s3, $v0
	move $s3, $s3
	la $s5, Element_Compare
	sw $s5, 20($s6)
	la $s5, Element_Equal
	sw $s5, 16($s6)
	la $s5, Element_GetMarried
	sw $s5, 12($s6)
	la $s5, Element_GetSalary
	sw $s5, 8($s6)
	la $s5, Element_GetAge
	sw $s5, 4($s6)
	la $s5, Element_Init
	sw $s5, 0($s6)
	li $v1, 4
	move $s5, $v1
	move $s5, $s5
L37:
	li $v1, 15
	move $s0, $v1
	sle $s0, $s5, $s0
	beqz $s0 L38
	add $s0, $s3, $s5
	li $v1, 0
	move $s4, $v1
	sw $s4, 0($s0)
	li $v1, 4
	move $s4, $v1
	add $s4, $s5, $s4
	move $s5, $s4
	b L37
L38:
	sw $s6, 0($s3)
	move $s2, $s3
	move $s3, $s2
	lw $s5, 0($s3)
	lw $s5, 0($s5)
	li $v1, 39
	move $s6, $v1
	li $v1, 42000
	move $s4, $v1
	li $v1, 1
	move $s0, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	move $a1, $s6
	move $a2, $s4
	move $a3, $s0
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s0, $v0
	move $v1, $s0
	move $s0, $s2
	move $s4, $s1
	lw $s6, 0($s4)
	lw $s6, 8($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	move $a1, $s2
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $s1, $s6
	move $s6, $s1
	lw $s4, 0($s6)
	lw $s4, 36($s4)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	jalr $s4
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	move $v1, $s4
	li $v1, 10000000
	move $s4, $v1
	move $a0 $s4
	jal _print
	li $v1, 24
	move $s4, $v1
	move $a0, $s4
	jal _halloc
	move $s4, $v0
	move $s4, $s4
	li $v1, 16
	move $s6, $v1
	move $a0, $s6
	jal _halloc
	move $s6, $v0
	move $s6, $s6
	la $s5, Element_Compare
	sw $s5, 20($s4)
	la $s5, Element_Equal
	sw $s5, 16($s4)
	la $s5, Element_GetMarried
	sw $s5, 12($s4)
	la $s5, Element_GetSalary
	sw $s5, 8($s4)
	la $s5, Element_GetAge
	sw $s5, 4($s4)
	la $s5, Element_Init
	sw $s5, 0($s4)
	li $v1, 4
	move $s5, $v1
	move $s5, $s5
L39:
	li $v1, 15
	move $s3, $v1
	sle $s3, $s5, $s3
	beqz $s3 L40
	add $s3, $s6, $s5
	li $v1, 0
	move $s7, $v1
	sw $s7, 0($s3)
	li $v1, 4
	move $s7, $v1
	add $s7, $s5, $s7
	move $s5, $s7
	b L39
L40:
	sw $s4, 0($s6)
	move $s2, $s6
	move $s6, $s2
	lw $s5, 0($s6)
	lw $s5, 0($s5)
	li $v1, 22
	move $s4, $v1
	li $v1, 34000
	move $s7, $v1
	li $v1, 0
	move $s3, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s4
	move $a2, $s7
	move $a3, $s3
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $v1, $s3
	move $s3, $s1
	lw $s7, 0($s3)
	lw $s7, 8($s7)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	move $a1, $s2
	jalr $s7
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s7, $v0
	move $s1, $s7
	move $s7, $s1
	lw $s3, 0($s7)
	lw $s3, 36($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s7
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $v1, $s3
	li $v1, 24
	move $s3, $v1
	move $a0, $s3
	jal _halloc
	move $s3, $v0
	move $s3, $s3
	li $v1, 16
	move $s7, $v1
	move $a0, $s7
	jal _halloc
	move $s7, $v0
	move $s7, $s7
	la $s4, Element_Compare
	sw $s4, 20($s3)
	la $s4, Element_Equal
	sw $s4, 16($s3)
	la $s4, Element_GetMarried
	sw $s4, 12($s3)
	la $s4, Element_GetSalary
	sw $s4, 8($s3)
	la $s4, Element_GetAge
	sw $s4, 4($s3)
	la $s4, Element_Init
	sw $s4, 0($s3)
	li $v1, 4
	move $s4, $v1
	move $s4, $s4
L41:
	li $v1, 15
	move $s5, $v1
	sle $s5, $s4, $s5
	beqz $s5 L42
	add $s5, $s7, $s4
	li $v1, 0
	move $s6, $v1
	sw $s6, 0($s5)
	li $v1, 4
	move $s6, $v1
	add $s6, $s4, $s6
	move $s4, $s6
	b L41
L42:
	sw $s3, 0($s7)
	move $s7, $s7
	move $s4, $s7
	lw $s3, 0($s4)
	lw $s3, 0($s3)
	li $v1, 27
	move $s6, $v1
	li $v1, 34000
	move $s5, $v1
	li $v1, 0
	move $t0, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s4
	move $a1, $s6
	move $a2, $s5
	move $a3, $t0
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t0, $v0
	move $v1, $t0
	move $t0, $s1
	lw $s5, 0($t0)
	lw $s5, 20($s5)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $t0
	move $a1, $s0
	jalr $s5
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s5, $v0
	move $a0 $s5
	jal _print
	move $s5, $s1
	lw $t0, 0($s5)
	lw $t0, 20($t0)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s5
	move $a1, $s7
	jalr $t0
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $t0, $v0
	move $a0 $t0
	jal _print
	li $v1, 10000000
	move $t0, $v1
	move $a0 $t0
	jal _print
	li $v1, 24
	move $t0, $v1
	move $a0, $t0
	jal _halloc
	move $t0, $v0
	move $t0, $t0
	li $v1, 16
	move $s5, $v1
	move $a0, $s5
	jal _halloc
	move $s5, $v0
	move $s5, $s5
	la $s7, Element_Compare
	sw $s7, 20($t0)
	la $s7, Element_Equal
	sw $s7, 16($t0)
	la $s7, Element_GetMarried
	sw $s7, 12($t0)
	la $s7, Element_GetSalary
	sw $s7, 8($t0)
	la $s7, Element_GetAge
	sw $s7, 4($t0)
	la $s7, Element_Init
	sw $s7, 0($t0)
	li $v1, 4
	move $s7, $v1
	move $s7, $s7
L43:
	li $v1, 15
	move $s6, $v1
	sle $s6, $s7, $s6
	beqz $s6 L44
	add $s6, $s5, $s7
	li $v1, 0
	move $s3, $v1
	sw $s3, 0($s6)
	li $v1, 4
	move $s3, $v1
	add $s3, $s7, $s3
	move $s7, $s3
	b L43
L44:
	sw $t0, 0($s5)
	move $s2, $s5
	move $s5, $s2
	lw $s7, 0($s5)
	lw $s7, 0($s7)
	li $v1, 28
	move $t0, $v1
	li $v1, 35000
	move $s3, $v1
	li $v1, 0
	move $s6, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s5
	move $a1, $t0
	move $a2, $s3
	move $a3, $s6
	jalr $s7
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	move $s6, $s1
	lw $s3, 0($s6)
	lw $s3, 8($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s2
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s1, $s3
	move $s3, $s1
	lw $s6, 0($s3)
	lw $s6, 36($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	li $v1, 2220000
	move $s6, $v1
	move $a0 $s6
	jal _print
	move $s6, $s1
	lw $s3, 0($s6)
	lw $s3, 16($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s0
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s1, $s3
	move $s3, $s1
	lw $s6, 0($s3)
	lw $s6, 36($s6)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s3
	jalr $s6
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s6, $v0
	move $v1, $s6
	li $v1, 33300000
	move $s6, $v1
	move $a0 $s6
	jal _print
	move $s6, $s1
	lw $s3, 0($s6)
	lw $s3, 16($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s6
	move $a1, $s2
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $s1, $s3
	move $s1, $s1
	lw $s3, 0($s1)
	lw $s3, 36($s3)
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s1
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s3, $v0
	move $v1, $s3
	li $v1, 44440000
	move $s3, $v1
	move $a0 $s3
	jal _print
	li $v1, 0
	move $s3, $v1
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, -4($fp)
	lw $fp, 72($sp)
	addu $sp, $sp, 80
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
