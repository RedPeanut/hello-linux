#ifndef FLOWER_PTRACE_H
#define FLOWER_PTRACE_H

struct pt_regs {
  long ebx;
  long ecx;
  long edx;
  long esi;
  long edi;
  long ebp;
  long eax;
  unsigned short ds, __dsu;
  unsigned short es, __esu;
  unsigned short fs, __fsu;
  unsigned short gs, __gsu;
  long orig_eax;
  long eip;
  unsigned short cs, __csu;
  long eflags;
  long esp;
  unsigned short ss, __ssu;
};

#endif // FLOWER_PTRACE_H
