#!/usr/bin/bash -e
git_main_branch() {
  local ref
  for ref in main trunk mainline default stable master; do
    if git show-ref -q --verify "refs/heads/$ref"; then
      echo "$ref"
      return
    fi
  done
  echo master
}
main=$(git_main_branch)
branch=$(git rev-parse --abbrev-ref HEAD)
git checkout "$main"
if git remote get-url upstream >/dev/null 2>&1; then
  git fetch upstream
  git merge --ff-only "upstream/$main"
else
  git pull
fi
git checkout "$branch"
git merge "$main"
