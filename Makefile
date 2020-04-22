TOPTARGET := all clean

SUBDIRS := $(wildcard acceleration-*/.)

$(TOPTARGET): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGET) $(SUBDIRS)
