.data
	str: .space 300
	delim: .asciz " "
	formatPrintf: .asciz "%d\n"
	formatScanf: .asciz "%[^\n]"
	v: .space 100
	res: .space 4
	e: .space 4
	primulnr: .space 4
	var: .space 4
	nr: .space 4
	cts: .space 4
	lit: .space 4

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
	
	movl %eax, res
	pushl res
	call atoi
	popl %ebx
	cmp $0, %eax		#verific daca primul element din sir este nr sau variabila
	je variabila1		
	
	movl %eax, primulnr
	pushl primulnr		#urc primul nr pe stiva
	
	
et_for:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je exit

	movl %eax, res
	pushl res
	call atoi
	popl %ebx
	
	cmp $0, %eax		#verific daca este variabila/operatie sau numar
	je varop
	
	movl %eax, nr
	pushl nr		#pun nr pe stiva
	jmp et_for
	
variabila1:
	
	xorl %ecx, %ecx
	movl res, %esi
	movb (%esi, %ecx, 1), %al
	pushl %eax
	jmp et_for

varop:
	
	movl res, %esi
	xorl %ecx, %ecx
	movb (%esi, %ecx, 1), %al
	movl %eax, var
	incl %ecx
	movb (%esi, %ecx, 1), %al
	
	cmp $0, %al
	jne operatie
	je variabila2
	
variabila2:
	
	movl var, %ecx
	subl $97, %ecx
	movl (%edi, %ecx, 4), %eax
	cmp $0, %eax
	jne varpush
	pushl var
	
	jmp et_for

varpush:
	pushl %eax
	jmp et_for
	
operatie:
	movl var, %eax
	cmp $97, %eax
	je op_add
	cmp $100, %eax
	je op_div
	cmp $108, %eax
	je op_let
	cmp $109, %eax
	je op_mul
	cmp $115, %eax
	je op_sub
	
op_add:
	popl %eax
	popl %ebx
	addl %ebx, %eax
	pushl %eax
	jmp et_for
	
op_div:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	divl %ebx
	pushl %eax
	jmp et_for

op_let:
	popl cts
	popl %ebx
	subl $97, %ebx
	movl %ebx, %ecx
	movl cts, %eax
	movl %eax, (%edi, %ecx, 4)
	jmp et_for
		
op_mul:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	mull %ebx
	pushl %eax
	jmp et_for

op_sub:
	popl %ebx
	popl %eax
	subl %ebx, %eax
	pushl %eax
	jmp et_for
	
exit: 
	popl e
	pushl e
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
