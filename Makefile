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
	mkdir -p compilation/
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; bibtex $(NOM).aux; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex
	cp compilation/$(NOM).pdf $(NOM).pdf &
	xdg-open $(NOM).pdf &

$(NOM).aux:
	mkdir -p compilation/
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex

clean:
	cd compilation; rm -f *
	rm -rf *~
	cd styles; rm -rf *~
	rm -f *.pdf

push:
	make clean
	git add .
	git commit -m "no comment"
	git push git@github.com:mbagnol/unif-nets.git

pull:
	git pull git@github.com:mbagnol/unif-nets.git

upload:
	mkdir -p compilation/
	cp -f images/* compilation/ &
	cp -f styles/* compilation/ &
	cp -f *.tex *.cls *.bib *.sty compilation/ &
	cd compilation; pdflatex -jobname $(NOM) -halt-on-error MAIN.tex
	cp compilation/$(NOM).pdf $(NOM).pdf &
	scp $(NOM).pdf bagnol@iml.univ-mrs.fr:~/HTML/drafts/.
	firefox http://iml.univ-mrs.fr/~bagnol/drafts/$(NOM).pdf
