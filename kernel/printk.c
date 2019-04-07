#include <linus/linkage.h>
#include <linus/types.h>
#include <linus/vsprintf.h>
#include <linus/console.h>
#include <linus/printk.h>

//struct ConsoleDriver* m_ConsoleDrivers;
static VOID (*PrtkpConsoleProc)(CONST CHAR*) = 0;

int printk(const char* fmt, ...) {
    va_list args;
    int i;
    static char buf[1024];
    
    va_start(args, fmt);
    i = vsprintf(buf, fmt, args);
    va_end(args);

    if(PrtkpConsoleProc)
        (*PrtkpConsoleProc)(buf);

    return i;
}

VOID PrtkRegisterConsoleProc(VOID (*proc)(CONST CHAR*)) {
    PrtkpConsoleProc = proc;
}
