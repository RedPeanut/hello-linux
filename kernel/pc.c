#include <linus/types.h>
#include <linus/pc.h>

#define DISP_BASE 0xb8000
#define DISP_MAX_X 80
#define DISP_MAX_Y 25

// before i have develop lock method, i only use these functions below
// scrolling is not capable because display conflict

VOID PC_DisplayCharacter(INT8U x, INT8U y, INT8U * c, INT8U color) {
    INT8U * pscr;
    INT16U offset;

    offset = (INT16U)y * DISP_MAX_X * 2 + (INT16U)x * 2;
    pscr = DISP_BASE + offset;
    *pscr++ = c;
    *pscr = color;
}

VOID PC_ClearScreen(INT8U color) {
    INT8U * pscr;
    INT16U i;

    pscr = DISP_BASE + 0x0000;
    for(i = 0; i < (DISP_MAX_X * DISP_MAX_Y); i++) {
        *pscr++ = ' ';
        *pscr++ = color;
    }
}

void PC_DisplayString (INT8U x, INT8U y, INT8U *s, INT8U color) {
    INT8U  far *pscr;
    INT16U      offset;

    offset = (INT16U)y * DISP_MAX_X * 2 + (INT16U)x * 2; /* Calculate position of 1st character */
    pscr = DISP_BASE + offset;
    while(*s) {
        *pscr++ = *s++; /* Put character in video RAM */
        *pscr++ = color; /* Put video attribute in video RAM */
    }
}

#if 0
VOID PC_ScrollUp(INT8U t, INT8U b) {
    INT8U * src, * dst, * until;

    dst = DISP_BASE + DISP_MAX_X * 2 * t;
    src = DISP_BASE + DISP_MAX_X * 2 * (t + 1);
    until = DISP_BASE + ((b - t - 1) * DISP_MAX_X);
    for(;dst < until;) {
        *dst++ = *src++; *dst++ = *src++;
    }

    dst = DISP_BASE + (b - t - 1) * DISP_MAX_X * 2;
    until = DISP_BASE + (b - t) * DISP_MAX_X * 2;
    for(;dst < until;) {
        *dst++ = ' ';
        *dst++ = DISP_FGND_LIGHT_GRAY;
    }
}
#endif
