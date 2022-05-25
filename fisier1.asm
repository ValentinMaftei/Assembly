.data
	sirb16: .space 100
	formatScanf: .asciz "%s"
	formatPrintfd: .asciz "%d "
	formatPrintfs: .asciz "%s "
	formatPrintfneg: .asciz "%s"
	formatPrintf0: .asciz "%s"
	add: .asciz "add"
	let: .asciz "let"
	sub: .asciz "sub"
	mul: .asciz "mul"
	div: .asciz "div"
	lit: .space 4
	neg: .asciz "-"
	cif: .space 4
	NULL: .asciz "\n"
	indexafis: .space 4

.text

.global main

main:
	pushl $sirb16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	lea sirb16, %edi	#memorez adresa sirului in %edi
	xorl %ecx, %ecx

et_for:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit

	// verific daca am op sau var:
	cmp $56, %al
	je  nr.poz
	cmp $57, %al
	je nr.neg
	cmp $65, %al
	je variabila
	cmp $67, %al
	je operatie

nr.poz:

	// prima cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	//verific daca primul caracter e litera sau cifra
	cmp $65, %al
	jge nrpozcif1
	
	sub $48, %al
	movl $16, %ebx
	mull %ebx
	movl %eax, %edx
	
	// a doua cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $65, %al
	jge nrpozcif2
	
	sub $48, %al
	add %eax, %edx

	movl %ecx, indexafis
	
	movl %edx, cif
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	
	movl indexafis, %ecx
	
	jmp cont
	
nrpozcif1:
	
	sub $55, %al
	movl $16, %ebx
	mull %ebx
	movl %eax, %edx
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $65, %al
	jge nrpozcif2
	
	sub $48, %al
	add %eax, %edx

	movl %ecx, indexafis
	
	movl %edx, cif
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	
	movl indexafis, %ecx
	
	
	jmp cont


nrpozcif2:

	sub $55, %al
	add %eax, %edx
	movl %ecx, indexafis
	
	movl %edx, cif
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	
	movl indexafis, %ecx
	
	jmp cont
	

nr.neg:
	
	// prima cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	//verific daca primul caracter e litera sau cifra
	cmp $65, %al
	jge nrnegcif1
	
	sub $48, %al
	movl $16, %ebx
	mull %ebx
	movl %eax, %edx
	
	// a doua cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $65, %al
	jge nrnegcif2
	
	sub $48, %al
	add %eax, %edx
	movl %edx, cif
	
	movl %ecx, indexafis
	pushl $neg
	pushl $formatPrintfneg
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	movl %ecx, indexafis
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
	
nrnegcif1:
	
	sub $55, %al
	movl $16, %ebx
	mull %ebx
	movl %eax, %edx
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $65, %al
	jge nrnegcif2
	
	sub $48, %al
	add %eax, %edx
	movl %edx, cif
	
	movl %ecx, indexafis
	pushl $neg
	pushl $formatPrintfneg
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	movl %ecx, indexafis
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont


nrnegcif2:

	sub $55, %al
	add %eax, %edx
	movl %edx, cif
	
	movl %ecx, indexafis
	pushl $neg
	pushl $formatPrintfneg
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	movl %ecx, indexafis
	pushl cif	
	pushl $formatPrintfd
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx

	jmp cont

variabila:

	//prima cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	sub $48, %al
	movl $16, %ebx
	mull %ebx
	movl %eax, %edx
	
	//a doua cifra
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	// verific daca al 2 lea element al unei variabile este litera sau cifra
	cmp $65, %al
	jge varlitmare
	
	sub $48, %al
	add %eax, %edx
	
	movl %ecx, indexafis
	movl %edx, lit
	pushl $lit	
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	
	movl indexafis, %ecx
	
	jmp cont
	
varlitmare:
	
	sub $55, %al
	add %eax, %edx
	movl %ecx, indexafis
	movl %edx, lit
	pushl $lit
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	
	movl indexafis, %ecx
	
	jmp cont


operatie:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je let.
	cmp $49, %al
	je add.
	cmp $50, %al
	je sub.
	cmp $51, %al
	je mul.
	cmp $52, %al
	je div.
	
	jmp cont


let.:
	movl %ecx, indexafis
	pushl $let
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
	
add.:
	movl %ecx, indexafis
	pushl $add
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
sub.:
	movl %ecx, indexafis
	pushl $sub
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
mul.:
	movl %ecx, indexafis
	pushl $mul
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
div.:
	movl %ecx, indexafis
	pushl $div
	pushl $formatPrintfs
	call printf
	popl %ebx
	popl %ebx
	movl indexafis, %ecx
	
	jmp cont
cont:
	incl %ecx
	jmp et_for

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
