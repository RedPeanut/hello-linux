#ifndef _FLOWER_HEAD_H
#define _FLOWER_HEAD_H

#include <linus/types.h>

typedef struct desc_struct {
    ULONG a, b;
} desc_table[256];

//extern unsigned long swapper_pg_dir[1024];
//extern desc_table idt;

#endif