	.file	"main.c"
	.section	.rodata
	.align 4
.LC0:
	.string	"long time later, this code will not be executed! :) \r\n"
	.text
.globl StartKernel
	.type	StartKernel, @function
StartKernel:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	TrapInitialize
	call	IRQInitialize
	call	SchedInitialize
	movl	$1048576, memory_start.859
	movl	memory_end.860, %edx
	movl	memory_start.859, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	kMallocInitialize
	addl	$16, %esp
	movl	%eax, memory_start.859
	movl	memory_end.860, %edx
	movl	memory_start.859, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	ChrDevInitialize
	addl	$16, %esp
	movl	%eax, memory_start.859
	movl	memory_end.860, %edx
	movl	memory_start.859, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	BlkDevInitialize
	addl	$16, %esp
	movl	%eax, memory_start.859
	subl	$12, %esp
	pushl	$.LC0
	call	panic
	addl	$16, %esp
	leave
	ret
	.size	StartKernel, .-StartKernel
	.local	memory_start.859
	.comm	memory_start.859,4,4
	.local	memory_end.860
	.comm	memory_end.860,4,4
	.ident	"GCC: (GNU) 4.5.3"
	.section	.note.GNU-stack,"",@progbits
