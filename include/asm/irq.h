#ifndef _ASM_IRQ_H
#define _ASM_IRQ_H

#include <linus/segment.h>
#include <linus/linkage.h>

#define __STR(x) #x
#define STR(x) __STR(x)

#define SAVE_ALL \
	"cld\n\t" \
	"push %gs\n\t" \
	"push %fs\n\t" \
	"push %es\n\t" \
	"push %ds\n\t" \
	"pushl %eax\n\t" \
	"pushl %ebp\n\t" \
	"pushl %edi\n\t" \
	"pushl %esi\n\t" \
	"pushl %edx\n\t" \
	"pushl %ecx\n\t" \
	"pushl %ebx\n\t" \
	"movl $" STR(KERNEL_DS) ",%edx\n\t" \
	"mov %dx,%ds\n\t" \
	"mov %dx,%es\n\t" \
	"movl $" STR(USER_DS) ",%edx\n\t" \
	"mov %dx,%fs\n\t"   \
	"movl $0,%edx\n\t"  \
	"movl %edx,%db7\n\t"

/*
 * SAVE_MOST/RESTORE_MOST is used for the faster version of IRQ handlers,
 * installed by using the SA_INTERRUPT flag. These kinds of IRQ's don't
 * call the routines that do signal handling etc on return, and can have
 * more relaxed register-saving etc. They are also atomic, and are thus
 * suited for small, fast interrupts like the serial lines or the harddisk
 * drivers, which don't actually need signal handling etc.
 *
 * Also note that we actually save only those registers that are used in
 * C subroutines (%eax, %edx and %ecx), so if you do something weird,
 * you're on your own. The only segments that are saved (not counting the
 * automatic stack and code segment handling) are %ds and %es, and they
 * point to kernel space. No messing around with %fs here.
 */

/* 
 * 
 */

// es 0x10
// ds 0x0c
// eax 0x08
// edx 0x04
// ecx 0x00
// ds, es <- KERNEL_DS(=0x18)

#define SAVE_MOST \
	"cld\n\t" \
	"push %es\n\t" \
	"push %ds\n\t" \
	"pushl %eax\n\t" \
	"pushl %edx\n\t" \
	"pushl %ecx\n\t" \
	"movl $" STR(KERNEL_DS) ",%edx\n\t" \
	"mov %dx,%ds\n\t" \
	"mov %dx,%es\n\t"

#define RESTORE_MOST \
	"popl %ecx\n\t" \
	"popl %edx\n\t" \
	"popl %eax\n\t" \
	"pop %ds\n\t" \
	"pop %es\n\t" \
	"iret"

#define IRQ_NAME2(nr) nr##_interrupt(void)
#define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
#define FAST_IRQ_NAME(nr) IRQ_NAME2(fast_IRQ##nr)
#define BAD_IRQ_NAME(nr) IRQ_NAME2(bad_IRQ##nr)

#define BUILD_IRQ(chip, nr, mask) \
/*ASMLINKAGE void IRQ_NAME(nr);*/ \
/*ASMLINKAGE void FAST_IRQ_NAME(nr);*/ \
ASMLINKAGE VOID BAD_IRQ_NAME(nr); \
__asm__( \
/*"\n.align 4\n" \
"_IRQ" #nr "_interrupt:\n\t" \
    "pushl $-"#nr"-2\n\t" \
    SAVE_ALL \
    "sti\n\t" \
    "call _IRQDo\n\t" \
    "cli\n\t" \
    "jmp ret_from_sys_call\n" \
"\n.align 4\n" \
"_fast_IRQ" #nr "_interrupt:\n\t" \
    SAVE_MOST \
    "pushl $" #nr "\n\t" \
    "call _IRQDoFast\n\t" \
    "cli\n\t" \
    RESTORE_MOST*/ \
"\n\n.align 4\n" \
"_bad_IRQ" #nr "_interrupt:\n\t" \
    SAVE_MOST \
    RESTORE_MOST)

#endif //