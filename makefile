all:

compareMOP.zip:
	zip compareMOP.zip gaussint.* bis.* compareMOP.pdf

.PHONY: clean

clean:
	@rm -f *.out *.aux *.log *.bbl *.blg *.nav *.snm *.toc *.vrb *.synctex.gz *.pyc *~

