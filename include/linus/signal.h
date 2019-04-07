#ifndef _FLOWER_SIGNAL_H
#define _FLOWER_SIGNAL_H

#define SA_NOCLDSTOP	1
#define SA_STACK		0x08000000
#define SA_RESTART		0x10000000
#define SA_INTERRUPT	0x20000000
#define SA_NOMASK		0x40000000
#define SA_ONESHOT		0x80000000

typedef unsigned int sigset_t;		/* 32 bits */

/* Type of a signal handler.  */
typedef void (*__sighandler_t)(int);

struct sigaction {
	__sighandler_t sa_handler;
	sigset_t sa_mask;
	int sa_flags;
	void (*sa_restorer)(void);
};

#endif
