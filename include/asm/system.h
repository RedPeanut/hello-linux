#ifndef SYSTEM_H_
#define SYSTEM_H_

#include <linus/segment.h>
#include <linus/head.h>
/*
 * cs, esp, eflags, 0x0f(stack segment, USER_SS? 0x08+7), next ip
 */
#define MOVE_TO_USER_MODE() \
__asm__("movl %%esp,%%eax\n\t" /* eax = esp */ \
	"pushl $0x17\n\t" /* push 0x17(USER_CS, maybe) */ \
	"pushl %%eax\n\t" /* push esp */ \
	"pushfl\n\t" /* push eflags, maybe */ \
	"pushl $0x0f\n\t"  /* push 0x0f, why? */ \
	"pushl $1f\n\t" /* push label1: */ \
	"iret\n" /* interrupt return command */ \
	"1:\tmovl $0x17,%%eax\n\t" \
	"movw %%ax,%%ds\n\t" \
	"movw %%ax,%%es\n\t" \
	"movw %%ax,%%fs\n\t" \
	"movw %%ax,%%gs" \
	:::"ax")

#define sti() __asm__ __volatile__("sti":::"memory")
#define cli() __asm__ __volatile__("cli":::"memory")
#define nop() __asm__ __volatile__("nop")

#define save_flags(x) \
__asm__ __volatile__("pushfl ; popl %0":"=r" (x): /* no input */ :"memory")

#define restore_flags(x) \
__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"r" (x):"memory")


#define ENTER_CRITICAL_SECTION() __asm__ __volatile__("pushfl; cli")
#define EXIT_CRITICAL_SECTION() __asm__ __volatile__("popfl")

#define _set_gate(gate_addr, type, dpl, addr) \
    __asm__ __volatile__("movw %%dx,%%ax\n\t" \
        "movw %2,%%dx\n\t" \
        "movl %%eax,%0\n\t" \
        "movl %%edx,%1" \
        :"=m"(*((long *) (gate_addr))), \
         "=m"(*(1+(long *) (gate_addr))) \
        :"i"((short) (0x8000+(dpl<<13)+(type<<8))), \
         "d"((char *) (addr)), "a"(KERNEL_CS << 16) \
        /*:"ax","dx"*/)

#define set_intr_gate(n,addr) \
	_set_gate(&idt[n], 14, 0, addr)
	
#define set_trap_gate(n,addr) \
    _set_gate(&idt[n], 15, 0, addr)

#define set_system_gate(n,addr) \
	_set_gate(&idt[n], 15, 3, addr)
	
#endif /* SYSTEM_H_ */
