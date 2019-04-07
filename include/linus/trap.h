#ifndef _TRAP_H
#define _TRAP_H

// x86 trap and interrupt constants.

// These are arbitrarily chosen, but with care not to overlap
// processor defined exceptions or interrupt vectors.
// 임의로 선택해도 되지만 안 겹치게 선택해야 한다.
#define T_SYSCALL 64 // system call

#define T_IRQ0 32 // IRQ 0 corresponds to int T_IRQ

#define IRQ_TIMER 0
#define IRQ_KBD 1
#define IRQ_COM1 4
#define IRQ_IDE 14
#define IRQ_ERROR 19
#define IRQ_SPURIOUS 31

struct gatedesc {
    INT32U off_15_0 : 16;
    INT32U cs : 16;
    INT32U args : 5;
    INT32U rsv1 : 3;
    INT32U type : 4;
    INT32U s : 1;
    INT32U dpl : 2;
    INT32U p : 1;
    INT32U off_31_16 : 16;
 };

extern struct gatedesc idt[256];
extern UINT vectors[];

#endif
