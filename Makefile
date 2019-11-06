# erzeugt Dienstag, 05. November 2019 16:20 (C) 2019 von Leander Jedamus
# modifiziert Mittwoch, 06. November 2019 11:03 von Leander Jedamus
# modifiziert Dienstag, 05. November 2019 20:21 von Leander Jedamus

TMPDIR		    = /tmp
TMPFILE		    = $(TMPDIR)/Makefile.cc.tmp
TMPFILE2	    = $(TMPDIR)/Makefile.diff.tmp
TMPFILE3	    = $(TMPDIR)/Makefile.grep.tmp
TMPCC_VERSIONFILE   = $(TMPDIR)/Makefile.cc.version
CC_VERSIONFILE	    = .cc_version

ifeq ($(CC_VERSIONFILE),$(wildcard $(CC_VERSIONFILE)))
include $(CC_VERSIONFILE)
endif
ifeq ($(TMPCC_VERSIONFILE),$(wildcard $(TMPCC_VERSIONFILE)))
include $(TMPCC_VERSIONFILE)
endif
ifeq ($(machtype),MacOS)
PARAM1		    = $$2
PARAM2		    = $$4
else
PARAM1		    = $$1
PARAM2		    = $$3
endif

CLEAN		    = dummy

check_host:
		    cc -v 2> $(TMPFILE)
		    #grep " version" $(TMPFILE) | sed 's/.* \([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\) .*/TMPCC_VERSION=\1/g' > $(TMPCC_VERSIONFILE)
		    grep " version" $(TMPFILE) | awk -F' ' '{ print "TMPCC_VERSION=$(machtype)-" $(PARAM1) "-" $(PARAM2) }' > $(TMPCC_VERSIONFILE)
		    make check2
		    make all

check2:
ifneq ($(CC_VERSION),$(TMPCC_VERSION))
		    cat $(TMPCC_VERSIONFILE) | sed 's/TMP//' > $(CC_VERSIONFILE)
		    make clean
endif

clean:
		    $(RM) $(CLEAN)

all:
		    @echo "done"

# vim:ai sw=2

