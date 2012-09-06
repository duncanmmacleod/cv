SHELL=/bin/sh

PROJECT=cv
TARGET=$(PROJECT).pdf
DEFTEXFILES      = education.tex setup.tex
PERSONALTEXFILES = personal/information.tex
TEXFILES         = $(DEFTEXFILES) $(PERSONALTEXFILES)

ACADEMICTEXFILES= academic/profile.tex


PDFLATEX=pdflatex
PDFLATEXFLAGS=-jobname=$(PROJECT)

all: clean academic

.PHONY: academic

academic: $(TEXFILES) $(ACADEMICTEXFILES) cv_academic.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_academic &&\
	    $(PDFLATEX) $(PDFLATEXFLAGS) cv_academic;\

clean:
	base=$(PROJECT);\
	$(RM) $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.acn\
	      $$base.acr $$base.alg $$base.glo $$base.gls $$base.toc $$base.lof\
          $$base.out;\
