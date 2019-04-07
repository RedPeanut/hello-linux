SUBDIRS = char block

all: driversubdirs

driversubdirs: dummy
	@for i in $(SUBDIRS); do (cd $$i && $(MAKE)) || exit; done

dep:
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) dep) || exit; done

clean:
	rm -f *.o *.a
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean); done

dummy:

#
# include a dependency file if one exists
#
ifeq (.depend,$(wildcard .depend))
include .depend
endif