#include <linus/linkage.h>
#include <linus/types.h>
#include <linus/unistd.h>
#include <asm/system.h>
#include <linus/errno.h>
#include <linus/pc.h>
#include <linus/hal.h>
#include <linus/timer.h>
#include <linus/linus.h>
#include <linus/task.h>
#include <linus/mmu.h>
#include <linus/sprintf.h>

#if 0
static inline _syscall0(int, fork)
static inline _syscall1(int, dup, int, fd)
static inline _syscall3(int, execve, const char *, file, char **, argv, char **, envp)
static inline _syscall3(int, open, const char *, file, int, flag, int, mode)
static inline _syscall1(int, close, int, fd)
#else
static inline int fork(void) {
    long __res; 
    __asm__ volatile(
        "int $0x80"
        :"=a"(__res)
        :"0"(/*2*/__NR_fork)); 

    if(__res >= 0) 
        return (int)__res;
 
    errno = -__res; 
    return -1;
}

static inline int dup(int fd) {
    long __res; 
    __asm__ __volatile__(
        "int $0x80"
        :"=a"(__res)
        :"0"(/*41*/__NR_dup), "b"((long)(fd))); 

    if(__res >= 0) 
        return (int)__res;
 
    errno = -__res; 
    return -1;
}

static inline int execve(const char * file, char ** argv, char ** envp) {
    long __res; 
    __asm__ volatile(
        "int $0x80"
        :"=a"(__res)
        :"0"(/*11*/__NR_execve), "b"((long)(file)), "c"((long)(argv)), "d"((long)(envp))); 

    if(__res>=0) 
        return (int)__res;
 
    errno = -__res; 
    return -1;
}

static inline int open(const char * file, int flag, int mode) {
    long __res; 
    __asm__ volatile(
        "int $0x80"
        :"=a"(__res)
        :"0"(/*5*/__NR_open), "b"((long)(file)), "c"((long)(flag)), "d"((long)(mode))); 

    if(__res>=0) 
        return (int)__res;
 
    errno = -__res; 
    return -1;
}

static inline int close(int fd) {
    long __res; 
    __asm__ volatile(
        "int $0x80"
        :"=a"(__res)
        :"0"(6), "b"((long)(fd))); 

    if(__res >= 0) 
        return (int)__res;
 
    errno = -__res; 
    return -1;
}
#endif

//extern BOOL PicInitialize(VOID);
//extern BOOL TimerInitialize(BYTE timesPerSecond);
//extern BOOL TrapInitialize(VOID);
//extern VOID IRQInitialize(VOID);
//extern VOID SchedInitialize(VOID);
//extern BOOL kMallocInitialize(ULONG, ULONG);
//extern BOOL ChrDevInitialize(ULONG, ULONG);
//extern BOOL BlkDevInitialize(ULONG, ULONG);

VOID init(VOID) {
    int pid, i;
    static char * argv[] = { "-/bin/sh", NULL };
    static char * envp[] = { "HOME=/usr/root", NULL };

    if((pid = fork()) == 0) {
        // close(0);
    }

    if(pid > 0)
        while(pid != wait(&i))
            /* nothing */;

    while(1) {
        if((pid = fork()) < 0)
            ; //printf("Fork failed in init\r\n");
        if(!pid) {
            execve("/bin/sh", argv, envp);
        }
        while(1)
            if(pid == wait(&i))
                break;
        //printf("\r\nchild %d died with code %04x\n\r", pid i);
        //sync();
    }
}

TASK_STRUCT * TaskCurrent = NULL;
TASK_STRUCT * TaskNext = NULL;
TASK_STRUCT * TaskListHeadPtr = NULL;
INT8U TaskNum = 0;

ASMLINKAGE VOID context_switch(struct __CONTEXT *, struct __CONTEXT *);
ASMLINKAGE VOID OSStartHighRdy(VOID);

OS_STACK * TaskStkInit(VOID (*entryPoint)(OS_STACK), OS_STACK * pdata, OS_STACK * p_stk, USHORT option) {
    OS_STACK * stk;
    INT32U eflags;
    
    asm volatile(
        "pushf\n\t"
        "popl %0\n\t"
        : "=a"(eflags)
        :
    );

    stk = p_stk;

    *stk-- = (OS_STACK)pdata; //
    *stk-- = (OS_STACK)0; // hmm.. 
    *stk-- = (OS_STACK)(eflags | FL_IF);
    *stk-- = (OS_STACK)KERNEL_CS; // cs
    *stk-- = (OS_STACK)entryPoint; // eip
    *stk-- = (OS_STACK)0x0; // errcode
    *stk-- = (OS_STACK)0x0; // vector
    *stk-- = (OS_STACK)0x0; // a
    *stk-- = (OS_STACK)0x0; // c
    *stk-- = (OS_STACK)0x0; // d
    *stk-- = (OS_STACK)0x0; // b
    *stk-- = (OS_STACK)0x0; // sp
    *stk-- = (OS_STACK)0x0; // bp
    *stk-- = (OS_STACK)0x0; // si
    *stk = (OS_STACK)0x0; // di

    return ((OS_STACK *)stk);
}

#if 0
INT8U TaskGlobalManipulate(UCHAR priority, OS_STACK * p_stk, USHORT id, UINT stk_size, USHORT option) {
    struct __TASK_STRUCT * pts;

    ENTER_CRITICAL_SECTION();
    pts = TaskListHeadPtr;
    if(pts != (struct __TASK_STRUCT *)0) {
        TaskListHeadPtr = pts->next;
        EXIT_CRITICAL_SECTION();
        pts->stk = p_stk;
        pts->state = RUNNABLE;
        return (OS_NO_ERR);
    }
    EXIT_CRITICAL_SECTION();
    return (OS_NO_MORE_TS);
}

VOID TaskCreate(VOID (*entryLoop)(VOID *), VOID * pdata, OS_STACK * p_stk, UCHAR priority) {
    //OS_STACK * p_stk;
    INT8U err;
    
    ENTER_CRITICAL_SECTION();
    {
        EXIT_CRITICAL_SECTION();
        p_stk = (OS_STACK *)TaskStkInit(entryLoop, pdata,p_stk, 0);
        err = TaskGlobalManipulate(priority, p_stk, 0, 0, 0);
        if(err == OS_NO_ERR) {
            ENTER_CRITICAL_SECTION();
            TaskCurrent++;
            EXIT_CRITICAL_SECTION();
        } else {
        }
        return;
    }
    EXIT_CRITICAL_SECTION();
}
#else
INT8U TaskGlobalManipulate(struct __TASK_STRUCT * pts, UCHAR priority, OS_STACK * p_stk, USHORT id, UINT stk_size, USHORT option) {
    // insert into head
    ENTER_CRITICAL_SECTION();
    pts->next = TaskListHeadPtr;
    pts->prev = pts->next->prev;
    //pts->next->next = pts;
    TaskListHeadPtr = pts;
    EXIT_CRITICAL_SECTION();
    return (OS_NO_ERR);
}

VOID TaskCreate(struct __TASK_STRUCT * pts, VOID (*entryLoop)(OS_STACK), OS_STACK * pdata, OS_STACK * p_stk, UCHAR priority) {
    //LOCAL INT i = 0;
    //OS_STACK * p_stk;
    INT8U err;
    //printk("Entering TaskCreate(), #%d\r\n", i++);
    //if(DBG) printk("pdata = %08x\r\n", pdata);
    //if(DBG) printk("(OS_STACK)pdata = %08x\r\n", (OS_STACK)pdata);
    //if(DBG) printk("pts = %08x\r\n", pts);
    
    ENTER_CRITICAL_SECTION();
    {
        EXIT_CRITICAL_SECTION();
        
        p_stk = (OS_STACK *)TaskStkInit(entryLoop, pdata, p_stk, 0);
        pts->stk = p_stk;
        pts->state = RUNNABLE;
        //pts->pdata = pdata;
        
        err = TaskGlobalManipulate(pts, priority, p_stk, 0, 0, 0);
        if(err == OS_NO_ERR) {
            ENTER_CRITICAL_SECTION();
            OSTaskCounter++;
            EXIT_CRITICAL_SECTION();
        } else {
        }
        return;
    }
    EXIT_CRITICAL_SECTION();
}

#endif

UINT random(UINT div) {
    LOCAL ULONG seed = 1;
    seed = seed * 1664525 + 1013904223;
    return seed % div;
}

VOID randomDispCharLoop(OS_STACK pdata) {
    INT8U x, y, err;
    
    //if(DBG) printk("Entering randomDispCharLoop()\r\n");
    //if(DBG) printk("pdata = %08x\r\n", pdata);
    
    for(;;) {
        // how to make random fn
        x = random(80);
        y = random(16);

        //
        PC_DisplayCharacter(x, y + 5, *(CHAR *)pdata, DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    }
}

static  void  TaskStartDispInit (void) {
/*                                      1111111111222222222233333333334444444444555555555566666666667777777777 */
/*                            01234567890123456789012345678901234567890123456789012345678901234567890123456789 */
    PC_DisplayString( 0,  0, "                            Linus, For Real-Time Kernel                         ", DISP_FGND_WHITE + DISP_BGND_RED /*+ DISP_BLINK*/);
    PC_DisplayString( 0,  1, "                                  Jinkyu. Kim                                   ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  2, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  3, "                                    EXAMPLE                                     ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  4, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  5, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  6, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  7, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  8, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0,  9, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 10, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 11, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 12, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 13, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 14, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 15, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 16, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 17, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 18, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 19, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 20, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 21, "                                                                                ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 22, "#Tasks          :        CPU Usage:     %                                       ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 23, "#Task switch/sec:                                                               ", DISP_FGND_BLACK + DISP_BGND_LIGHT_GRAY);
    PC_DisplayString( 0, 24, "                                                                                ", DISP_FGND_WHITE + DISP_BGND_BLUE/* + DISP_BLINK*/);
/*                            00000000001111111111222222222233333333334444444444555555555566666666667777777777 */
/*                            01234567890123456789012345678901234567890123456789012345678901234567890123456789 */
}


#if 1
static  void  TaskStartDisp (void) {
    char s[80];

    sprintf(s, "%5d", OSTaskCounter); /* Display #tasks running */
    PC_DisplayString(18, 22, s, DISP_FGND_YELLOW + DISP_BGND_BLUE);

#if 0
    sprintf(s, "%3d", OSCPUUsage); /* Display CPU usage in % */
    PC_DisplayString(36, 22, s, DISP_FGND_YELLOW + DISP_BGND_BLUE);
#endif

    sprintf(s, "%5d", OSCtxSwCounter); /* Display #context switches per second */
    PC_DisplayString(18, 23, s, DISP_FGND_YELLOW + DISP_BGND_BLUE);
}
#endif

VOID idleLoop(OS_STACK pdata) {
    //INT8U x, y, err;

    if(DBG) printk("Entering idleLoop()...\r\n");
    //if(DBG) printk("pdata = %s", (STRING)pdata);

    TaskStartDispInit();
    
    for(;;) {
        OSIdleCounter++;
        TaskStartDisp();
    }
}

VOID schedule(VOID) {
    if(DBG) printk("Entering schedule()\r\n");
    //for(;;);
    struct __TASK_STRUCT * pts;
    for(;;) {
        //asm volatile ("sti");
        sti();
        //ENTER_CRITICAL_SECTION();
        pts = TaskListHeadPtr;
        //EXIT_CRITICAL_SECTION();
        for(;; pts = pts->next) {
            if(pts->state != RUNNABLE)
                continue;
            pts->state = RUNNING;
            context_switch(TaskCurrent->context, pts->context);
        }
    }
}

///*
VOID OSStart(VOID) {
    struct __TASK_STRUCT * pts;
    //if(DBG) printk("Entering OSStart()...\r\n");

    //sti();
    //for(;;);
    ///*
    TaskNext = TaskCurrent;
    //if(DBG) printk("Select TaskNext...\r\n");
    //TaskNext = TaskCurrent; // before
    sti(); //asm volatile ("sti"); //sti();
    //TaskNext = TaskCurrent; // after
    OSStartHighRdy();
    //*/
}
//*/

/* start_kernel() must be pos first? */
extern BOOL A20Enable(VOID);
extern BOOL PicInitialize(VOID);
extern BOOL TimerInitialize(BYTE timesPerSecond);
extern BOOL TrapInitialize(VOID);
//extern VOID IRQInitialize(VOID);
//extern VOID SchedInitialize(VOID);
//extern BOOL kMallocInitialize(ULONG, ULONG);
//extern BOOL ChrDevInitialize(ULONG, ULONG);
//extern BOOL BlkDevInitialize(ULONG, ULONG);

ASMLINKAGE VOID StartKernel(VOID) {

    static ULONG memory_start = 0;
    static ULONG memory_end = 0;

    /* Console initialize first for msg for debugging */
    ///*
    if(ConInitialize()) {
        printk("\r\n\r\n");
        printk("Console Initialize Successfully!!!\r\n");
    }
    //*/

    if(A20Enable())
        printk("Enabling A20 successfully!!!\r\n");
    if(PicInitialize())
        printk("Initializing PIC successfully!!!\r\n");
    if(TrapInitialize())
        printk("Initializing Trap successfully!!!\r\n");
    if(TimerInitialize(TIMES_PER_SECOND))
        printk("Initializing Timer successfully!!!\r\n");

    HalEnableInterrupt(idt, sizeof(idt));
    //asm volatile ("sti");
    //IRQInitialize();
    
    //SchedInitialize();

    //memory_start = 1024 * 1024;

    //memory_start = kMallocInitialize(memory_start, memory_end);
    //memory_start = ChrDevInitialize(memory_start, memory_end);
    //memory_start = BlkDevInitialize(memory_start, memory_end);

    //sti();
    //for(;;);
#if 1
#if 0
    MOVE_TO_USER_MODE();
    if(!fork())
        init();
#else
    // naming
    
    // step 1. prepare task struct
        // task struct must have context in its own in stack
    // step 2. prepare init and some task
    // step 3. select next task
    // step 4. context switching
    {
        if(DBG) printk("step 2. prepare init and some task\r\n");
        // step 2. prepare init and some task
        #define N_TASKS 9 //9
        #define STACKSIZE 256

        //static BYTE init_task_stack[STACKSIZE] = {0,};
        LOCAL struct __TASK_STRUCT idleTask;
        LOCAL OS_STACK idleTaskStack[STACKSIZE] = {0,};
        LOCAL STRING idleTaskName = "idleTask";
        //LOCAL INT8U idleTaskName[9] = {'i', 'd', 'l', 'e', 'T', 'a', 's', 'k', '\0'};

        LOCAL struct __TASK_STRUCT Task[N_TASKS];
        LOCAL OS_STACK TaskStack[N_TASKS][STACKSIZE] = {0,};
        LOCAL CHAR TaskData[N_TASKS] = {0,};
        //LOCAL STRING taskName[] = { "radom1", "random2", "radom3", "random4", "random5", };

        struct __TASK_STRUCT * pts;
        INT i;

        ENTER_CRITICAL_SECTION();
        // make circular
        //pts = TaskListHeadPtr;
        //pts->next = pts;
        //pts->prev = pts;
        EXIT_CRITICAL_SECTION();
        
        TaskCreate(&idleTask, idleLoop, /*NULL*/(OS_STACK*)idleTaskName, &idleTaskStack[STACKSIZE-1], NULL);
        //if(DBG) printk("&initTask = %08x\r\n", &idleTask);
        //if(DBG) printk("idleLoop = %08x\r\n", idleLoop);
        
        for(i = 0; i < N_TASKS; i++) {
            TaskData[i] = '0' + i;
            //if(DBG) printk("&TaskData[%d] = %08x\r\n", i, &TaskData[i]);
            TaskCreate(&Task[i], randomDispCharLoop, (OS_STACK*)&TaskData[i]/*&taskName[i]*/, &TaskStack[i][STACKSIZE-1], NULL);
        }
        
        ENTER_CRITICAL_SECTION();
        // point current
        TaskCurrent = &idleTask;
        EXIT_CRITICAL_SECTION();
    }
    
    // step 3. select next task(=schedule(), i choose round robin)
    // step 4. and context switching
    //printk("step 3,4. schedule and context switching\r\n");
    //schedule();
    OSStart();
    //OSStartHighRdy();
#endif
#endif

    //printk("\r\n\r\n");
    panic("long time later, this code will not be executed! :) \r\n");

    for(;;);
}
