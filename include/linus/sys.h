#ifndef _LINUS_SYS_H
#define _LINUS_SYS_H
/*
 * system call entry points
 */

#ifdef __cplusplus
extern "C" {
#endif

#include <linus/types.h>
#include <linus/ptrace.h>

//extern int sys_read(void);
extern int sys_open(const char *, int, int);
extern int sys_execve(struct pt_regs regs);
int sys_waitpid(pid_t pid, unsigned long * stat_addr, int options);

typedef int (*fn_ptr)(void);

#ifdef __cplusplus
}
#endif

#endif

