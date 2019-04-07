#INTDIR = intermediate
#INCDIR = include
SUBDIRS = 

#CC = gcc-4.exe
CPP =$(CC) -I../$(INCDIR) -E
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
%.o: %.s
	$(ASM) -f elf -o $@ $<

all: mm.o #subdirs

mm.o: $(OBJS)
	$(LD) $(LDFLAGS) -r -o $@ $(OBJS)

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
