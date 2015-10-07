PANDOC=pandoc
PFLAGS=-N -s --toc

rules.pdf: rules/*.md
	$(PANDOC) $(sort $^) -f markdown -t latex -o $@ $(PFLAGS)

reformat: rules/*.md
	for f in $^; do pandoc -t markdown -f markdown --columns 75 $$f -o $$f; done

.PHONY: reformat