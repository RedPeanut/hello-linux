#ifndef TYPES_H_
#define TYPES_H_

#define LOCAL static
#define INLINE inline
#define GLOBAL extern

typedef unsigned int size_t;
typedef int ssize_t;
typedef long long    loff_t;

/*
 * PROCESSOR SPECIFIC DEFINITIONS
 */
#define far
#define near
#define FAR
#define NEAR

/*
 * CONST and NULL POINTER
 */
/* #define NULL             ((void *)0) */
#define CONST               const
#define NULL                0

/*
 * IN/OUT PHANTOM PREFIX USED BY KERNEL API's PARAMETER FIELD
 */
#define IN
#define OUT

#define KERNELAPI

/*
 * HANDLE
 */
typedef void                *HANDLE;
typedef HANDLE              *PHANDLE;

/*
 * PROCESSOR INDEPENDANT VARIABLE's SIZE DEFINITIONS
 */
typedef void                VOID;
typedef VOID near           *PVOID;
typedef VOID far            *LPVOID;
typedef CONST void far      *LPCVOID;

typedef char                CHAR;
typedef CHAR                *PCHAR;
typedef unsigned char       UCHAR;
typedef UCHAR               *PUCHAR;
typedef unsigned char       BYTE;
typedef BYTE near           *PBYTE;
typedef BYTE far            *LPBYTE;

typedef unsigned short      WORD;
typedef WORD                *PWORD;
typedef const WORD          *PCWORD;
typedef unsigned short      USHORT;
typedef USHORT              *PUSHORT;
typedef const USHORT        *PCSHORT;

typedef long                LONG;
typedef LONG                *PLONG;
typedef unsigned long       ULONG;
typedef ULONG               *PULONG;
typedef unsigned long       DWORD;
typedef DWORD               *PDWORD;

typedef int                 INT;
typedef INT                 *PINT;
typedef unsigned int        UINT;
typedef UINT                *PUINT;

typedef float               FLOAT;
typedef FLOAT               *PFLOAT;

typedef double              DOUBLE;
typedef DOUBLE              *PDOUBLE;

typedef unsigned char INT8U;
typedef unsigned short INT16U;
typedef unsigned int INT32U;

typedef char INT8S;
typedef short UINT16S;
typedef int UINT32S;

typedef unsigned int OS_STACK;

typedef CHAR * STRING;

/*
 * BOOL DEFINITIONS
 */
typedef enum {
    FALSE, TRUE
} BOOL, *PBOOL, *LPBOOL, BOOLEAN;

typedef enum { false, true } boolean;

/*
 * STRING ASSOCIATED DEFINITIONS
 */
typedef CHAR near           *PSTR;
typedef CONST CHAR near     *CPSTR;
typedef CHAR far            *LPSTR;
typedef CONST CHAR far      *LPCSTR;
typedef CONST CHAR far      *LPCTSTR;

/* LINUS ASSOCIATED DEFINITIONS */
typedef int pid_t;

#endif /* TYPES_H_ */
