#include <stdarg.h>
#include <linus/printk.h>
#include <linus/kernel.h>
#include <linus/vsprintf.h>

/*
 * Display a message, then unblank the console and perform
 * cleanups, Functions in the panic notifier list are called
 * after the filesystem cache is flushed (when possible).
 *
 * This function never returns.
 */

NORET_TYPE void panic(const char* fmt, ...) {
    static char buf[1024];
    va_list args;

    va_start(args, fmt);
    vsprintf(buf, fmt, args);
    va_end(args);
    printk(KERN_EMERG "Kernel panic: %s", buf);

    for(;;);
}
