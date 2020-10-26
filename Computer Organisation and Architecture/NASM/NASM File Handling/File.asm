%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR 2
%define PROT_READ 0x1
%define PROT_WRITE  0x2
%define MAP_PRIVATE 0x2
%define MAP_SHARED 0x1

section .data
fname_source: db 'input.txt', 0
fname_destination: db 'output.txt', 0
buf: db 0

section .text

global _start

_start:

;1) Open an input file for READ operation.
	mov rax, 2
	mov rdi, fname_source
	mov rsi, O_RDONLY 	; Open file read only
	mov rdx, 0 			; We are not creating a file so this argument has no meaning
	syscall

;2) Create a mmap for the input file.	
	mov r8, rax 		; rax holds opened file descriptor it is the fourth argument of mmap
	mov rax, 9 			; mmap number
	mov rdi, 0 			; OS will choose mapping destination
	mov rsi, 4096 		; page size
	mov rdx, PROT_READ  ; region will be marked read only
	mov r10, MAP_PRIVATE; pages will not be shared
	mov r9, 0 			; offset inside SomeFile.txt
	syscall 			; now rax will point to mapped location

	push rax			;rax contains address of input mmap				;1st push

;3) Compute the size of the input file.
	mov rdi, rax
	call string_length
	mov r10, rax		;now r10 contains size of input file

	push r10			;now r10 contains size of input file  			;2nd push

;4) Create an output file.

;5) Open the output file for READ/WRITE operation.
	mov rax, 2
	mov rdi, fname_destination
	mov rsi, O_RDWR 	; Open file read/write
	mov rdx, 0 			; We are not creating a file so this argument has no meaning
	syscall

	push rax			;fd of output file 								;3rd push

;6) Call ftruncate system call (rax: 77; rdi: fd of output file; rsi: the size of the input file)
	mov rax, 77
	pop rdi																;3rd pop
	pop rsi																;2nd pop

	push rsi			;size of input file 							;4th push
	push rdi			;fd of output file 								;5th push

	syscall

;7) Create a mmap for the output file and consider MAP_SHARED.
	pop rax				; rax holds opened file descriptor it is the fourth argument of mmap	;5th pop

	mov r8, rax 		; rax holds opened file descriptor it is the fourth argument of mmap
	mov rax, 9 			; mmap number
	mov rdi, 0 			; OS will choose mapping destination
	mov rsi, 4096 		; page size
	mov rdx, PROT_WRITE ; region will be marked read only
	mov r10, MAP_SHARED ; pages will not be shared
	mov r9, 0 			; offset inside SomeFile.txt
	syscall 			; now rax will point to mapped location

	push rax			;rax contains address of output mmap									;6th push

;8) Copy data from the input file mmap to the output file mmap
	
	;Now 6th push contains address of output mmap
	;4th push contains size of input file
	;1st push contains address of input mmap

	;doing string copy here itself

	pop r13				;address of output mmap													;6th pop
	pop r14				;size of input file 													;4th pop
	pop r15				;address of input mmap													;1st pop
	push r13			;address of output mmap													;7th push

	mov r12, -1			;r12 is counter variable used

string_copy_loop:
	inc r12

	cmp r12, r14
	je copy_done

	add r13, r12
	add r15, r12

	mov r11, [r15]
	mov [r13], r11

	sub r13, r12
	sub r15, r12	

	jmp string_copy_loop

copy_done:

;9)unmap output mmap now 		
	mov rax, 11
	mov rsi, 4096
	pop rdi			;address of output mmap														;7th pop
	
	mov rax, 60
	mov rdi, 0
	syscall
	


string_length:
	xor rax, rax
.loop: cmp byte [rdi+rax], 0
	je .end
	inc rax
	jmp .loop
.end: ret

