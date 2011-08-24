SHELL=/bin/sh

PROJECT=cv
TEXFILES=cv.tex
BIBTEXFILES=../references/references.bib
PUBLISHFILES=
EXTRA_DIST=

TEXFLAGS=-interaction=batchmode
LATEX=latex $(TEXFLAGS)
DVIPS=dvips
DVIPDF=dvipdf
PDFLATEX=pdflatex
BIBTEX=bibtex
MAKEGLOSSARY=makeglossaries
TAR=tar
DISTFILES= cv.tex *png *eps Makefile

all: clean pdf

pdf: $(TEXFILES) $(BIBTEXFILES)
	for file in $(TEXFILES) ; do \
	  base=`basename $$file .tex`; \
          $(PDFLATEX)     $$base && \
	  $(PDFLATEX)     $$base ;  \
	done

clean:
	for file in $(TEXFILES) ; do \
	  base=`basename $$file .tex` ; \
          rm -f $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.acn $$base.acr $$base.alg $$base.glo $$base.gls $$base.toc $$base.lof; \
	done
