#ifndef PRINTK_H_
#define PRINTK_H_

#include <linus/linkage.h>
#include <linus/types.h>

int printk(const char* fmt, ...);

VOID PrtkRegisterConsoleProc(VOID (*proc)(CONST CHAR*));

#endif /* PRINTK_H_ */
