#!/bin/zsh

mkdocs build -d ../tabletop-facilitator
git add ../
git commit -m '$1'
git push
