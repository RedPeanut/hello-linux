#include <linus/string.h>
#include <linus/selection.h>
#include <linus/console.h>
#include <linus/console_struct.h>
//#include <linus/tty_driver.h>
#include <linus/tty.h>
#include <linus/printk.h>
#include <linus/kernel.h>
#include <asm/io.h>

#include "console_macros.h"

#define NR_CONSOLES 2

#define KEY_LF 0x0A
#define KEY_CR 0x0D

TTY_DRIVER m_ConsoleDriver;
VIRTUAL_CONSOLE m_VirtualConsole[NR_CONSOLES];

int m_FgConsole;

//static VOID (*m_ConPrintProc)(CHAR*) = 0;

/*
 * INTERNAL FUNCTION DECLARATION
 */
static VOID ConpUpdateCursorPos(INT currcons);

/*
 * EXTERNAL FUNCTION DECLARATION
 */

INT ConpVirtualConsoleAlloc(UINT currcons) {
    return 0;
}

/*
 * Allocate the console screen memory
 */
static INT ConpOpen(TTY_STRUCT* tty, FILE* flip) {
    UINT currcons;
    INT i;

    i = ConpVirtualConsoleAlloc(currcons);

    return 0;
}

static VOID ConpClose(TTY_STRUCT* tty, FILE* flip) {
    if(!tty)
        return;

}

#if 0
static VOID ConpVisualInitialize(int currcons, BOOL init) {
    CONS_NUM = currcons;
    VIDEO_SIZE_ROW = VIDEO_NUM_COLUMNS << 1;
    SCREENBUF_SIZE = 80 * 25;
}

static VOID ConpSetOrigin(INT currcons) {
    ORIGIN = SCREENBUF;
    VISIBLE_ORIGIN = ORIGIN;
    SCR_END = ORIGIN + SCREENBUF_SIZE;
    //POS = ORIGIN + VIDEO_SIZE_ROW * Y + 2 * X;
}

static VOID ConpVirtualConsoleInitialize(INT currcons, BOOL do_clear) {
    ConpSetOrigin(currcons);
    POS = ORIGIN;
}
#endif

static VOID ConpClearScreen(INT currcons) {
    INT i, count;
    UCHAR * start = (UCHAR *)ORIGIN;

    count = VIDEO_NUM_COLUMNS * VIDEO_NUM_LINES;

    for(i = 0; i < count; i++) {
        *start++ = ' ';
        *start++ = DEF_COLOR;
    }
    ConpUpdateCursorPos(currcons);
}

static VOID ConpScrollUp(INT currcons, UINT t, UINT b) {
    CHAR *src, *dst, *until;
    if(t >= b)
        return;

    /* ScrollUp */
    dst = ORIGIN + VIDEO_SIZE_ROW * t;
    src = ORIGIN + VIDEO_SIZE_ROW * (t+1);
    until = ((b-t-1) * VIDEO_NUM_COLUMNS);
    for(;dst < until;) {
        *dst++ = *src++;
        *dst++ = *src++;
    }

    /* Clear last line */
    dst = ORIGIN + ((b-t-1) * VIDEO_SIZE_ROW);
    until = ORIGIN + ((b-t) * VIDEO_SIZE_ROW);
    for(;dst < until;) {
        *dst++ = ' ';
        *dst++ = DEF_COLOR;
    }
}

static VOID ConpKeyLF(INT currcons) {
    if(Y+1 < BOTTOM) {
        Y++;
        POS += VIDEO_SIZE_ROW;
        return;
    } else {
        ConpScrollUp(currcons, TOP, BOTTOM);
        NEED_WRAP = 0;
    }
}

static inline VOID ConpKeyCR(INT currcons) {
    POS -= X << 1;
    NEED_WRAP = X = 0;
}

static VOID ConpUpdateCursorPos(INT currcons) {
    UCHAR data;

    data = (UCHAR)((X+Y*VIDEO_SIZE_ROW)>>8);
    WRITE_PORT_UCHAR((PUCHAR)0x3d4, 0x0e);
    WRITE_PORT_UCHAR((PUCHAR)0x3d5, data);
    //__outb(0x0e, 0x3d4); __outb(data, 0x3d5);
    data = (UCHAR)((X+Y*VIDEO_SIZE_ROW)&0xff);
    WRITE_PORT_UCHAR((PUCHAR)0x3d4, 0x0f);
    WRITE_PORT_UCHAR((PUCHAR)0x3d5, data);
    //__outb(0x0f, 0x3d4); __outb(data, 0x3d5);
}

static VOID ConpConsolePrint(CONST CHAR* b) {
    INT currcons = m_FgConsole;
    CHAR c;

    while((c = *b++) != 0) {
        if(c == KEY_LF || c == KEY_CR || NEED_WRAP) {
            if(c != KEY_CR)
                ConpKeyLF(currcons);
            ConpKeyCR(currcons);
            if(c == KEY_LF || c == KEY_CR)
                continue;
        }
        *(USHORT*)POS = (ATTR << 8) + c;
        if(X == VIDEO_NUM_COLUMNS - 1) {
            NEED_WRAP = 1;
            continue;
        }
        X++;
        POS += 2;
    }
    ConpUpdateCursorPos(currcons);
}

/*ULONG*/BOOL ConInitialize(/*ULONG start_mem*/) {
    int currcons = 0;

    m_FgConsole = 0;
    //mset(&m_ConsoleDriver, 0, sizeof(TTY_DRIVER));

    //ConsoleDriver.open = ConpOpen;
    //ConsoleDriver.close = ConpClose;

    /*if(TtyRegisterDriver(&m_ConsoleDriver)) {
        panic("Couldn't register console driver\n");
        return FALSE;
    }*/

    for(currcons = 0; currcons < /*NR_CONSOLES*/1; currcons++) {

        memset(&m_VirtualConsole[currcons].d, 0x00, sizeof(VIRTUAL_CONSOLE_DATA));

        //SCREENBUF = 1024 * 1024;

        POS = ORIGIN = /*VIDEO_MEM_START = */0xB8000;
        VIDEO_NUM_COLUMNS = 80;
        VIDEO_SIZE_ROW = VIDEO_NUM_COLUMNS << 1;
        VIDEO_NUM_LINES = 25;
        DEF_COLOR = 0x07;

        //ConpVisualInitialize(currcons, TRUE);
        //ConpVirtualConsoleInitialize(currcons, TRUE);
        //ConpResetTerminal(currcons, TRUE);
        X = Y = 0;
        TOP = 0; BOTTOM = 25;
        ATTR = COLOR = DEF_COLOR;
        //ConpClearScreen(currcons);
    }

    PrtkRegisterConsoleProc(ConpConsolePrint);

    return /*start_mem*/TRUE;
}
