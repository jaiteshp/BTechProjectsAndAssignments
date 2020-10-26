
;section .data

;	str1: dq "123135413513514", 0
;	str2:dq "-5678", 0
;	str3:dq "neg",10 , 0
;	strChr: db 0
;	x: dq 3241
;	uint: dq 0x0000000000000110
;	int: dq -9999961234
;	buf: db 0


;section .text

;global _start

;_start:
	;;Main function contains function calls in "COMMENTS" for testing
	;1---------------
;	mov rdi, str1
;	call string_length

;	call print_num	;prints the number stored in rdi
;	call print_newline
	
	;-----------------
	
	;2--------------
;	mov rdi, str1
;	call print_string
;	call print_newline
	
	;----------------

	;3--------------	
;	mov rdi, 77
;	call print_char
;	call print_newline	
	
	;---------------
	
	;4----------
;	call print_newline
	
	;--------------

	;5----------
;	call print_uint
	
	;-----------
	
	;6----------     
;	call print_int

	;------------
	
	;7-----------
;	call read_char
;	mov rdi, rax
;	call print_char
;	call print_newline
	

	
	;------------
	
	;8----------

;	mov rdi, inp	
;	mov rsi, 10
;	call read_word	;Word read is stored in inp which is a .bss variable 
	
;	mov rdi, rax
;	call print_string
;	call print_newline
	
	;---------


	;9----------
;	mov rdi, str1
;	call parse_uint
	
;	mov rdi,rax
;	call print_num
;	call print_newline
	
	;-------------

	;10----------
;	mov rdi, str2
;	call parse_int
	
;	mov rdi,rax
;	call print_num
;	call print_newline
	
	;---------------
	
	;11-----------
;	mov rdi, str2
;	mov rsi, str1
;	call string_equals
	
;	mov rdi,rax
;	call print_num
;	call print_newline
	
	;-------------
	
	
	;12----------	
;	mov rdi, str1
;	mov rsi, str2
;	mov rax, 20
;	call string_copy

;	mov rdi, rax
;	call print_string
;	call print_newline
	
	;-------------
	
	;13---------
;	mov rdi, 0
;	call exit
	
	;----------
	

;	mov rax, 60
;	mov rdi, 0	
;	syscall

;----END OF MAIN----

string_equals:
	mov r8, rdi	;first string address
	mov r9, rsi	;second string address

	push r8
	push r9

	mov rdi, r8
	call string_length
	mov r13, rax

	push r13
	

	mov rdi, r9
	call string_length
	mov r14, rax

	pop r13


	mov r15, -1

	pop r9
	pop r8

compareData:		
	inc r15

	add r8, r15
	add r9, r15

	mov r10, [r8]
	mov r11, [r9]
	
	cmp r10, r11
	jne diffLengths

	sub r8, r15
	sub r9, r15

	cmp r15, r14

	jne compareData
	
	cmp r15, r14		
	je sameStrings 
		
diffLengths:
	
	;mov rdi, 76
	;call print_char
	;call print_newline
	mov rax, 0

	ret

sameStrings:
	mov rax, 1

	ret
	

string_copy:
	mov r8, rdi	;address of source string
	mov r9, rsi	;address of dest buffer
	mov r10, rax	;size of buffer


	push r8
	push r9
	push r10

	mov rdi, r8
	call string_length
	mov r12, rax	;contains length of source string


	pop r10

	cmp r10, r12
	jl doesntFit

	;if string fits

	mov r13, -1
	
	pop r9
	pop r8

copyLoop:
	inc r13	;loop counter

	add r8, r13
	add r9, r13
breaknow:


	mov r11, [r8]
	mov [r9], r11

	
	sub r8, r13
	sub r9, r13

	cmp r13, r12
	je copyDone

	jmp copyLoop

copyDone:
	mov rax, r9
	
	ret

doesntFit:
	mov rax, 0
	
	ret


	
	

parse_int:
	mov r8, rdi	;r8 contains address of given string
	mov r9, 0 		; contains final answer
	mov r10, 10

	;mov r14b, [r8]
	;and r14, 0xf

	cmp byte [r8], 45
	je negative

	mov rdi, r8
	call parse_uint
	
	ret

negative:
	

	mov rdi, r8
	call string_length

	mov r13, rax	;r13 contains length of given string
	dec r13

	
	mov r12, 0	;loop variable
parse_intLoop:

	inc r12
	
	add r8, r12

	mov r14b, [r8]
	and r14, 0xf
	
	sub r8, r12

	mov rax, r9
	mul r10
	mov r9, rax

	add r9, r14

	cmp r12, r13
	jne parse_intLoop

parse_intEnd:

	;mov rdi, 45
	;call print_char 						;;;example great mistake that took me hours wasted

	mov rax, r9
	neg rax
	
	inc r13
	mov rdx, r13

	ret


parse_uint:
	mov r8, rdi	;r8 contains address of given string
	mov r9, 0 		; contains final answer
	mov r10, 10


	mov rdi, r8
	call string_length

	mov r13, rax	;r13 contains length of given string
	dec r13

	
	mov r12, -1	;loop variable
parse_uintLoop:

	inc r12
	
	add r8, r12

	mov r14b, [r8]
	and r14, 0xf
	
	sub r8, r12

	mov rax, r9
	mul r10
	mov r9, rax

	add r9, r14

	cmp r12, r13
	jne parse_uintLoop

parse_uintEnd:
	mov rax, r9
	inc r13
	mov rdx, r13

	ret
	



exit:
	mov rax, 60
	syscall

read_word:
	mov r13, 0	;current size of input buffer
	mov r12, rsi	; r12 contains size of buffer
	mov r14, rdi 	; r14 contains address of the buffer
	mov r15, r14	; contains address where the current input character has to be stored
	
	dec r15

rwLoop1:
	inc r13
	inc r15
	
	cmp r13, r12
	jg tooBig

	mov rax, 0
	mov rdi, 0
	mov rsi, r15 
	mov rdx, 1
	syscall

	cmp byte [r15], 32	
	je wordEnd

	;cmp byte [r15], 10	
	;je wordEnd


	cmp r13, r12
	jg tooBig

	jmp rwLoop1
	
tooBig:
	mov rax, 0

	
	ret

wordEnd:
	mov byte [r15], 0
	mov rax, r14
	
	ret


print_int:

	mov rdi, [int]	; prints the value from int number in data section

	cmp rdi, 0		; if given number is less than zero
	jl negate

	call print_num
	call print_newline

negate:			; if int is less than zero
	neg rdi
	mov r13, rdi
	mov rdi, 45	;to print minus sign first
	call print_char
	
	mov rdi, r13
	call print_num
	call print_newline

	ret	

	
print_uint:

	mov rdi, [uint]	; prints the value from uint number in data section
	call print_num
	call print_newline

	ret
	

read_char:

	mov rax, 0
	mov rdi, 0
	mov rsi, strChr	;strChr is single byte declared in data section
	mov rdx, 1
	syscall
		
	mov rax, [strChr]
	
	ret

print_string:
	mov r9, rdi

	call string_length
	
	mov rsi, r9
	mov rdx, rax	;string_length returns length of string in rax
	mov rax, 1
	mov rdi, 1
	syscall

	ret

print_char:		
	mov [buf], rdi		;buf is declared in section .data
	
	mov rax, 1
	mov rdi, 1
	mov rsi, buf
	mov rdx, 1
	syscall
	
	ret

print_newline:

	mov byte [buf], 10	;ascii code of newline character

	mov rax, 1
	mov rdi, 1
	mov rsi, buf
	mov rdx, 1
	syscall
	
	ret
	

string_length:		;length of string will be returned via rax
	mov r11, -1	
	mov r12, 0

.strl_loop:
	inc r11
	
	cmp byte [rdi + r11], 0
	jnz .strl_loop
	
	add r11, 0
	mov rdi, r11
	mov rax, r11
	
	ret




print_num:
	mov r12, rdi	; rdi contains given number
	mov rax, r12	; for initialdividend
	mov r13, 0		; r13 is used to count number of digits

	cmp r12, 0
	jl print_minus
	jmp positivenum
print_minus:
	mov rdi, 45
	call print_char

	neg r12

positivenum:

	

.loop:
	
	inc r13
	mov rdx, 0	  ;
	mov rax, r12	; moving dividend(previous quotient) to rax
	mov r10, 10		; moving divisor to r10
	div r10				
	mov r12, rax	; storing new quotient in r12
	push rdx			; rdx is remanider(digit), pushing digit to stack

	cmp r12, 0
	jnz .loop

.loop2:
	dec r13					; running loop2 for times = no.of digits in number
	pop r15
	mov rax, 1
	mov rdi, 1
	mov rdx, 1			; size of 1 character
	add r15, 48
	mov [buf], r15	; since rsi cant take from other registers
	mov rsi, buf	

	syscall					; for printing

	cmp r13, 0
	jnz .loop2		

	ret					; return to main function


     
section .bss

	inp resb 10
	

