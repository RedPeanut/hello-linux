/*
 *  head.S contains the 32-bit startup code.
 */

.text

.globl pg_dir, pg_tbl_0

#include <linus/tasks.h>
#include <linus/segment.h>

startup_32:
	/*cld
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	mov %ax,%fs
	mov %ax,%gs*/
/*
 * start system 32-bit setup. We need to re-do some of the things done
 * in 16-bit mode for the "real" operations.
 */
	//call setup_idt
/* check if it is 486 or 386. */

	//call setup_paging

	call StartKernel

/*
 * Setup_paging
 *
 * This routine sets up paging by setting the page bit
 * in cr0. The page tables are set up, identity-mapping
 * the first 4MB.  The rest are initialized later.
 *
 * (ref: added support for up to 32mb, 17Apr92)  -- Rik Faith
 * (ref: update, 25Sept92)  -- croutons@crunchy.uucp 
 * (ref: 92.10.11 - Linus Torvalds. Corrected 16M limit - no upper memory limit)
 */
/*
 * 페이징 셋업하기
 * 
 * 최초 매핑은 선두 4MB영역만 하고 나머지는 나중에 한다.
 */
.align 2
setup_paging:
	/* clear 2 pages */
	movl $1024*2, %ecx /* 2 pages - pg_dir+1 page table */
	xorl %eax, %eax /* eax = 0 */
	movl $pg_dir, %edi /* pg_dir is at 0x1000 */
	cld /* clear direction,  reputation, store (string(long=4bytes)) */
	rep stosl /* eax to es:edi */
/* Identity-map the kernel in low 4MB memory for ease of transition */
/* 최초 매핍은 하위 메모리 4MB 영역만 */
	movl $pg_tbl_0+7, pg_dir /* set present bit/user r/w */
/* But the real place is at 0xC0000000 */
/* 3GB */
	movl $pg_tbl_0+7, pg_dir+768 /* set present bit/user r/w */
	movl $pg_tbl_0+4092 /* 4096-4(=0x1000-0x0004=0xffc) */, %edi
	movl $0x03ff007, %eax /*  4Mb - 4096 + 7 (r/w user, p) */
	std /* set direction(=backwards) */
1:	stosl /* store (string(long=4bytes)) *//* fill the page backwards - more efficient :-) */
	subl $0x1000, %eax
	jge 1b
	cld
	movl $pg_dir, %eax
	movl %eax, %cr3 /* cr3 - page directory start */
	movl %cr0, %eax
	orl $0x80000000, %eax
	movl %eax, %cr0 /* set paging (PG) bit, set 페이징 비트(32번째 비트) */
	ret /* this also flushes the prefetch-queue */
/*
 * page 0 is made non-existent, so that kernel NULL pointer references get
 * caught. Thus the swapper page directory has been moved to 0x1000
 *
 * XXX Actually, the swapper page directory is at 0x1000 plus 1 megabyte,
 * with the introduction of the compressed boot code.  Theoretically,
 * the original design of overlaying the startup code with the swapper
 * page directory is still possible --- it would reduce the size of the kernel
 * by 2-3k.  This would be a good thing to do at some point.....
 */
/*
 * null포인터 exception을 잡기 위해 0번 페이지는 없다.
 * 
 * 사실 부트코드 압축 이후 swapper page directory 는 0x101000로 옮겨졌는데,
 * 이론적으로(?), 0x1000위치도 사용가능하다 --- 
 */
// 0x1000 - offset(0x1000)
.org 0x1000
pg_dir:
/*
 * The page tables are initialized to only 4MB here - the final page
 * tables are set up later depending on memory size.
 * 이곳에서 초기화되는 영역은 4MB - 최종 페이지 테이블은
 * 나중에 메모리이 크기에 따라 결정됨
 */
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
