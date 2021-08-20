PROGNAME 	= themer
REPONAME 	= linux-themer
BINDIR 		= $(DESTDIR)/usr/local/bin
LICENSEDIR 	= $(DESTDIR)/usr/local/$(REPONAME)
LICENSENAME = LICENSE
SCRIPTDIR 	= $(BINDIR)
SCRIPTNAME	= $(PROGNAME).sh

install:
	mkdir -p $(BINDIR)
	mkdir -p $(SCRIPTDIR)
	mkdir -p $(LICENSEDIR)
	chmod 755 $(SCRIPTNAME)
	chmod 644 $(LICENSENAME)
	cp $(SCRIPTNAME) $(SCRIPTDIR)/$(SCRIPTNAME)
	cp $(LICENSENAME) $(LICENSEDIR)/$(LICENSENAME)

uninstall:
	rm -r $(SCRIPTDIR)/$(SCRIPTNAME)
	rm -r $(LICENSEDIR)

.PHONY: install uninstall
