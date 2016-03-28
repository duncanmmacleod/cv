#!make -f
#
# Makefile for CV
# Copyright (C): Duncan Macleod (2014)
#

PROJECT=cv
.PHONY: all
all: clean clean-publications clean-pdf cv.pdf
include latex.make

cv.pdf: cv_academic.tex education.tex setup.tex academic/profile.tex publications/publications-cv.tex publications/setup-cv.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=cv cv_academic.tex;

.PHONY: resume
resume: resume.pdf
resume.pdf: resume.tex education.tex setup.tex academic/profile.tex publications/publications-resume.tex publications/setup-resume.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=resume resume.tex;

.PHONY: references
references: references.pdf
references.pdf: setup.tex references.tex academic/references.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=references references.tex;


publications/publications-%.tex publications/setup-%.tex: publications/%.ini publications/*.bib
	python write_publications.py --output-dir publications/ $< --file-tag $*

clean: PROJECT = resume cv
clean-pdf: PROJECT = resume cv
clean-publications: PROJECT = resume cv
clean-publications:
	$(RM) publications/publications.tex
	$(RM) publications/setup.tex
