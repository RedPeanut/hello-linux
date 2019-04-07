/*
 *  linux/lib/open.c
 *
 *  Copyright (C) 1991, 1992  Linus Torvalds
 */

#define __LIBRARY__
#include <linus/unistd.h>
#include <stdarg.h>

int open(const char * filename, int flag, ...) {
	register int res;
	//va_list arg;
	char* arg;

	//va_start(arg, flag);
	(arg = (char*)(&(flag)) + ((sizeof(flag) + sizeof(int) - 1) & ~(sizeof(int) - 1)));
	
	__asm__("movl %2, %%ebx\n\t"
		"int $0x80"
		: "=a"(res) // output: eax
		: "0"(__NR_open),  // inputs: eax,
    		"g"((long)(filename)),  // {register, memory, immediate integer},
    		"c"(flag), // ecx,
    		//"d"(va_arg(arg, int)) // edx
    		"d"((*(int*)((arg += ((sizeof(int) + sizeof(int) - 1) & ~(sizeof(int) - 1))) - ((sizeof(int) + sizeof(int) - 1) & ~(sizeof(int) - 1)))))
		);
		
	if (res>=0)
		return res;
	errno = -res;
	return -1;
}
