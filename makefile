ARCH := i386
TOPDIR := $(shell /bin/pwd)

INTDIR = intermediate
OUTDIR = output
BOOTDIR = boot
INCDIR = include
SUBDIRS = kernel drivers fs mm lib

OSDIR = linus

export INTDIR OUTDIR INCDIR

Q = i386-pc-linux-
CROSS_COMPILE = $(Q)
CC = $(CROSS_COMPILE)gcc.exe
LD = $(CROSS_COMPILE)ld.exe
OBJ = $(CROSS_COMPILE)objcopy.exe
AR = $(CROSS_COMPILE)ar.exe
AS = $(CROSS_COMPILE)as.exe
CPP	=$(CC) -I./$(INCDIR) -E
HOSTCC = gcc.exe
ASM = nasmw.exe
MAKE = make.exe

export ARCH TOPDIR ASM LD CC CPP OBJ MAKE AR AS

CFLAGS = -ffreestanding -I./$(INCDIR) -D__DEBUG__
LDFLAGS = -nostdlib
OFLAGS = -j .text -j .data -j .rodata -j .bss -S -O binary

#DRIVERS-y :=
#DRIVERS-y += drivers/char/char.o
#DRIVERS := $(DRIVERS-y)

ARCHIVES = kernel/kernel.o mm/mm.o fs/fs.o
#DRIVERS = kernel/chr_drv/chr_drv.a
DRIVERS = drivers/char/chr_drv.a drivers/block/blk_drv.a
LIBS = lib/lib.a

all: pre \
	$(OUTDIR)/bootsect.bin $(OUTDIR)/kernel.bin \
	post

pre:
	if [ ! -a $(INTDIR) ]; then mkdir -p $(INTDIR); fi
	if [ ! -a $(OUTDIR) ]; then mkdir -p $(OUTDIR); fi

post:

subdirs: dummy
	@for i in $(SUBDIRS); do (cd $$i && echo $$i && $(MAKE)) || exit; done
	
boot/bootsect.bin: boot/bootsect.s
	$(ASM) -f bin -Iinclude/ -o $@ $<

boot/entry.bin: boot/entry.s
	$(ASM) -f bin -l $(INTDIR)/entry.lst -o $@ $<

boot/head.o: boot/head.E
	$(AS) -c -o $@ $<
	
boot/head.E: boot/head.S include/linus/tasks.h
	$(CPP) -traditional $< -o $@

init/main.o: init/main.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OUTDIR)/kernel.elf: boot/head.o init/main.o subdirs
	$(LD) $(LDFLAGS) -Ttext 0x20200 boot/head.o init/main.o \
	$(ARCHIVES) $(DRIVERS) $(LIBS) \
	-o $@
	nm $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( a \)' | \
		sort > $(OUTDIR)/kernel.map

$(OUTDIR)/kernel.elf.bin: $(OUTDIR)/kernel.elf
	$(OBJ) $(OFLAGS) $< $@

$(OUTDIR)/kernel.bin: boot/entry.bin $(OUTDIR)/kernel.elf.bin
	cat boot/entry.bin $(OUTDIR)/kernel.elf.bin > $@

$(OUTDIR)/bootsect.bin: boot/bootsect.bin boot/entry.bin $(OUTDIR)/kernel.bin tools/build.exe
	tools/build.exe boot/bootsect.bin boot/entry.bin $(OUTDIR)/kernel.bin > $(OUTDIR)/bootsect.bin

tools/build.exe: tools/build.c
	$(HOSTCC) -D__KERNEL__ \
	-include ./$(INCDIR)/$(OSDIR)/a.out.h \
	-include ./$(INCDIR)/$(OSDIR)/config.h \
	-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe \
	-o $@ $<

clean:
	rm -f boot/bootsect.bin boot/entry.bin \
		$(OUTDIR)/kernel.elf $(OUTDIR)/kernel.elf.bin $(OUTDIR)/kernel.bin $(OUTDIR)/kernel.map
	rm -f init/*.o
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean); done

depend dep:
	for i in init/*.c; do echo -n "init/"; $(CPP) -M $$i; done > .depend
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) dep) || exit; done

dummy:

#
# include a dependency file if one exists
#
ifeq (.depend,$(wildcard .depend))
include .depend
endif
