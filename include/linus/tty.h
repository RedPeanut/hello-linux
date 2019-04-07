#ifndef TTY_H_
#define TTY_H_

//#include <linus/tty_driver.h>
#include <linus/fs.h>
#include <linus/tty.h>

//struct TTY_STRUCT;
typedef struct _TTY_STRUCT {

} TTY_STRUCT, *PTTY_STRUCT;

typedef struct _TTY_DRIVER {
    /*
     * Interface routines from the upper tty layer to the tty
     * driver.
     */
    INT (*open)(TTY_STRUCT* tty, FILE* flip);
    VOID (*close)(TTY_STRUCT* tty, FILE* flip);
    INT (*write)(TTY_STRUCT* tty, int from_user,
        const unsigned char* buf, int count);
    VOID (*put_char)(TTY_STRUCT* tty, unsigned char ch);
} TTY_DRIVER, *PTTY_DRIVER;

extern /*ULONG*/BOOL ConInitialize(/*ULONG*/);
extern ULONG TtyInitialize(ULONG);

extern INT TtyRegisterDriver(TTY_DRIVER* driver);

#endif /* TTY_H_ */
