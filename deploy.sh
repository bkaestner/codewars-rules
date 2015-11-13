#!/bin/bash
set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)
git add index.html pandoc.css
git commit -m "rebuild pages at ${rev}"
git push -f origin HEAD:gh-pages