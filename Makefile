NOM=$(shell basename `pwd`)

_always:
	mkdir -p compilation/
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex
	cp compilation/$(NOM).pdf $(NOM).pdf &
	gnome-open $(NOM).pdf

biblio: $(NOM).aux
	mkdir compilation/ &
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; bibtex $(NOM).aux; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex
	cp compilation/$(NOM).pdf $(NOM).pdf &
	gnome-open $(NOM).pdf &

$(NOM).aux:
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex

clean:
	cd compilation; rm -f *
	rm -r *~
	cd styles; rm -r *~
	rm *.pdf

push:
	make clean &
	git add .
	git commit
	git push GITHUB

pull:
	git pull

upload:
	mkdir compilation/ &
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex
	cp compilation/$(NOM).pdf $(NOM).pdf &
	scp $(NOM).pdf bagnol@iml.univ-mrs.fr:~/HTML/notes/.
	firefox http://iml.univ-mrs.fr/~bagnol/notes/$(NOM).pdf
