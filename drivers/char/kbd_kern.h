#ifndef FLOWER_KBD_KERN_H
#define FLOWER_KBD_KERN_H

#include <linus/types.h>

struct kbd_struct {
    unsigned char ledstate;		/* 3 bits */
    unsigned char default_ledstate;
#define VC_SCROLLOCK	0	/* scroll-lock mode */
#define VC_NUMLOCK	1	/* numeric lock mode */
#define VC_CAPSLOCK	2	/* capslock mode */
    unsigned char lockstate;	/* 4 bits - must be in 0..15 */

    unsigned char modeflags;
#define VC_APPLIC	0	/* application key mode */
#define VC_CKMODE	1	/* cursor key mode */
#define VC_REPEAT	2	/* keyboard repeat */
#define VC_CRLF		3	/* 0 - enter sends CR, 1 - enter sends CRLF */
#define VC_META		4	/* 0 - meta, 1 - meta=prefix with ESC */
#define VC_PAUSE	5	/* pause key pressed - unused */
#define VC_RAW		6	/* raw (scancode) mode */
#define VC_MEDIUMRAW	7	/* medium raw (keycode) mode */
};

extern ULONG KbdInitialize(ULONG ulong);

#endif // FLOWER_KBD_KERN_H
