#include <linus/types.h>
#include <linus/mmu.h>
#include <linus/segment.h>
#include <linus/trap.h>
#include <linus/x86.h>
#include <linus/printk.h>
#include <linus/timer.h>
#include <linus/linus.h>
#include <linus/task.h>
#include <asm/system.h>
#include <linus/irq.h>
#include <asm/io.h>

struct gatedesc idt[256];
 
 // System segment type bits
#define STS_T16A 0x1 // Available 16-bit TSS
#define STS_LDT 0x2 // Local Descriptor Table
#define STS_T16B 0x3 // Busy 16-bit TSS
#define STS_CG16 0x4 // 16-bit Call Gate
#define STS_TG 0x5 // Task Gate / Coum Transmitions
#define STS_IG16 0x6 // 16-bit Interrupt Gate
#define STS_TG16 0x7 // 16-bit Trap Gate
#define STS_T32A 0x9 // Available 32-bit TSS
#define STS_T32B 0xB // Busy 32-bit TSS
#define STS_CG32 0xC // 32-bit Call Gate
#define STS_IG32 0xE // 32-bit Interrupt Gate
#define STS_TG32 0xF // 32-bit Trap Gate
 
#define SETGATE(gate, istrap, sel, off, d) \
{ \
    (gate).off_15_0 = (INT32U)(off) & 0xffff; \
    (gate).cs = (sel); \
    (gate).args = 0; \
    (gate).rsv1 = 0; \
    (gate).type = (istrap) ? STS_TG32 : STS_IG32; \
    (gate).s = 0; \
    (gate).dpl = (d); \
    (gate).p = 1; \
    (gate).off_31_16 = (INT32U)(off) >> 16; \
}

BOOL TrapInitialize(VOID) {
    /*INT8U*/INT i;

    //printk("TrapInitialize(VOID), i = ");
    for(i = 0; i < 256; i++) {
        //printk("%d, ", i);
        SETGATE(idt[i], 0, KERNEL_CS, vectors[i], 0);
    }
    //printk("SETGATE(idt[0x80/*64*/], 1, KERNEL_CS, vectors[0x80], DPL_USER);\r\n");
    SETGATE(idt[T_SYSCALL/*64*/], 1, KERNEL_CS, vectors[T_SYSCALL], DPL_USER);
    return TRUE;
}

UINT ticks;
#define TS_WATCHDOG_CLOCK_POS (0xb8000+(80-1)*2)

ASMLINKAGE VOID OSIntCtxSw(VOID);

VOID trap(/*struct trapframe * tf*/struct irq_ctx * ctx) {
    LOCAL INT cnt = 0, pos = 0;
    LOCAL CHAR status[] = {'-', '\\', '|', '/', '-', '\\', '|', '/'};
    LOCAL CHAR *addr=(CHAR *)TS_WATCHDOG_CLOCK_POS;

    //LOCAL INT local_counter = 0;

    //if(DBG) printk("Entering trap(), tf->trapno = 0x%x\r\n", tf->trapno);

    //for(;;);
    
    if(/*tf->trapno*/ctx->vector ==  T_SYSCALL) {
        return;
    }
    
    switch(/*tf->trapno*/ctx->vector) {
        case T_IRQ0 + IRQ_TIMER:
            // rotate per second
            if(cnt++ > TIMES_PER_SECOND) {
                if(++pos > 7) pos = 0;
                cnt = 0;
                *addr = status[pos];
            }
            ticks++;
            WRITE_PORT_UCHAR((PUCHAR)0x20, 0x20); /* send EOI */
            break;
        default:
            break;
    }

    ///*
    if(/*tf->trapno*/ctx->vector == T_IRQ0+IRQ_TIMER) {
        struct __TASK_STRUCT * pts; // <trap+0x99>
        
        ENTER_CRITICAL_SECTION();
        pts = TaskCurrent;
        if(pts->next == NULL)
            TaskNext = TaskListHeadPtr;
        else
            TaskNext = pts->next;
        //if(/*ONLY_TWO_TIMES*/local_counter < 2) {
            //if(DBG) printk("TaskNext = %08x\r\n", TaskNext);
            //local_counter++;
        //}
        OSCtxSwCounter++;
        OSIntCtxSw();
        EXIT_CRITICAL_SECTION();
    }
    //*/
}
