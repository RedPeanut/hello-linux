#ifndef _FLOWER_SCHED_H
#define _FLOWER_SCHED_H

#include <linus/head.h>
#include <linus/fs.h>
#include <linus/tasks.h>
#include <linus/math_emu.h>

/*
 * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
 */
#define IO_BITMAP_SIZE	32

/*
 * Entry into gdt where to find first TSS. GDT layout:
 *   0 - nul
 *   1 - kernel code segment
 *   2 - kernel data segment
 *   3 - user code segment
 *   4 - user data segment
 * ...
 *   8 - TSS #0
 *   9 - LDT #0
 *  10 - TSS #1
 *  11 - LDT #1
 */
#define FIRST_TSS_ENTRY 8
#define FIRST_LDT_ENTRY (FIRST_TSS_ENTRY+1)
#define _TSS(n) ((((unsigned long) n)<<4)+(FIRST_TSS_ENTRY<<3))
#define _LDT(n) ((((unsigned long) n)<<4)+(FIRST_LDT_ENTRY<<3))

struct i387_hard_struct {
    long cwd;
    long swd;
    long twd;
    long fip;
    long fcs;
    long foo;
    long fos;
    long st_space[20]; /* 8*10 bytes for each FP-reg = 80 bytes */
};

struct i387_soft_struct {
    long cwd;
    long swd;
    long twd;
    long fip;
    long fcs;
    long foo;
    long fos;
    long top;
    struct fpu_reg regs[8]; /* 8*16 bytes for each FP-reg = 128 bytes */
    unsigned char lookahead;
    struct info *info;
    unsigned long entry_eip;
};

union i387_union {
    struct i387_hard_struct hard;
    struct i387_soft_struct soft;
};

struct tss_struct {
    unsigned short back_link, __blh;
    unsigned long esp0;
    unsigned short ss0, __ss0h;
    unsigned long esp1;
    unsigned short ss1, __ss1h;
    unsigned long esp2;
    unsigned short ss2, __ss2h;
    unsigned long cr3;
    unsigned long eip;
    unsigned long eflags;
    unsigned long eax,ecx,edx,ebx;
    unsigned long esp;
    unsigned long ebp;
    unsigned long esi;
    unsigned long edi;
    unsigned short es, __esh;
    unsigned short cs, __csh;
    unsigned short ss, __ssh;
    unsigned short ds, __dsh;
    unsigned short fs, __fsh;
    unsigned short gs, __gsh;
    unsigned short ldt, __ldth;
    unsigned short trace, bitmap;
    unsigned long io_bitmap[IO_BITMAP_SIZE+1];
    unsigned long tr;
    unsigned long cr2, trap_no, error_code;
    union i387_union i387;
};

struct task_struct {
#if 0
/* these are hardcoded - don't touch */
    volatile long state;    /* -1 unrunnable, 0 runnable, >0 stopped */
    long counter;
    long priority;
    unsigned long signal;
    unsigned long blocked;    /* bitmap of masked signals */
    unsigned long flags;    /* per process flags, defined below */
    int errno;
    int debugreg[8];  /* Hardware debugging registers */
/* various fields */
    struct task_struct *next_task, *prev_task;
    struct sigaction sigaction[32];
    unsigned long saved_kernel_stack;
    unsigned long kernel_stack_page;
    int exit_code, exit_signal;
    int elf_executable:1;
    int dumpable:1;
    int swappable:1;
    int did_exec:1;
    unsigned long start_code,end_code,end_data,start_brk,brk,start_stack,start_mmap;
    unsigned long arg_start, arg_end, env_start, env_end;
    int pid,pgrp,session,leader;
    int    groups[NGROUPS];
    /* 
     * pointers to (original) parent process, youngest child, younger sibling,
     * older sibling, respectively.  (p->father can be replaced with 
     * p->p_pptr->pid)
     */
    struct task_struct *p_opptr,*p_pptr, *p_cptr, *p_ysptr, *p_osptr;
    struct wait_queue *wait_chldexit;    /* for wait4() */
    /*
     * For ease of programming... Normal sleeps don't need to
     * keep track of a wait-queue: every task has an entry of its own
     */
    unsigned short uid,euid,suid;
    unsigned short gid,egid,sgid;
    unsigned long timeout;
    unsigned long it_real_value, it_prof_value, it_virt_value;
    unsigned long it_real_incr, it_prof_incr, it_virt_incr;
    long utime,stime,cutime,cstime,start_time;
    unsigned long min_flt, maj_flt;
    unsigned long cmin_flt, cmaj_flt;
    struct rlimit rlim[RLIM_NLIMITS]; 
    unsigned short used_math;
    unsigned short rss;    /* number of resident pages */
    char comm[16];
    //struct vm86_struct * vm86_info;
    unsigned long screen_bitmap;
/* file system info */
    int link_count;
    int tty;        /* -1 if no tty, so it must be signed */
    unsigned short umask;
    struct inode * pwd;
    struct inode * root;
    struct inode * executable;
    struct vm_area_struct * mmap;
    struct shm_desc *shm;
    struct sem_undo *semun;
    struct file * filp[NR_OPEN];
    fd_set close_on_exec;
/* ldt for this task - used by Wine.  If NULL, default_ldt is used */
    struct desc_struct *ldt;
/* tss for this task */
    struct tss_struct tss;
#ifdef NEW_SWAP
    unsigned long old_maj_flt;    /* old value of maj_flt */
    unsigned long dec_flt;        /* page fault count of the last time */
    unsigned long swap_cnt;        /* number of pages to swap on next pass */
    short swap_table;        /* current page table */
    short swap_page;        /* current page */
#endif // NEW_SWAP
    struct vm_area_struct *stk_vma;
#else
    long counter;
/* various fields */
    struct task_struct *next_task, *prev_task;
    unsigned long saved_kernel_stack;
    unsigned long start_code, end_code, end_data, start_brk, brk, start_stack, start_mmap;
    struct file * filp[NR_OPEN];
/* ldt for this task - used by Wine.  If NULL, default_ldt is used */
    struct desc_struct *ldt;
/* tss for this task */
    struct tss_struct tss;
#endif
};

/*
 *  INIT_TASK is used to set up the first task table, touch at
 * your own risk!. Base=0, limit=0x1fffff (=2MB)
 */
#if 0
#define INIT_TASK \
/* state etc */    { 0,15,15,0,0,0,0, \
/* debugregs */ { 0, },            \
/* schedlink */    &init_task,&init_task, \
/* signals */    {{ 0, },}, \
/* stack */    0,(unsigned long) &init_kernel_stack, \
/* ec,brk... */    0,0,0,0,0,0,0,0,0,0,0,0,0, \
/* argv.. */    0,0,0,0, \
/* pid etc.. */    0,0,0,0, \
/* suppl grps*/ {NOGROUP,}, \
/* proc links*/ &init_task,&init_task,NULL,NULL,NULL,NULL, \
/* uid etc */    0,0,0,0,0,0, \
/* timeout */    0,0,0,0,0,0,0,0,0,0,0,0, \
/* min_flt */    0,0,0,0, \
/* rlimits */   { {LONG_MAX, LONG_MAX}, {LONG_MAX, LONG_MAX},  \
          {LONG_MAX, LONG_MAX}, {LONG_MAX, LONG_MAX},  \
          {       0, LONG_MAX}, {LONG_MAX, LONG_MAX}}, \
/* math */    0, \
/* rss */    2, \
/* comm */    "swapper", \
/* vm86_info */    NULL, 0, \
/* fs info */    0,-1,0022,NULL,NULL,NULL,NULL, \
/* ipc */    NULL, NULL, \
/* filp */    {NULL,}, \
/* cloe */    {{ 0, }}, \
/* ldt */    NULL, \
/*tss*/    {0,0, \
     sizeof(init_kernel_stack) + (long) &init_kernel_stack, KERNEL_DS, 0, \
     0,0,0,0,0,0, \
     (long) &swapper_pg_dir, \
     0,0,0,0,0,0,0,0,0,0, \
     USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0, \
     _LDT(0),0, \
     0, 0x8000, \
/* ioperm */     {~0, }, \
     _TSS(0), 0, 0,0, \
/* 387 state */    { { 0, }, } \
    } \
}
#else
#define INIT_TASK \
/* state etc */ { 0, \
/* schedlink */ &init_task,&init_task, \
/* stack */ (unsigned long) &init_kernel_stack, \
/* brk */ 0,0,0,0,0,0,0, \
/* filp */    {NULL,}, \
/* ldt */    NULL, \
/*tss*/    {0,0, \
     /* 4BYTE esp0; 2BYTE ss0, __ss0h */sizeof(init_kernel_stack) + (long)&init_kernel_stack, KERNEL_DS, 0, \
     0,0,0,0,0,0, \
     /* 4BYTE cr3 *//*(long)&swapper_pg_dir*/ 0, \
     /* ip, flags, acdb, sp, bp, si, di */ 0,0,0,0,0,0,0,0,0,0, \
     USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0,USER_DS,0, \
     _LDT(0),0, \
     0, 0x8000, \
/* ioperm */     {~0, }, \
     _TSS(0), 0, 0,0, \
/* 387 state */    { { 0, }, } \
    } \
}
#endif

extern struct task_struct init_task;
extern struct task_struct *task[NR_TASKS];
//extern struct task_struct *last_task_used_math;
extern struct task_struct *current;
extern unsigned long volatile jiffies;

extern INT IRQRequest(UINT irq, VOID (*handler)(INT));

#define switch_to(tsk) \
__asm__("cmpl %%ecx, current\n\t" \
    "je 1f\n\t" \
    "cli\n\t" \
    "xchgl %%ecx, current\n\t" \
    "ljmp %0\n\t" \
    "sti\n\t" \
    "clts\n" \
    "1:" \
    : /* no output */ \
    :"m" (*(((char *)&tsk->tss.tr)-4)), \
     "c" (tsk) \
    /*:"cx"*/)

#endif