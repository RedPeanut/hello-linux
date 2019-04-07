# 1 "init/main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "init/main.c"
# 1 "./include/linus/linkage.h" 1
# 2 "init/main.c" 2
# 1 "./include/linus/types.h" 1



typedef unsigned int size_t;
typedef int ssize_t;
typedef long long loff_t;
# 34 "./include/linus/types.h"
typedef void *HANDLE;
typedef HANDLE *PHANDLE;




typedef void VOID;
typedef VOID *PVOID;
typedef VOID *LPVOID;
typedef const void *LPCVOID;

typedef char CHAR;
typedef CHAR *PCHAR;
typedef unsigned char UCHAR;
typedef UCHAR *PUCHAR;
typedef unsigned char BYTE;
typedef BYTE *PBYTE;
typedef BYTE *LPBYTE;

typedef unsigned short WORD;
typedef WORD *PWORD;
typedef const WORD *PCWORD;
typedef unsigned short USHORT;
typedef USHORT *PUSHORT;
typedef const USHORT *PCSHORT;

typedef long LONG;
typedef LONG *PLONG;
typedef unsigned long ULONG;
typedef ULONG *PULONG;
typedef unsigned long DWORD;
typedef DWORD *PDWORD;

typedef int INT;
typedef INT *PINT;
typedef unsigned int UINT;
typedef UINT *PUINT;

typedef float FLOAT;
typedef FLOAT *PFLOAT;

typedef double DOUBLE;
typedef DOUBLE *PDOUBLE;




typedef enum {
    FALSE, TRUE
} BOOL, *PBOOL, *LPBOOL, boolean;




typedef CHAR *PSTR;
typedef const CHAR *CPSTR;
typedef CHAR *LPSTR;
typedef const CHAR *LPCSTR;
typedef const CHAR *LPCTSTR;
# 3 "init/main.c" 2
# 1 "./include/linus/unistd.h" 1
# 145 "./include/linus/unistd.h"
extern int errno;
# 4 "init/main.c" 2

static inline int fork(void) { long __res; __asm__ volatile ("int $0x80" : "=a"(__res) : "0"(2)); if(__res >= 0) return (int) __res; errno = -__res; return -1; }
static inline int dup(int fd) { long __res; __asm__ volatile ("int $0x80" : "=a"(__res) : "0"(41), "b"((long)(fd))); if(__res >= 0) return (int) __res; errno = -__res; return -1; }
static inline int execve(const char * file,char ** argv,char ** envp) { long __res; __asm__ volatile ("int $0x80" : "=a"(__res) : "0"(11), "b"((long)(file)), "c"((long)(argv)), "d"((long)(envp))); if(__res>=0) return (int) __res; errno = -__res; return -1; }
static inline int open(const char * file,int flag,int mode) { long __res; __asm__ volatile ("int $0x80" : "=a"(__res) : "0"(5), "b"((long)(file)), "c"((long)(flag)), "d"((long)(mode))); if(__res>=0) return (int) __res; errno = -__res; return -1; }
static inline int close(int fd) { long __res; __asm__ volatile ("int $0x80" : "=a"(__res) : "0"(6), "b"((long)(fd))); if(__res >= 0) return (int) __res; errno = -__res; return -1; }

extern VOID TrapInitialize(VOID);
extern VOID IRQInitialize(VOID);
extern VOID SchedInitialize(VOID);
extern BOOL kMallocInitialize(ULONG, ULONG);
extern BOOL ChrDevInitialize(ULONG, ULONG);
extern BOOL BlkDevInitialize(ULONG, ULONG);


 int StartKernel(void) {

    static ULONG memory_start = 0;
    static ULONG memory_end = 0;






    TrapInitialize();
    IRQInitialize();
    SchedInitialize();

    memory_start = 1024 * 1024;

    memory_start = kMallocInitialize(memory_start, memory_end);
    memory_start = ChrDevInitialize(memory_start, memory_end);
    memory_start = BlkDevInitialize(memory_start, memory_end);

    panic("ccc: long time later, this code will not be executed!\r\n");

    return 0;
}
