#include <linus/types.h>

struct trapframe {
    INT32U edi;
    INT32U esi;
    INT32U ebp;
    INT32U oesp;
    INT32U ebx;
    INT32U edx;
    INT32U ecx;
    INT32U eax;

    INT16U gs;
    INT16U padding1;
    INT16U fs;
    INT16U padding2;
    INT16U es;
    INT16U padding3;
    INT16U ds;
    INT16U padding4;
    
    INT32U trapno;

    // below here defined by x86 hardware
    INT32U err;
    INT32U eip;
    INT16U cs;
    INT16U padding5;
    INT32U eflags;

    // below here only when crossing rings, such as from user to kernel
    INT32U esp;
    INT16U ss;
    INT16U padding6;    
};

LOCAL INLINE UCHAR inb(USHORT port) {
    UCHAR data;
    asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    return data;
}

LOCAL INLINE VOID outb(USHORT port, UCHAR data) {
    asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

