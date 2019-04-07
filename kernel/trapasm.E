# 1 "trapasm.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "trapasm.S"

# 1 "../include/linus/segment.h" 1









# 2 "trapasm.S" 2

# vectors.S sends all traps here.
.globl alltraps

alltraps:
	pusha

	movl TaskCurrent, %ebx # save current context
	movl %esp, (%ebx)

	push %esp
	call trap
	addl $4, %esp

	popa
	addl $8, %esp # skip vector# and errcode
	iret
	
#alltraps:
#	# build trap frame.
#	pushl %ds
#	pushl %es
#	pushl %fs
#	pushl %gs
#	pushal

#	# setup data and per-cpu segments
#	movw $(0x10), %ax
#	movw %ax, %ds
#	movw %ax, %es
#	movw %ax, %fs
#	movw %ax, %gs

#	# call trap
#	pushl %esp
#	call trap
#	addl $4, %esp

#	# return falls through to trapret...
#.globl trapret
#trapret:
#	popal
#	popl %gs
#	popl %fs
#	popl %es
#	popl %ds
#	addl $0x8, %esp #trapno and errcode
#	iret
