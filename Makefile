SHELL=/bin/sh

PROJECT=cv
TARGET=$(PROJECT).pdf
DEFTEXFILES      = education.tex setup.tex
PERSONALTEXFILES = personal/information.tex
TEXFILES         = $(DEFTEXFILES) $(PERSONALTEXFILES)

ACADEMICTEXFILES = academic/profile.tex
PUBLICTEXFILES = public/profile.tex

PDFLATEX=pdflatex
PDFLATEXFLAGS=-jobname=$(PROJECT)

all: clean academic

.PHONY: academic public

academic: $(TEXFILES) $(ACADEMICTEXFILES) cv_academic.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_academic &&\
	    $(PDFLATEX) $(PDFLATEXFLAGS) cv_academic;\

public: $(TEXFILES) $(PUBLICTEXFILES) cv_public.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_public &&\
	    $(PDFLATEX) $(PDFLATEXFLAGS) cv_public;\

clean:
	base=$(PROJECT);\
	$(RM) $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.acn\
	      $$base.acr $$base.alg $$base.glo $$base.gls $$base.toc $$base.lof\
          $$base.out;\
