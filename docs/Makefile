.PHONY: all deps deps-debian

all: deps hestiapi-one.pdf

hestiapi-one.pdf: *.tex
	# Have to compile it twice to generate/obtain forward references
	# Why can't pdflatex sort this out?  Dunno.  It's silly.
	pdflatex hestiapi-one.tex
	pdflatex hestiapi-one.tex

deps: deps-debian

deps-debian:
	sudo apt install -y texlive

