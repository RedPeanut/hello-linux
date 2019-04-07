#include <linus/types.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <linus/ptrace.h>
#include <linus/signal.h>
#include <linus/mmu.h>

#if 0
BUILD_IRQ(FIRST, 0, 0x01);
BUILD_IRQ(FIRST, 1, 0x02);
BUILD_IRQ(FIRST, 2, 0x04);
BUILD_IRQ(FIRST, 3, 0x08);
BUILD_IRQ(FIRST, 4, 0x10);
BUILD_IRQ(FIRST, 5, 0x20);
BUILD_IRQ(FIRST, 6, 0x40);
BUILD_IRQ(FIRST, 7, 0x80);
BUILD_IRQ(SECOND, 8, 0x01);
BUILD_IRQ(SECOND, 9, 0x02);
BUILD_IRQ(SECOND, 10, 0x04);
BUILD_IRQ(SECOND, 11, 0x08);
BUILD_IRQ(SECOND, 12, 0x10);
BUILD_IRQ(SECOND, 13, 0x20);
BUILD_IRQ(SECOND, 14, 0x40);
BUILD_IRQ(SECOND, 15, 0x80);
#endif

/*static VOID (*interrupt[16])(VOID) = {
	IRQ0_interrupt, IRQ1_interrupt, IRQ2_interrupt, IRQ3_interrupt,
	IRQ4_interrupt, IRQ5_interrupt, IRQ6_interrupt, IRQ7_interrupt,
	IRQ8_interrupt, IRQ9_interrupt, IRQ10_interrupt, IRQ11_interrupt,
	IRQ12_interrupt, IRQ13_interrupt, IRQ14_interrupt, IRQ15_interrupt
};

static VOID (*fast_interrupt[16])(VOID) = {
	fast_IRQ0_interrupt, fast_IRQ1_interrupt,
	fast_IRQ2_interrupt, fast_IRQ3_interrupt,
	fast_IRQ4_interrupt, fast_IRQ5_interrupt,
	fast_IRQ6_interrupt, fast_IRQ7_interrupt,
	fast_IRQ8_interrupt, fast_IRQ9_interrupt,
	fast_IRQ10_interrupt, fast_IRQ11_interrupt,
	fast_IRQ12_interrupt, fast_IRQ13_interrupt,
	fast_IRQ14_interrupt, fast_IRQ15_interrupt
};*/

extern VOID IRQ0_interrupt(VOID);
extern VOID IRQ1_interrupt(VOID);
extern VOID IRQ2_interrupt(VOID);
extern VOID IRQ3_interrupt(VOID);
extern VOID IRQ4_interrupt(VOID);
extern VOID IRQ5_interrupt(VOID);
extern VOID IRQ6_interrupt(VOID);
extern VOID IRQ7_interrupt(VOID);
extern VOID IRQ8_interrupt(VOID);
extern VOID IRQ9_interrupt(VOID);
extern VOID IRQ10_interrupt(VOID);
extern VOID IRQ11_interrupt(VOID);
extern VOID IRQ12_interrupt(VOID);
extern VOID IRQ13_interrupt(VOID);
extern VOID IRQ14_interrupt(VOID);
extern VOID IRQ15_interrupt(VOID);

extern VOID fast_IRQ0_interrupt(VOID);
extern VOID fast_IRQ1_interrupt(VOID);
extern VOID fast_IRQ2_interrupt(VOID);
extern VOID fast_IRQ3_interrupt(VOID);
extern VOID fast_IRQ4_interrupt(VOID);
extern VOID fast_IRQ5_interrupt(VOID);
extern VOID fast_IRQ6_interrupt(VOID);
extern VOID fast_IRQ7_interrupt(VOID);
extern VOID fast_IRQ8_interrupt(VOID);
extern VOID fast_IRQ9_interrupt(VOID);
extern VOID fast_IRQ10_interrupt(VOID);
extern VOID fast_IRQ11_interrupt(VOID);
extern VOID fast_IRQ12_interrupt(VOID);
extern VOID fast_IRQ13_interrupt(VOID);
extern VOID fast_IRQ14_interrupt(VOID);
extern VOID fast_IRQ15_interrupt(VOID);

extern VOID bad_IRQ0_interrupt(VOID);
extern VOID bad_IRQ1_interrupt(VOID);
extern VOID bad_IRQ2_interrupt(VOID);
extern VOID bad_IRQ3_interrupt(VOID);
extern VOID bad_IRQ4_interrupt(VOID);
extern VOID bad_IRQ5_interrupt(VOID);
extern VOID bad_IRQ6_interrupt(VOID);
extern VOID bad_IRQ7_interrupt(VOID);
extern VOID bad_IRQ8_interrupt(VOID);
extern VOID bad_IRQ9_interrupt(VOID);
extern VOID bad_IRQ10_interrupt(VOID);
extern VOID bad_IRQ11_interrupt(VOID);
extern VOID bad_IRQ12_interrupt(VOID);
extern VOID bad_IRQ13_interrupt(VOID);
extern VOID bad_IRQ14_interrupt(VOID);
extern VOID bad_IRQ15_interrupt(VOID);

static void (*interrupt[16])(void) = {
	IRQ0_interrupt, IRQ1_interrupt, IRQ2_interrupt, IRQ3_interrupt,
	IRQ4_interrupt, IRQ5_interrupt, IRQ6_interrupt, IRQ7_interrupt,
	IRQ8_interrupt, IRQ9_interrupt, IRQ10_interrupt, IRQ11_interrupt,
	IRQ12_interrupt, IRQ13_interrupt, IRQ14_interrupt, IRQ15_interrupt
};

static void (*fast_interrupt[16])(void) = {
	fast_IRQ0_interrupt, fast_IRQ1_interrupt,
	fast_IRQ2_interrupt, fast_IRQ3_interrupt,
	fast_IRQ4_interrupt, fast_IRQ5_interrupt,
	fast_IRQ6_interrupt, fast_IRQ7_interrupt,
	fast_IRQ8_interrupt, fast_IRQ9_interrupt,
	fast_IRQ10_interrupt, fast_IRQ11_interrupt,
	fast_IRQ12_interrupt, fast_IRQ13_interrupt,
	fast_IRQ14_interrupt, fast_IRQ15_interrupt
};

static VOID (*bad_interrupt[16])(VOID) = {
	bad_IRQ0_interrupt, bad_IRQ1_interrupt,
	bad_IRQ2_interrupt, bad_IRQ3_interrupt,
	bad_IRQ4_interrupt, bad_IRQ5_interrupt,
	bad_IRQ6_interrupt, bad_IRQ7_interrupt,
	bad_IRQ8_interrupt, bad_IRQ9_interrupt,
	bad_IRQ10_interrupt, bad_IRQ11_interrupt,
	bad_IRQ12_interrupt, bad_IRQ13_interrupt,
	bad_IRQ14_interrupt, bad_IRQ15_interrupt
};

/*
 * Initial irq handlers.
 */
static struct sigaction irq_sigaction[16] = {
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL },
	{ NULL, 0, 0, NULL }, { NULL, 0, 0, NULL }
};

//extern VOID IRQDo(int irq, struct pt_regs* regs);
//extern VOID IRQDoFast(int irq, struct pt_regs* regs);
ASMLINKAGE INT system_call(VOID);

ASMLINKAGE VOID IRQDo(int irq, struct pt_regs* regs) {
    struct sigaction* sa = irq + irq_sigaction;
    sa->sa_handler((int)regs);
}

ASMLINKAGE VOID IRQDoFast(int irq, struct pt_regs* regs) {
    struct sigaction* sa = irq + irq_sigaction;
    sa->sa_handler((int)regs);
}

INT IRQAction(UINT irq, struct sigaction* new_sa) {
    struct sigaction* sa;
    ULONG flags;

    /*
    if(sa->sa_flags & SA_INTERRUPT)
        set_intr_gate(0x20 + irq, fast_interrupt[irq]);
    else
        set_intr_gate(0x20 + irq, interrupt[irq]);
    //*/
        
    return 0;
}

INT IRQRequest(UINT irq, VOID (*handler)(INT)) {
    struct sigaction sa;

    sa.sa_handler = handler;
    sa.sa_flags = 0;
    sa.sa_mask = 0;
    sa.sa_restorer = NULL;
    return IRQAction(irq, &sa);
}

VOID IRQInitialize(VOID) {
    int i;

    //for(i = 0; i < 16; i++)
        //set_intr_gate(0x20+i, bad_interrupt[i]);
    //set_system_gate(0x80, &system_call);
}


