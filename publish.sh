#!/bin/bash
set -x
rev=$(git rev-parse --short HEAD)
branch=$(git rev-parse --abbrev-ref HEAD)

echo Previous branch was $branch

# If we cannot checkout master, stop immediately
git checkout master || exit 1

# Delete a previous gh-pages branch, if it exists
git branch -D gh-pages

# Checkout gh-pages as orphaned branch
git checkout --orphan gh-pages || exit 1

# Ignore all already added files, but stop if we would forget
# changes.
git rm --cached \* || exit 1

# Create the page
make html

# Add and commit the page
git add *.html *.css
git commit -m "Publish GitHub pages, based on $rev"

# Publish GH pages
git push origin gh-pages -f

echo Use 'git checkout $branch -f' to change back to the previous branch.