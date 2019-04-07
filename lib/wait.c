#include <linus/unistd.h>
#include <linus/types.h>

//_syscall3(pid_t, waitpid, pid_t, pid, int *, wait_stat, int, options)
//#define _syscall3(type,name,atype,a,btype,b,ctype,c)
pid_t waitpid(pid_t pid, int * wait_stat,int options) {
    long __res;
    __asm__ __volatile__("int $0x80"
        : "=a"(__res)
        : "0"(__NR_waitpid), "b"((long)(pid)), "c"((long)(wait_stat)), "d"((long)(options)));
        if(__res >= 0)
            return (pid_t)__res;
        errno = -__res;
    return -1;
}

pid_t wait(int * wait_stat) {
    return waitpid(-1, wait_stat, 0);
}

