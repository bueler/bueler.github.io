all: popdip.pdf

popdip.pdf: popdip.aux
	pdflatex popdip

popdip.aux: popdip.tex popdip.bib
	pdflatex popdip
	bibtex popdip
	pdflatex popdip

.PHONY: clean

clean:
	@rm -f *.out *.aux *.log *.bbl *.blg *.nav *.snm *.toc *.vrb *.synctex.gz *.pyc *~

