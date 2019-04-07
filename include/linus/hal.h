#ifndef _HAL_H
#define _HAL_H

#include <linus/types.h>
#include <linus/trap.h>

VOID HalEnableInterrupt(struct gatedesc * p, INT size);

#endif
