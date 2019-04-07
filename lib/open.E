# 1 "lib/open.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "lib/open.c"







# 1 "./include/flower/unistd.h" 1
# 145 "./include/flower/unistd.h"
extern int errno;
# 9 "lib/open.c" 2
# 1 "./include/stdarg.h" 1




typedef char *va_list;
# 10 "lib/open.c" 2

int open(const char * filename, int flag, ...) {
 register int res;
 va_list arg;

 (arg = (va_list)(&(flag)) + ((sizeof(flag) + sizeof(int) - 1) & ~(sizeof(int) - 1)));
 __asm__("movl %2,%%ebx\n\t"
  "int $0x80"
  : "=a"(res)
  : "0"(5),
      "g"((long)(filename)),
      "c"(flag),
      "d"((*(int*)((arg += ((sizeof(int) + sizeof(int) - 1) & ~(sizeof(int) - 1))) - ((sizeof(int) + sizeof(int) - 1) & ~(sizeof(int) - 1)))))
  );
 if (res>=0)
  return res;
 errno = -res;
 return -1;
}
