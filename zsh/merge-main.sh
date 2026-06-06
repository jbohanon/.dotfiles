#!/usr/bin/bash -e
branch=$(git status|head -1|cut -f3 -d\ )
git checkout $(git_main_branch)
git pull
git checkout "$branch"
git merge $(git_main_branch)
