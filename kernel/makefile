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
OBJS = $(COBJS) $(SOBJS) ksyms.o vectors.o trapasm.o os_cpu_a.o

#SUBDIRS = chr_drv

%.o: %.c
	$(CC) $(CFLAGS) -c $<
#%.E: %.s
#	$(CPP) -traditional $< -o $*.E
#%.o: %.E
#	$(ASM) -f elf -o $@ $<
%.o: %.s
	$(ASM) -f elf -o $@ $<
%.o: %.S
	$(AS) -c -o $@ $<

all: kernel.o

kernel.o: $(OBJS)
	$(LD) $(LDFLAGS) -r -o $@ $(OBJS)

ksyms.o: ksyms.E
	$(AS) -c -o $@ $<

ksyms.E: ksyms.sh ksyms.lst
	sh $< > $@

ksyms.lst: ksyms.S
	$(CPP) $(CFLAGS) $< > $@
	
vectors.S: vectors.pl
	perl $< > $@

trapasm.o: trapasm.E
	$(AS) -c -o $@ $<
trapasm.E: trapasm.S
	$(CPP) -traditional $< -o $@

os_cpu_a.o: os_cpu_a.E
	$(AS) -c -o $@ $<
os_cpu_a.E: os_cpu_a.S
	$(CPP) -traditional $< -o $@
	
#sys_call.E: sys_call.s

#sys_call.o: sys_call.E

#subdirs: dummy
#	@for i in $(SUBDIRS); do (cd $$i && $(MAKE)) || exit; done

clean:
	rm -f *.o *.a \
	vectors.S
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
