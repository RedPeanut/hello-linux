#include <linus/types.h>

void* memset(void* s, char c, size_t count) {
    int i;
    char* _s = (char*)s;

    for(i = 0; i < count; i++) {
        *_s++ = c;
    }
#if 0
__asm__("cld\n\t"
    "rep\n\t"
    "stosb"
    : /* no output */
    :"a" (c),"D" (s),"c" (count)
    :"cx","di","memory");
#endif
return s;
}

void* memcpy(void* to, const void* from, size_t n) {
    int i;
    char *_to = (char*)to, *_from = (char*)from;

    for(i = 0; i < n; i++) {
        *_to++ = *_from++;
    }
#if 0
__asm__("cld\n\t"
    "movl %%edx, %%ecx\n\t"
    "shrl $2,%%ecx\n\t"
    "rep ; movsl\n\t"
    "testb $1,%%dl\n\t"
    "je 1f\n\t"
    "movsb\n"
    "1:\ttestb $2,%%dl\n\t"
    "je 2f\n\t"
    "movsw\n"
    "2:\n"
    : /* no output */
    :"d" (n),"D" ((long) to),"S" ((long) from)
    : "cx","di","si","memory");
#endif
return (to);
}
