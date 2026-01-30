#!/bin/zsh

mkdocs build -d ../tabletop
git add ../
git commit -m '$1'
git push
