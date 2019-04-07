#include <linus/types.h>
#include <linus/trap.h>
#include <linus/hal.h>

VOID HalEnableInterrupt(struct gatedesc * p, int size) {
    volatile USHORT pd[3];

    pd[0] = size-1;
    pd[1] = (UINT)p;
    pd[2] = (UINT)p>>16;
    
    asm volatile("lidt (%0)"::"r"(pd));
}
