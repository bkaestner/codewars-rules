rules.pdf: rules/*.md
	pandoc $^ -f markdown -t latex -o $@ -N -s

reformat: rules/*.md
	for f in $^; do pandoc -t markdown -f markdown --columns 75 $$f -o $$f; done

.PHONY: reformat