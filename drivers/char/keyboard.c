#include <linus/types.h>
#include "kbd_kern.h"

#ifndef KBD_DEFMODE
#define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
#endif

#ifndef KBD_DEFLEDS
/*
 * Some laptops take the 789uiojklm,. keys as number pad when NumLock
 * is on. This seems a good reason to start with NumLock off.
 */
#define KBD_DEFLEDS 0
#endif

#ifndef KBD_DEFLOCK
#define KBD_DEFLOCK 0
#endif

struct kbd_struct kbd_table = {0,};

ULONG KbdInitialize(ULONG ulong) {
    //int i;
    struct kbd_struct* kbd = &kbd_table;
    kbd->ledstate = KBD_DEFLEDS;
    kbd->default_ledstate = KBD_DEFLEDS;
    kbd->lockstate = KBD_DEFLOCK;
    kbd->modeflags = KBD_DEFMODE;

    //rquest_irq(KEYBOARD_IRQ, keyboard_interrupt);
}
