# 1 "boot/head.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "boot/head.S"




.text

.globl pg_dir, pg_tbl_0


# 1 "./include/linus/tasks.h" 1








# 10 "boot/head.S" 2

# 1 "./include/linus/segment.h" 1









# 11 "boot/head.S" 2

startup_32:
	









	//call setup_idt


	//call setup_paging

	call StartKernel


# 41 "boot/head.S"





.align 2
setup_paging:
	
	movl $1024*2, %ecx 
	xorl %eax, %eax 
	movl $pg_dir, %edi 
	cld 
	rep stosl 


	movl $pg_tbl_0+7, pg_dir 


	movl $pg_tbl_0+7, pg_dir+768 
	movl $pg_tbl_0+4092 , %edi
	movl $0x03ff007, %eax 
	std 
1:	stosl 
	subl $0x1000, %eax
	jge 1b
	cld
	movl $pg_dir, %eax
	movl %eax, %cr3 
	movl %cr0, %eax
	orl $0x80000000, %eax
	movl %eax, %cr0 
	ret 

# 83 "boot/head.S"






// 0x1000 - offset(0x1000)
.org 0x1000
pg_dir:






// 0x1000 - offset(0x1000)
.org 0x2000
pg_tbl_0:

// 0x2000 - offset(0x1000)
.org 0x3000
empty_bad_page:

// 0x3000 - offset(0x1000)
.org 0x4000
empty_bad_page_table:

// 0x4000 - offset(0x1000)
.org 0x5000
empty_zero_page:

// 0x5000 - offset(0x1000)
.org 0x6000
