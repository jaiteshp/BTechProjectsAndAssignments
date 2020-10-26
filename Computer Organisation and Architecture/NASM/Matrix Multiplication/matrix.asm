
;compilation: nasm -f elf64 -o matrix.o matrix.asm && ld -o matrix matrix.o && ./matrix

%include "io.inc"

section .data

	str1: dq "123135413513514", 0
	str2:dq "-5678", 0
	str3:dq "neg",10 , 0
	;dim:db 0
	strChr: db 0
	x: dq 3241
	uint: dq 0x0000000000000110
	int: dq -9999961234
	buf: db 0
	

section .text

global _start

_start:


; ---------1-------------------------

	

; ------------------------------------
	call read_Dimensions		;the dimensions of matrices are read into m1, n1, m2, n2 respectively

; ------------------------------------

	call read_mat1
	
	call read_mat2
 

;-------------------------------------

	
	;call print_mat1
	
	;call print_newline
	
	;call print_mat2

;-------------------------------------

	call matrix_product		

;-------------------------------------

	mov rax, 60
	mov rdi, 0	
	syscall

multiply_Matrices:

	mov r12, -1			;row index

product_row_loop:

	inc r12
	
	cmp r12, [m1]
	je pall_done
	mov r13, -1			;column index
	product_column_loop:
		inc r13

		cmp r13, [n2]
		je	product_columns_finished
		
		mov r10, -1	       ;subloop counter
		mov r8,  0			;contains sum
		product_sub_loop:
			
			inc r10

			cmp r10, [m2]
			je sub_loop_finished

			mov r9, 8
			mov rax, r9
			mul byte [n1]
			mul r12

			mov r14, rax

			mov rax, r9
			mul r10

			add r14, rax			;Now, r14 contains the final address of [r12][r10]th element



			mov rax, r9
			mul byte [n2]
			mul r10

			mov r15, rax

			mov rax, r9
			mul r13

			add r15, rax			;Now, r15 contains the final address of [r10][r13]th element



			mov rax, [mat2 + r15]
			mul qword [mat1 + r14]	;Both of them are multiplied and added to r8

			add r8, rax
						
			cmp r10, [n1]
			jl product_sub_loop

			sub_loop_finished:	;When inner third loop is completed, value in 'r8' which is an entry of resultant matrix, is printed to stdout

				push r12
				push r13
				push r10
				
				mov rdi, r8		;Printing the [r12][r13]th entry of resultant matrix here itself
				call print_num

				mov rdi, 32		;Printing a space 
				call print_char
		
				pop r10
				pop r13
				pop r12

		cmp r13, [n2]
		jl product_column_loop

	product_columns_finished:
		mov r13, -1

		push r12
		push r13
		push r10

		mov rdi, 10				;Printing a newline after a row of resultant matrix is printed
		call print_char

		pop r10
		pop r13
		pop r12

		cmp r12, [m1]
		jl product_row_loop


pall_done:
	ret

matrix_product:

	mov r10, [n1]
	mov r12, [m2]

	cmp r10, r12
	jne	CantBeMultiplied	

	call multiply_Matrices		;Called when matrices can be multiplied
	
	ret 

CantBeMultiplied:		
	
	mov rdi, 0						; 0 is printed when they can't be multiplied
	call print_num
	call print_newline
	ret

print_mat1:						; For knowing whether input is read and stored correctly (for debuggung) 
	mov r12, -1	;row index
	mov r13, -1	;column index
	
p1row_loop:
	inc r12
	
	cmp r12, [m1]
	je p1all_done

	p1column_loop:
		inc r13

		cmp r13, [n1]
		je	p1columns_finished
		
		mov rax, r13
		mov r9, 8
		mul r9
		mov r14, rax
		
		mov rax, [n1]
		mov r9, 8
		mul r9
		mul r12
		add r14, rax	;Now r14 contains reqd address

		push r12
		push r13
		push r14

		mov rdi, [mat1 + r14]
		call print_num
		
		mov rdi, 32
		call print_char	;call reading_number
		
		pop r14
		pop r13
		pop r12

		cmp r13, [n1]
		jl p1column_loop

	p1columns_finished:
		mov r13, -1

		push r12
		push r13
		push r14

		mov rdi, 10
		call print_char

		pop r14
		pop r13
		pop r12

		cmp r12, [m1]
		jl p1row_loop


p1all_done:
	ret


print_mat2:							; For knowing whether input is read and stored correctly (for debuggung) 
	mov r12, -1	;row index
	mov r13, -1	;column index



p2row_loop:
	inc r12
	
	cmp r12, [m2]
	je p2all_done

	p2column_loop:
		inc r13

		cmp r13, [n2]
		je	p2columns_finished
		
		mov rax, r13
		mov r9, 8
		mul r9
		mov r14, rax
		
		mov rax, [n2]
		mov r9, 8
		mul r9
		mul r12
		add r14, rax	;Now r14 contains reqd address

		push r12
		push r13
		push r14

		mov rdi, [mat2 + r14]
		call print_num
		
		mov rdi, 32
		call print_char	
	
		pop r14
		pop r13
		pop r12

		cmp r13, [n2]
		jl p2column_loop

	p2columns_finished:
		mov r13, -1

		push r12
		push r13
		push r14

		mov rdi, 10
		call print_char

		pop r14
		pop r13
		pop r12

		cmp r12, [m2]
		jl p2row_loop


p2all_done:
	ret

read_mat1:
	
	mov r12, -1	;row index
	mov r13, -1	;column index
	
r1row_loop:
	inc r12
	
	cmp r12, [m1]
	je r1all_done

	r1column_loop:
		inc r13

		cmp r13, [n1]
		je	r1columns_finished
		
		mov rax, r13
		mov r9, 8
		mul r9
		mov r14, rax
		
		mov rax, [n1]
		mov r9, 8
		mul r9
		mul r12
		add r14, rax	;Now r14 contains reqd address

		push r12
		push r13
		push r14

		call read_number
		pop r14
		mov [mat1 + r14], rax

		pop r13
		pop r12

		cmp r13, [n1]
		jl r1column_loop

	r1columns_finished:
		mov r13, -1

		cmp r12, [m1]
		jl r1row_loop


r1all_done:
	ret

read_mat2:
	
	mov r12, -1	;row index
	mov r13, -1	;column index
	
r2row_loop:
	inc r12
	
	cmp r12, [m2]
	je r2all_done

	r2column_loop:
		inc r13

		cmp r13, [n2]
		je	r2columns_finished
		
		mov rax, r13
		mov r9, 8
		mul r9
		mov r14, rax
		
		mov rax, [n2]
		mov r9, 8
		mul r9
		mul r12
		add r14, rax	;Now r14 contains reqd address

		push r12
		push r13
		push r14

		call read_number
		pop r14
		mov [mat2 + r14], rax

		pop r13
		pop r12

		cmp r13, [n2]
		jl r2column_loop

	r2columns_finished:
		mov r13, -1

		cmp r12, [m2]
		jl r2row_loop


r2all_done:
	ret
		
		
	

	

		


read_Dimensions:
	
	call read_number
	mov [m1], rax


	call read_number
	mov [n1], rax

	call read_number
	mov [m2], rax

	call read_number
	mov [n2], rax

	ret


read_number:			; uses str1 as a buffer for storing read string

	mov r12, str1
	inc r12
	

.reading_spaces:

	mov rax, 0
	mov rdi, 0
	mov rsi,  buf
	mov rdx, 1
	syscall

	cmp byte [buf], 33
	jl .reading_spaces

	jmp .reading_number_begin

.reading_number_begin:


	mov r13, str1	;address

	mov r14, 1	; index

	mov al, byte [buf]

	mov byte [r13], al


.reading_number:

	add r14, str1

	mov rax, 0
	mov rdi, 0
	mov rsi,  r14
	mov rdx, 1
	syscall

	cmp byte [r14], 32
	je .reading_number_end

	cmp byte [r14], 10
	je .reading_number_end

	sub r14, str1
	inc r14

	jmp .reading_number

.reading_number_end:
	 
	mov byte [r14], 0


	mov rdi, str1
	call parse_int
		

	ret

section .bss
	m1: resq 1
	m2: resq 1
	n1: resq 1
	n2: resq 1
	dim: resq 10
	mat1: resq 100
	mat2: resq 100
	






