#ifndef CONSOLE_H_
#define CONSOLE_H_

struct VIRTUAL_CONSOLE_DATA;

struct CONSOLE_SWITCH {
    VOID (*putc)(struct VIRTUAL_CONSOLE_DATA*, INT, INT, INT);
    VOID (*putcs)(struct VIRTUAL_CONSOLE_DATA*, CONST USHORT*, INT, INT, INT);
    INT (*scroll)(struct VIRTUAL_CONSOLE_DATA*, INT, INT, INT, INT);
    ULONG (*getxy)(struct VIRTUAL_CONSOLE_DATA*, ULONG, INT*, INT*);
};

typedef struct _CONSOLE_DRIVER {
    char name[8];
    void (*write)(struct _CONSOLE_DRIVER*, CONST CHAR*, UINT);
    struct _CONSOLE_DRIVER* next;
} CONSOLE_DRIVER;

extern VOID PrtkRegisterConsoleDriver(CONSOLE_DRIVER*);
extern INT PrtkUnregisterConsoleDriver(CONSOLE_DRIVER*);

#endif /* CONSOLE_H_ */
