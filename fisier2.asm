.data
	str: .space 300
	delim: .asciz " "
	formatPrintf: .asciz "%d\n"
	formatScanf: .asciz "%[^\n]"
	primulnr: .space 4
	res: .space 4
	e: .space 4
	
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
	
	movl %eax, res
	pushl res
	call atoi
	popl %ebx
	movl %eax, primulnr
	pushl primulnr		# urc primul nr pe stiva

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

	cmp $0, %eax		# compar sa vad daca este operatie sau numar
	je operatie
	
	pushl %eax		# adaug pe stiva numarul
	
	jmp et_for

operatie:
	
	movl res, %edi
	xorl %ecx, %ecx
	movb (%edi, %ecx, 1), %al 	#memorez adresa pointerului in %edi

	cmp $0, %al
	je exit

	cmp $97, %al
	je op_add
	cmp $100, %al
	je op_div
	cmp $109, %al
	je op_mul
	cmp $115, %al
	je op_sub


op_add:
	popl %eax
	popl %ebx
	addl %eax, %ebx
	pushl %ebx
	jmp et_for
	
op_div:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	divl %ebx
	pushl %eax
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
