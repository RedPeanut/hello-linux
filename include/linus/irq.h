#ifndef _LINUS_IRQ_H
#define _LINUS_IRQ_H

#include <linus/types.h>

struct irq_ctx {
    //INT32U pdata;
    INT32U edi;
    INT32U esi;
    INT32U ebp;
    INT32U esp;
    INT32U ebx;
    INT32U edx;
    INT32U ecx;
    INT32U eax;
    INT32U vector;
    INT32U errcode;
    INT32U eip;
    INT32U cs;
    INT32U eflags;
    //
    INT32U pdata;
};

#endif
