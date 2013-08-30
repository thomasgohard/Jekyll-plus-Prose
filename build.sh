#!/bin/bash

GH_ACCOUNT=thomasgohard
GH_REPOSITORY=Jekyll-plus-Prose
GH_REMOTE=live
GH_PAGESBRANCH=gh-pages

function error_exit
{
	echo -e "\e[01;31m$1\e[00m" 1>&2
	exit 1
}

if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then 
	git config --global user.email ${GH_EMAIL}

	git remote add $GH_REMOTE https://${GH_TOKEN}@github.com/$GH_ACCOUNT/$GH_REPOSITORY.git

	git checkout -B $GH_PAGESBRANCH
	
	echo "Push to gh-pages branch"
	git push -fq $GH_REMOTE $GH_PAGESBRANCH 2> /dev/null || error_exit "Unable to push to gh-pages."
fi
