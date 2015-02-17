# vi: syntax=make
#
# Latex makefile definitions
# Copyright (C): Duncan Macleod (2014)
#

ifeq ($(QUIET), no)
	V = 1
else
ifeq ($(V), 1)
	QUIET = yes
endif
endif

# define commands
BIBTEX := $(shell which bibtex)
ifeq ($(BIBTEX),)
    $(error bibtex not found)
endif
PDFLATEX := $(shell which pdflatex)
ifeq ($(PDFLATEX),)
    $(error pdflatex not found)
endif
MAKEGLOSSARIES := $(shell which makeglossaries)
ifeq ($(MAKEGLOSSARIES),)
    $(error makeglossaries not found)
endif
LATEXMK := $(shell which latexmk)
ifeq ($(LATEXMK),)
    $(error latexmk not found)
endif

# set flags
LATEXMKFLAGS = -pdf -pdflatex=$(PDFLATEX) -use-make -halt-on-error

ifeq ($(V), 0)
	BIBTEXFLAGS += -terse
	LATEXMKFLAGS += -quiet
	MAKEGLOSSARIESFLAGS += -q
endif

ifeq ($(FORCE), 1)
	LATEXMKFLAGS += -f
endif

# latex PDF compile
%.pdf:
	$(LATEXMK) $(LATEXMKFLAGS) $<;

# latex AUX compile
%.aux: %.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) $*;

# bibtex compile
%.bbl: %.aux
	$(BIBTEX) $(BIBTEX) $*;

# makeglossaries
%.gls: %.aux
	$(MAKEGLOSSARIES) $(MAKEGLOSSARIESFLAGS) $*;

.PHONY: latex-clean
latex-clean:
	$(LATEXMK) -c -quiet;


.PHONY: clean
clean: latex-clean
	for target in $(PROJECT); do \
	    $(RM) $$target.log $$target.aux $$target.end $$target.bbl \
	          $$target.blg $$target.acn $$target.acr $$target.alg \
	          $$target.glo $$target.gls $$target.toc $$target.lof \
              $$target.out $$target.run.xml $$target-blx.bib \
	          $$target.ist $$target.sbl $$target.lot $$target.sym \
	          $$target.slg $$target.glg $$target.fdb_latexmk \
	          $$target.fls; \
	done;

.PHONY: clean-pdf
clean-pdf:
	for target in $(PROJECT); do \
	    $(RM) $$target.pdf; \
	done;
