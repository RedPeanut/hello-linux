#ifndef _TASK_H
#define _TASK_H

#include <linus/types.h>

// step 1. prepare task struct
struct __FRAME {
    // registers as pushed by pusha
    INT32U edi;
    INT32U esi;
    INT32U ebp;
    INT32U oesp; // useless & ignored
    INT32U ebx;
    INT32U edx;
    INT32U ecx;
    INT32U eax;

    // rest of trap frame
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

struct __CONTEXT {
    unsigned int edi;
    unsigned int esi;
    unsigned int ebx;
    unsigned int ebp;
    unsigned int eip;
};

// step 1. prepare task struct(task struct must have context in its own in stack)
enum __TASK_STATE { UNUSED, RUNNABLE, RUNNING, ZOMBIE };
struct __TASK_STRUCT {
    OS_STACK * stk;
    INT32U stk_size;

    enum __TASK_STATE state;
    volatile INT pid;
    INT prio;

    struct __FRAME * frame;
    struct __CONTEXT * context;

    struct __TASK_STRUCT * parent;
    struct __TASK_STRUCT * prev;
    struct __TASK_STRUCT * next;
    
    VOID * pdata;
};
typedef struct __TASK_STRUCT TASK_STRUCT, *P_TASK_STRUCT;

GLOBAL TASK_STRUCT * TaskCurrent;
GLOBAL TASK_STRUCT * TaskNext;
GLOBAL INT8U TaskNum;
GLOBAL TASK_STRUCT * TaskListHeadPtr;

#endif
