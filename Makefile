# Makefile for CV

include ../latex/makefile.defs

.PHONY: all
all: cv

.PHONY: cv
cv: PROJECT=cv
cv: cv_academic.tex education.tex setup.tex personal/information.tex academic/profile.tex
	$(LATEXMK) -pdf -quiet -pdflatex="$(PDFLATEX)" -use-make cv_academic.tex;

.PHONY: resume
resume: PROJECT = resume
resume: education.tex setup.tex personal/information.tex academic/profile.tex resume.tex
	$(LATEXMK) -pdf -quiet -pdflatex="$(PDFLATEX)" -use-make resume.tex;
