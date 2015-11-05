PANDOC=pandoc
HIGHLIGHT_STYLE=tango
PFLAGS=-N -s --toc --highlight-style=$(HIGHLIGHT_STYLE)

rules.pdf: rules/*.md
	$(PANDOC) $(sort $^) -f markdown -t latex -o $@ $(PFLAGS)

html: index.html pandoc.css

index.html: rules/*.md
	$(PANDOC) $(sort $^) -f markdown -t html5 -o $@ $(PFLAGS) -c pandoc.css --mathjax

reformat: rules/*.md
	for f in $^; do pandoc -t markdown -f markdown --columns 75 $$f -o $$f; done

.PHONY: reformat