#include <linus/types.h>
#include <linus/trap.h>
#include <linus/timer.h>

#define IO_TIMER1 0x40 // 8253 Timer #1

#define TIMER_MODE (IO_TIMER1+3) // timer mode port
#define TIMER_SEL0 0x00
#define TIMER_RATEGEN 0x04 // mode 2, rate generator
#define TIMER_16BIT 0x30 // r/w counter 16 bits, LSB frrst

BOOL TimerInitialize(BYTE timesPerSecond) {
    WORD cntsPerSecond = (WORD)(1193180/timesPerSecond);

    //__outb(0x34, 0x43); // value, port
    //__outb(cntsPerSecond & 0xff, 0x40);
    //__outb(cntsPerSecond >> 8, 0x40);
    WRITE_PORT_UCHAR((PUCHAR)0x43, 0x34); // value, port
    WRITE_PORT_UCHAR((PUCHAR)0x40, cntsPerSecond & 0xff);
    WRITE_PORT_UCHAR((PUCHAR)0x40, cntsPerSecond >> 8);

    PicEnable(IRQ_TIMER);

    return TRUE;
}

