#!/usr/bin/bash -e
branch=$(git status|head -1|cut -f3 -d\ )
git checkout main
git pull
git checkout "$branch"
git merge main
