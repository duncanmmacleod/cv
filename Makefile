SHELL=/bin/sh

PROJECT=cv
RESUME=resume
TARGET=$(PROJECT).pdf
DEFTEXFILES      = education.tex setup.tex
PERSONALTEXFILES = personal/information.tex
TEXFILES         = $(DEFTEXFILES) $(PERSONALTEXFILES)

ACADEMICTEXFILES = academic/profile.tex
PUBLICTEXFILES = public/profile.tex

BIBTEX=bibtex
PDFLATEX=pdflatex
PDFLATEXFLAGS=-jobname=$(PROJECT)

all: clean academic

.PHONY: academic public resume

academic: $(TEXFILES) $(ACADEMICTEXFILES) cv_academic.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_academic &&\
	$(BIBTEX) $(PROJECT) &&\
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_academic &&\
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_academic;\

resume: $(TEXFILES) $(ACADEMICTEXFILES) $(RESUME).tex
	$(PDFLATEX) $(RESUME) &&\
	$(BIBTEX) $(RESUME) &&\
	$(PDFLATEX) $(RESUME) &&\
	$(PDFLATEX) $(RESUME);\

public: $(TEXFILES) $(PUBLICTEXFILES) cv_public.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) cv_public &&\
	    $(PDFLATEX) $(PDFLATEXFLAGS) cv_public;\

clean:
	base=$(PROJECT);\
	$(RM) $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.acn\
	      $$base.acr $$base.alg $$base.glo $$base.gls $$base.toc $$base.lof\
          $$base.out $$base.run.xml $$base-blx.bib;\
    base=$(RESUME);\
	$(RM) $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.acn\
	      $$base.acr $$base.alg $$base.glo $$base.gls $$base.toc $$base.lof\
          $$base.out $$base.run.xml $$base-blx.bib;\
