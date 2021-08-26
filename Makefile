PROGNAME 	= themer
REPONAME 	= linux-themer
BINDIR 		= $(DESTDIR)/usr/local/bin
LICENSEDIR 	= $(DESTDIR)/usr/local/$(PROGNAME)
LICENSENAME = LICENSE
SCRIPTDIR 	= $(BINDIR)
SCRIPTNAME	= $(PROGNAME).sh
SRCDIR 		= src

install:
	@mkdir -p $(BINDIR)
	@mkdir -p $(SCRIPTDIR)
	@mkdir -p $(LICENSEDIR)
	@chmod 755 $(SRCDIR)/$(SCRIPTNAME)
	@chmod 644 $(SRCDIR)/$(LICENSENAME)
	cp $(SRCDIR)/$(SCRIPTNAME) $(SCRIPTDIR)/$(SCRIPTNAME)
	cp $(SRCDIR)/$(LICENSENAME) $(LICENSEDIR)/$(LICENSENAME)

uninstall:
	rm -r $(SCRIPTDIR)/$(SCRIPTNAME)
	rm -r $(LICENSEDIR)

.PHONY: install uninstall
