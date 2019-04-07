#ifndef _ASM_IO_H
#define _ASM_IO_H

#include <linus/types.h>
#include <linus/linkage.h>

#if 0
/*extern*/static inline unsigned int __inb(unsigned short port) {
    unsigned int _v;
    __asm__ __volatile__(
        "inb %w1, %b0" 
        : "=a"(_v) 
        : "d"(port) , "0"(0) );
    return _v;
}

/*extern*/static inline void __outb(unsigned char value, unsigned short port) {
    __asm__ __volatile__(
        "outb %b0, %w1" 
        : 
        : "a"(value), "d"(port));
}
#endif

ASMLINKAGE UCHAR READ_PORT_UCHAR(PUCHAR port);
ASMLINKAGE VOID WRITE_PORT_UCHAR(PUCHAR port, UCHAR value);

#endif