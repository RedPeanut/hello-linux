#INTDIR = intermediate
#INCDIR = include
SUBDIRS = 

#CC = gcc-4.exe
CPP	=$(CC) -I../../$(INCDIR) -E
#ASM = nasmw.exe
#LD = ld.exe
#AR = ar.exe
#OBJ = objcopy.exe
#MAKE = make.exe

CFLAGS = -Wall -ffreestanding -I../../$(INCDIR) -D__DEBUG__
LDFLAGS = -nostdlib
#OFLAGS = -j .text -j .data -j .rodata -j .bss -S -O binary

SRCS = $(wildcard *.c)
OBJS = $(notdir $(patsubst %.c,%.o,$(SRCS)))

#SUBDIRS = chr_drv

%.o: %.c
	$(CC) $(CFLAGS) -c $<

all: chr_drv.a

chr_drv.a: $(OBJS)
	$(AR) rcs chr_drv.a $(OBJS)

#subdirs: dummy
#	@for i in $(SURDIRS); do (cd $$i && echo $$i && $(MAKE)) || exit; done

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
