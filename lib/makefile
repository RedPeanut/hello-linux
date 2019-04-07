#INTDIR = intermediate
#INCDIR = include
SUBDIRS = 

#CC = gcc-4.exe
CPP = $(CC) -I../$(INCDIR) -E
#ASM = nasmw.exe
#LD = ld.exe
#OBJ = objcopy.exe
#MAKE = make.exe

CFLAGS = -Wall -ffreestanding -I../$(INCDIR) -D__DEBUG__
LDFLAGS = -nostdlib
OFLAGS = -j .text -j .data -j .rodata -j .bss -S -O binary

CSRCS = $(wildcard *.c)
COBJS = $(notdir $(patsubst %.c,%.o,$(CSRCS)))
SSRCS = $(wildcard *.s)
SOBJS = $(notdir $(patsubst %.s,%.o,$(SSRCS)))
OBJS = $(COBJS) $(SOBJS)

#SUBDIRS	= chr_drv

%.o: %.c
	$(CC) $(CFLAGS) -c $<
#%.E: %.s
#	$(CPP) -traditional $< -o $*.E
#%.o: %.E
#	$(ASM) -f elf -o $@ $<
%.o: %.s
	$(ASM) -f elf -o $@ $<

lib.a: $(OBJS)
	$(AR) rcs lib.a $(OBJS)
	sync
#	$(LD) $(LDFLAGS) -r -o $@ $(OBJS)

#sys_call.E: sys_call.s

#sys_call.o: sys_call.E

#subdirs: dummy
#	@for i in $(SUBDIRS); do (cd $$i && $(MAKE)) || exit; done

clean:
	rm -f *.o *.a
#	for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean); done

dep:
	$(CPP) -M *.c > .depend
#	for i in $(SUBDIRS); do (cd $$i && $(MAKE) dep) || exit; done

dummy:

#
# include a dependency file if one exists
#
ifeq (.depend,$(wildcard .depend))
include .depend
endif
