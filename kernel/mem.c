#include <linus/tty.h>

BOOL ChrDevInitialize(ULONG mem_start, ULONG mem_end) {
    TtyInitialize(mem_start);
    return TRUE;
}

