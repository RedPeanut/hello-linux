#include <linus/types.h>
#include <linus/sched.h>
#include <linus/linkage.h>
#include <asm/system.h>
#include <linus/sys.h>
#include <linus/ptrace.h>
#include <linus/kernel.h>

#define TIMER_IRQ 0

static unsigned long init_kernel_stack[1024];
struct task_struct init_task = INIT_TASK;

unsigned long volatile jiffies=0;

struct task_struct *current = &init_task;
struct task_struct * task[NR_TASKS] = { &init_task, };

int need_reschedule = 0;

extern INT request_irq(UINT irq, VOID (*handler)(INT));

ASMLINKAGE INT system_call(VOID);

#ifdef __cplusplus
extern "C" {
#endif

ASMLINKAGE int sys_null(void) { return 0; }

fn_ptr sys_call_table[] = { sys_null, sys_null, sys_null, sys_null, sys_open};

/* So we don't have to do any more manual updating.... */
int NR_syscalls = sizeof(sys_call_table)/sizeof(fn_ptr);

#ifdef __cplusplus
}
#endif

static VOID do_timer(struct pt_regs* regs) {
    //ULONG mask;
    jiffies++;

    if(current == task[0] || (--current->counter) <= 0) {
        current->counter = 0;
        need_reschedule = 1;
    }
    
    cli();
    sti();
}

/*
ASMLINKAGE VOID schedule(VOID) {
    struct task_struct * p;
    struct task_struct * next;
    
    need_reschedule = 0;
    p = &init_task;

    switch_to(next);
}
*/

VOID SchedInitialize(VOID) {
#if 0
#if 0
    set_system_gate(0x80, &system_call);
#else
    // _set_gate(&idt[n], 15, 3, addr) // (gate_addr, type, dpl, addr)

    // offset4:8 0000 0000
    // offset3:8 0000 0000
    // (p:1/dpl:2/s:1/x/1/0/0):8
    // (0/0/0/dword count:5):8
    // selector:16 0000 0000 0000 0000
    // offset2:8 0000 0000
    // offset1:8 0000 0000

    // word:16 long:32
    __asm__ __volatile__("movw %%dx,%%ax\n\t" // lower edx to lower eax // 16bit operation
        "movw %2,%%dx\n\t" // 16bit operation // type(p+dpl+s+1111+000(0 0000)dword count)to lower edx
        "movl %%eax,%0\n\t" // 32bit operation
        "movl %%edx,%1" // 32bit operation
        : "=m"(*((long*)(&idt[0x80]))), // gate_addr
        "=m"(*(1+(long*)(&idt[0x80]))) // gate_addr
        : "i"((short)(0x8000 + (3<<13) + (15<<8))), // 1000 0000 0000 0000(p) + 0110 0000 0000 0000(dpl) + 0000 1111 0000 0000(type) // 
        "d"((char*)(&system_call)), // addr // edx = 1098:8 7654:7 3210:6 9876:5 5432:4 1098:3 7654:2 3210:1 = 8 bytes
        "a"(0x10 << 16) // KERNEL_CS << 16 // selector // eax = 0000 0000 0001 0000 0000 0000 0000 0000 
        /*: "ax", "dx"*/);
#endif
#endif
    if(IRQRequest(TIMER_IRQ, (VOID (*)(INT))do_timer) != 0)
        panic("Could not allocate timer IRQ!");

}