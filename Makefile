FILES = \
	index.md

all: lua-psl.html lua-psl.pdf lua-psl.3

lua-psl.html: template.html site.css metadata.yaml $(FILES)
	pandoc -o $@ -t html5 -s --toc --template=template.html --section-divs --self-contained -c site.css metadata.yaml $(FILES)

lua-psl.pdf: metadata.yaml $(FILES)
	pandoc -o $@ -t latex -s --toc --toc-depth=2 -V documentclass=article -V classoption=oneside -V links-as-notes -V geometry=a4paper,includeheadfoot,margin=2.54cm metadata.yaml $(FILES)

lua-psl.3: metadata.yaml $(FILES)
	pandoc -o $@ -t man -s metadata.yaml $(FILES)

man: lua-psl.3
	man -l $^

clean:
	rm -f lua-psl.html lua-psl.pdf lua-psl.3

.PHONY: all man install clean
