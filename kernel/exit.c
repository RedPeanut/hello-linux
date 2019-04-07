//#include <linus/sys.h>
#include <linus/errno.h>
#include <linus/sched.h>

int sys_waitpid(pid_t pid,unsigned long * stat_addr, int options) {
    int flag, code;
    struct task_struct ** p;
#if 0
    verify_area(stat_addr, 4);
repeat:
    flag=0;
    for(p = &LAST_TASK ; p > &FIRST_TASK ; --p) {
        if (!*p || *p == current)
            continue;
        if ((*p)->father != current->pid)
            continue;
        if (pid>0) {
            if ((*p)->pid != pid)
                continue;
        } else if (!pid) {
            if ((*p)->pgrp != current->pgrp)
                continue;
        } else if (pid != -1) {
            if ((*p)->pgrp != -pid)
                continue;
        }
        switch ((*p)->state) {
            case TASK_STOPPED:
                if (!(options & WUNTRACED))
                    continue;
                put_fs_long(0x7f,stat_addr);
                return (*p)->pid;
            case TASK_ZOMBIE:
                current->cutime += (*p)->utime;
                current->cstime += (*p)->stime;
                flag = (*p)->pid;
                code = (*p)->exit_code;
                release(*p);
                put_fs_long(code,stat_addr);
                return flag;
            default:
                flag=1;
                continue;
        }
    }
    if (flag) {
        if (options & WNOHANG)
            return 0;
        current->state = TASK_INTERRUPTIBLE;
        schedule();
        if (!(current->signal &= ~(1<<(SIGCHLD-1))))
            goto repeat;
        else
            return -EINTR;
    }
#endif
    return -ECHILD;
}

