#!/bin/bash

url=$1

# make sure we have a valid git url. only works with http/s
regex='^https?://[^/]+/[^/]+/[^/]+(\.git)?$'

if [[ ! $"url" =~ $regex ]]; then
    echo "echo \"$url does not match regex\""
    exit 1
fi

# turn our url into a repo path
repo="${url#"http://"}"
repo="${repo#"https://"}"
repo="${repo%".git"}"

# get the location where we will clone this repo
repodir="$HOME/src/${repo}"

# get th directory we will need to be in to call the git clone
dir="${repodir%/*}"

# check for existence of git command
if [[ -z $(which git) ]]; then
    echo "echo 'git executable not found'"
    exit 1
fi

mkdir -p "$dir"
pushd $dir > /dev/null

# perform the git clone and check output
output="$(git clone $url)"
if [[ $? > 0 ]]; then
    popd > /dev/null
    (rmdir $repodir && rmdir $dir) || true
    echo "echo 'git clone operation failed'"
    exit 1
fi

# return our pushd command to the calling shell
echo "pushd ${repodir}"
