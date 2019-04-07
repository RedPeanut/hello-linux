/*
 *  linux/tools/build.c
 *
 *  Copyright (C) 1991, 1992  Linus Torvalds
 */

/*
 * This file builds a disk-image from three different files:
 *
 * - bootsect: max 510 bytes of 8086 machine code, loads the rest
 * - entry: max 1 sectors of 8086 machine code, sets up kernel parm
 * - kernel: 80386 code for actual kernel
 *
 * It does some checking that all files are of the correct type, and
 * just writes the result to stdout, removing headers and padding to
 * the right amount. It also writes some kernel data to stderr.
 */

/*
 * Changes by tytso to allow root device specification
 */

#include <stdio.h>    /* fprintf */
#include <string.h>
#include <stdlib.h>    /* contains exit */
#include <sys/types.h>    /* unistd.h needs this */
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <unistd.h>    /* contains read/write */
#include <fcntl.h>
//#include <linus/config.h>
//#include <linus/a.out.h>

#define MINIX_HEADER 32
#define GCC_HEADER 1024

#define SYS_SIZE DEF_SYSSIZE

#define DEFAULT_MAJOR_ROOT 0
#define DEFAULT_MINOR_ROOT 0

/* max nr of sectors of entry: don't change unless you also change
 * bootsect etc */
#define ENTRY_SECTS 1

#define STRINGIFY(x) #x

typedef union {
    long l;
    short s[2];
    char b[4];
} conv;

long intel_long(long l) {
    conv t;

    t.b[0] = l & 0xff; l >>= 8;
    t.b[1] = l & 0xff; l >>= 8;
    t.b[2] = l & 0xff; l >>= 8;
    t.b[3] = l & 0xff; l >>= 8;
    return t.l;
}

short intel_short(short l) {
    conv t;

    t.b[0] = l & 0xff; l >>= 8;
    t.b[1] = l & 0xff; l >>= 8;
    return t.s[0];
}

void die(char * str) {
    fprintf(stderr,"%s\n",str);
    exit(1);
}

void usage(void) {
    die("Usage: build bootsect entry kernel [rootdev] [> image]");
}

// [0:tools/build] [1:boot/bootsect.bin] [2:boot/entry.bin] [3:output/kernel.bin] [4:$(ROOT_DEV)] > zImage
int main(int argc, char ** argv) {
    int i,c,id, sz;
    unsigned long sys_size;
    char buf[1024];
    struct exec *ex = (struct exec *)buf;
    char major_root, minor_root;
    struct stat sb;

    if((argc < 4) || (argc > 5))
        usage();
    if(argc > 4) {
        if(!strcmp(argv[4], "CURRENT")) {
            if(stat("/", &sb)) {
                perror("/");
                die("Couldn't stat /");
            }
            major_root = major(sb.st_dev);
            minor_root = minor(sb.st_dev);
        } else if(strcmp(argv[4], "FLOPPY")) {
            if(stat(argv[4], &sb)) {
                perror(argv[4]);
                die("Couldn't stat root device.");
            }
            major_root = major(sb.st_rdev);
            minor_root = minor(sb.st_rdev);
        } else {
            major_root = 0;
            minor_root = 0;
        }
    } else {
        major_root = DEFAULT_MAJOR_ROOT;
        minor_root = DEFAULT_MINOR_ROOT;
    }
    fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
    for(i = 0; i < sizeof buf; i++) buf[i] = 0;
    if((id = open(argv[1], O_RDONLY, 0)) < 0)
        die("Unable to open 'boot'");
    /*if(read(id,buf,MINIX_HEADER) != MINIX_HEADER)
        die("Unable to read header of 'boot'");
    if(((long *) buf)[0]!=intel_long(0x04100301))
        die("Non-Minix header of 'boot'");
    if(((long *) buf)[1]!=intel_long(MINIX_HEADER))
        die("Non-Minix header of 'boot'");
    if(((long *) buf)[3] != 0)
        die("Illegal data segment in 'boot'");
    if(((long *) buf)[4] != 0)
        die("Illegal bss in 'boot'");
    if(((long *) buf)[5] != 0)
        die("Non-Minix header of 'boot'");
    if(((long *) buf)[7] != 0)
        die("Illegal symbol table in 'boot'");*/
    i = read(id, buf, sizeof buf);
    fprintf(stderr,"Boot sector %d bytes.\n",i);
    if(i != 512)
        die("Boot block must be exactly 512 bytes");
    if((*(unsigned short *)(buf+510)) != (unsigned short)intel_short(0xAA55))
        die("Boot block hasn't got boot flag (0xAA55)");
    buf[508] = (char) minor_root;
    buf[509] = (char) major_root;    
    i = write(1, buf, 512);
    if(i!=512)
        die("Write call failed");
    close (id);
#if 0
    if((id = open(argv[2], O_RDONLY, 0)) < 0)
        die("Unable to open 'entry'");
    /*if(read(id,buf,MINIX_HEADER) != MINIX_HEADER)
        die("Unable to read header of 'entry'");
    if(((long *) buf)[0]!=intel_long(0x04100301))
        die("Non-Minix header of 'entry'");
    if(((long *) buf)[1]!=intel_long(MINIX_HEADER))
        die("Non-Minix header of 'entry'");
    if(((long *) buf)[3] != 0)
        die("Illegal data segment in 'entry'");
    if(((long *) buf)[4] != 0)
        die("Illegal bss in 'entry'");
    if(((long *) buf)[5] != 0)
        die("Non-Minix header of 'entry'");
    if(((long *) buf)[7] != 0)
        die("Illegal symbol table in 'entry'");*/
    for(i = 0 ; (c = read(id, buf, sizeof buf)) > 0; i+=c )
        if(write(1, buf, c) != c)
            die("Write call failed");
    if(c != 0)
        die("read-error on 'entry.bin'");
    close(id);
    if(i > ENTRY_SECTS * 512)
        die("Entry exceeds " STRINGIFY(ENTRY_SECTS)
            " sectors - rewrite boot/entry.bin");
    fprintf(stderr,"Entry is %d bytes.\n",i);
    
    /* clear the buf */
    for(c = 0 ; c < sizeof(buf) ; c++)
        buf[c] = '\0';

    // fill padding, align 512 bytes
    while(i < ENTRY_SECTS * 512) {
        c = ENTRY_SECTS * 512 - i;
        if(c > sizeof(buf))
            c = sizeof(buf);
        if(write(1, buf, c) != c)
            die("Write call failed");
        i += c;
    }
#endif
    
    if((id = open(argv[3], O_RDONLY, 0)) < 0)
        die("Unable to open 'kernel'");
#if 0
    if(read(id, buf, GCC_HEADER) != GCC_HEADER)
        die("Unable to read header of 'kernel'");
    if(N_MAGIC(*ex) != ZMAGIC)
        die("Non-GCC header of 'kernel'");
    fprintf(stderr,"Kernel is %d kB (%d kB code, %d kB data and %d kB bss)\n",
        (ex->a_text+ex->a_data+ex->a_bss)/1024,
        ex->a_text /1024,
        ex->a_data /1024,
        ex->a_bss  /1024);
    sz = N_SYMOFF(*ex) - GCC_HEADER + 4;
    sys_size = (sz + 15) / 16;
    if(sys_size > SYS_SIZE)
        die("Kernel is too big");
#endif

#if 0
    while(sz > 0) {
        int l, n;

        l = sz;
        if(l > sizeof(buf))
            l = sizeof(buf);
        if((n = read(id, buf, l)) != l) {
            if(n == -1) 
                perror(argv[1]);
            else
                fprintf(stderr, "Unexpected EOF\n");
            die("Can't read 'kernel'");
        }
        if(write(1, buf, l) != l)
            die("Write failed");
        sz -= l;
    }
#else
    sys_size = lseek(id, 0, SEEK_END);
#endif

    close(id);
    if(lseek(1,500,0) == 500) {
        buf[0] = (sys_size & 0xff);
        buf[1] = ((sys_size >> 8) & 0xff);
        if(write(1, buf, 2) != 2)
            die("Write failed");
    }
    return(0);
}
