rules.pdf: rules/*.md
	pandoc $^ -f markdown -t latex -o $@ -N