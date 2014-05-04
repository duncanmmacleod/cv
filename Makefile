#!make -f
#
# Makefile for CV
# Copyright (C): Duncan Macleod (2014)
#

PROJECT=cv
.PHONY: all
all: clean clean-pdf cv.pdf
include latex.make

cv.pdf: cv_academic.tex education.tex setup.tex personal/information.tex academic/profile.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=cv cv_academic.tex;

.PHONY: resume
resume: resume.pdf
resume.pdf: clean education.tex setup.tex personal/information.tex academic/profile.tex resume.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=resume resume.tex;

.PHONY: references
references: references.pdf
references.pdf: setup.tex references.tex academic/references.tex
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=references references.tex;
 

clean: PROJECT = resume cv
clean-pdf: PROJECT = resume cv
