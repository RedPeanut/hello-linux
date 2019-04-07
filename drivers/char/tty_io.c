#include <linus/tty.h>

INT TtyRegisterDriver(TTY_DRIVER* driver) {
    return 0;
}

ULONG TtyInitialize(ULONG mem_start) {
    mem_start = KbdInitialize(mem_start);
    mem_start = ConInitialize(mem_start);
    return mem_start;
}

