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
references.pdf: setup.tex references.tex header.tex academic/references.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=references references.tex;

.PHONY: publications
publications: publications.pdf
publications.pdf: setup.tex publications.tex publications/publications-cv.tex publications/setup-cv.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=publications publications.tex;

publications/publications-%.tex publications/setup-%.tex: publications/%.ini publications/*.bib publications/write-publications.py
	python publications/write-publications.py --output-dir publications/ $< --file-tag $*

clean: PROJECT = resume cv references publications
clean-pdf: PROJECT = resume cv references publications
clean-publications: PROJECT = resume cv references publications
clean-publications:
	$(RM) publications/publications.tex
	$(RM) publications/setup.tex
