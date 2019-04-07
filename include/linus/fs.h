#ifndef FS_H_
#define FS_H_

#include <linus/types.h>
//#include <linus/sched.h>

#define NR_OPEN 256

typedef struct _BUFFER {
    CHAR * data; /* pointer to data block (1024 bytes) */
    ULONG blocknr; /* block number */
    USHORT dev; /* device (0 = free) */
    UCHAR uptodate;
    UCHAR dirt; /* 0-clean,1-dirty */
    // dirty flag: dirty flag is used very frequently here and there, from my experience of coding life
    // normally used, on/off flag(=binary flag)
    // i think binary flag is waste of bit~, i think so~, 
    // why i feel wasteness for the 7bit? :)
    // 
    UCHAR count; /* users using this block */
    UCHAR lock; /* 0 - ok, 1 -locked */
    struct task_struct * wait;
    struct _BUFFER * prev;
    struct _BUFFER * next;
    struct _BUFFER * prev_free;
    struct _BUFFER * next_free;
} BUFFER, *PBUFFER;;

struct file {
#if 0
    mode_t f_mode;
    dev_t f_rdev; /* needed for /dev/tty */
    off_t f_pos;
    unsigned short f_flags;
    unsigned short f_count;
    unsigned short f_reada;
    struct file *f_next, *f_prev;
    struct inode * f_inode;
    struct file_operations * f_op;
#else
    struct file *f_next, *f_prev;
#endif
};

typedef struct _FILE {
    unsigned int f_flags;
    struct _FILE * next, * prev;
} FILE, *PFILE;

typedef struct _FILE_FOPS {
    ssize_t (*read)(FILE*, char*, size_t, loff_t*);
} FILE_FOPS;

#endif /* FS_H_ */
