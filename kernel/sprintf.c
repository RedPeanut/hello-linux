#include <linus/vsprintf.h>

int sprintf(char * s, const char * format, ...) {
    va_list args;
    int i;
    
    va_start(args, format);
    i = vsprintf(s, format, args);
    va_end(args);

    return i;
}
