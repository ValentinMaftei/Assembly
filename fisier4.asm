.data
	v: .space 1650
	vrotate: .space 1650
	lin: .space 4
	col: .space 4
	aux: .space 4
	str: .space 300
	delim: .asciz " "
	res: .space 4
	index: .space 4
	index2: .space 4
	indexlin: .space 4
	indexcol: .space 4
	indexmat: .space 4
	x: .space 4
	formatPrintf: .asciz "%d "
	formatScanf: .asciz "%[^\n]"
	NULL: .asciz "\n"
	formatPrintf0: .asciz "%s"
	
.text

.global main

main: 

	pushl $str
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $delim
	pushl $str
	call strtok 
	popl %ebx
	popl %ebx
	
	lea v, %edi
	xorl %ecx, %ecx
	movl %ecx, index
	
et_for:
	
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je exit
	
	movl %eax, %esi
	xorl %ecx, %ecx
	movb (%esi, %ecx, 1), %dl
	cmp $48, %dl
	je numarzero
	
	movl %eax, res
	pushl res
	call atoi
	popl %ebx

	cmp $0, %eax
	je op_let
	jne numar
	
numarzero:

	movl index, %ecx
	movl $0, (%edi, %ecx, 4)
	incl %ecx
	movl %ecx, index
	
	jmp et_for
	
numar:
	movl lin, %edx
	cmp $0, %edx
	je linii
	
	movl col, %edx
	cmp $0, %edx
	je coloane
	
	movl index, %ecx
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	movl %ecx, index
	
	jmp et_for
	
linii:
	movl %eax, lin
	jmp et_for
	
coloane:
	movl %eax, col
	jmp et_for

op_let:

	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je exit	
	
	movl %eax, %esi
	xorl %ecx, %ecx
	movb (%esi, %ecx, 1), %dl
	cmp $48, %dl
	je numarzero2
	
	movl %eax, res
	pushl res
	call atoi
	popl %ebx

	cmp $0, %eax
	je operatie
	
	movl %eax, x
	jmp op_let
	
numarzero2:
	movl $0, x
	jmp op_let
	
operatie:	

	movl res, %esi
	xorl %ecx, %ecx
	movb (%esi, %ecx, 1), %al
	cmp $97, %eax
	je op_add
	cmp $100, %eax
	je op_div
	cmp $109, %eax
	je op_mul
	cmp $114, %eax
	je op_rot
	cmp $115, %eax
	je op_sub
	
	xorl %ecx, %ecx
	jmp et_for
	
op_add:
	movl x, %ebx
	movl (%edi, %ecx, 4), %eax
	add %ebx, %eax
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp index, %ecx
	je afisare
	jmp op_add
	
op_div:
	xorl %edx, %edx
	movl x, %ebx
	movl (%edi, %ecx, 4), %eax
	cdq
	idivl %ebx
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp index, %ecx
	je afisare
	jmp op_div

op_mul:
	xorl %edx, %edx
	movl x, %ebx
	movl (%edi, %ecx, 4), %eax
	mull %ebx
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp index, %ecx
	je afisare
	jmp op_mul
	
op_sub:
	movl x, %ebx
	movl (%edi, %ecx, 4), %eax
	sub %ebx, %eax
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	cmp index, %ecx
	je afisare
	jmp op_sub

op_rot:

	movl lin, %eax
	movl col, %ebx
	movl %ebx, lin
	movl %eax, col
	
	lea vrotate, %esi
	xorl %ecx, %ecx
	xorl %edx, %edx
	
	movl $0, indexlin
	movl $0, indexcol
	movl $0, indexmat
	
	jmp for_lin
	
for_lin:

	movl indexlin, %ecx
	movl indexcol, %eax
	xorl %eax, %eax
	movl %eax, indexcol
	cmp lin, %ecx
	je afisarerot
		
for_col:
	
	movl col, %eax
	subl indexcol, %eax
	subl $1, %eax
	xorl %edx, %edx
	mull lin
	addl indexlin, %eax
	movl (%edi, %eax, 4), %ebx
	movl indexmat, %edx
	movl %ebx, (%esi, %edx, 4)
	
	incl %edx
	movl %edx, indexmat
	incl indexcol
	movl indexcol, %ecx
	cmp col, %ecx
	je for_linincl
	jmp for_col

for_linincl:

	incl indexlin
	jmp for_lin

afisare:
	movl lin, %eax
	movl col, %ebx
	mull %ebx
	movl %eax, index
	xorl %ecx, %ecx
	
	pushl lin
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	
	pushl col
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	
	jmp afisare2

afisare2:
	
	movl %ecx, index2
	movl (%edi, %ecx, 4), %eax
	pushl %eax
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	movl index2, %ecx
	incl %ecx
	cmp index, %ecx
	je exit
	jmp afisare2

afisarerot:

	movl lin, %eax
	movl col, %ebx
	mull %ebx
	movl %eax, index
	xorl %ecx, %ecx
	
	pushl lin
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	
	pushl col
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	
	jmp afisarerot2

afisarerot2:

	movl %ecx, index2
	movl (%esi, %ecx, 4), %eax
	pushl %eax
	pushl $formatPrintf
	call printf 
	popl %ebx
	popl %ebx
	movl index2, %ecx
	incl %ecx
	cmp index, %ecx
	je exit
	jmp afisarerot2

exit:
	pushl $0
	call fflush
	popl %ebx
	
	pushl $NULL
	pushl $formatPrintf0
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
