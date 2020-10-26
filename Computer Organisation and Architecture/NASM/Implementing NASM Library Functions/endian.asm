section .data

	le db "Little Endian", 10
	be db "Big Endian", 10

section .text

	global _start

_start:
	mov r12, 0x12345678
	push r12
				; IN CASE OF LITTLE ENDIAN,
	pop r8w			;1234 is pushed to stack first, with higher address inside the stack
	pop r9w			;5678 is pushed next, with lower address inside the stack

	cmp r8w, 0x5678		;The one with lower address inside the stack should come first 
	je lil

big:
	mov rax, 1
	mov rdi, 1
	mov rsi, be
	mov rdx, 11
	syscall
	
	jmp End

lil:
	mov rax, 1
	mov rdi, 1
	mov rsi, le
	mov rdx, 14
	syscall

End:


	mov rax, 60
	mov rdi, 0
	syscall

