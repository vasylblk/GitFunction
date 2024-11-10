AUTOMAKE_OPTIONS = foreign

bin_PROGRAMS = func
func_SOURCES = main.cpp func.cpp func.h
pkginckude_HEADERS = func.h
dist_man_MANS = func.1

SUBDIRS = tests

CTRLF_DIR=$(CURDIR)/deb/DEBIAN
CTRLF_NAME=$(CTRLF_DIR)/control

.PHONY:deb debug
deb:
    make DESTDIR=$(CURDIR)/deb install
    
debug:
    $(info $(foreach v,$(.VARIABLES), $(v)=$($(v))))
    
deb:
    mkdir -p $(CTRLF_DIR)
    echo Package: $(PACKAGE) > $(CTRLF_NAME)
    echo Version: $(VERSION) >>$(CTRLF_NAME)
    echo Architecture:all >> $(CTRLF_NAME)
    echo Maintainer: $(PACKAGE_BUGREPORT) >> $(CTRLF_NAME)
    echo -n "Description: " >> $(CTRLF_NAME)
    echo "Advanced management package for math function" >> $(CTRLF_NAME)
    make DESTDIR=$(CURDIR)/deb install
    
    uninstall-hook:
        rm -rf $(datarootdir)/$(PACKAGE)/data
        rm -rf $(datarootdir)/$(PACKAGE)
