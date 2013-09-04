---
title: Enabling Jekyll+Prose on a GitHub repository
language: en
layout: default
editable: true
published: true
---

# Enabling Jekyll+Prose on a GitHub repository

This document describes the steps required to enable Jekyll+Prose on a GitHub repository.

The commands included for some of the steps are for Linux (Ubuntu). If you are using Windows or Mac OS X, the commands may differ.

## Assumptions

* The GitHub repository already exists.
* The GitHub repository is already cloned locally.
* Variables are identified using the following format: `[~variable name~]`.

## Setting up your local environment

* Install Ruby (Command: `sudo apt-get install ruby1.9.3`).
* Install the GitHub Jekyll environment (Command: `sudo gem install github-pages`).
* Install Travis (Command: `sudo gem install travis`).
* If you need to convert existing documents to Markdown, install pandoc (Command: `sudo apt-get install pandoc`).

## Setting up Travis to automatically update the gh-pages branch

* Copy the files `.travis.yml`, `build.sh` and `Gemfile` included in this repository to the the root folder of your GitHub repository's local copy.
* If the branch from which you build your gh-pages branch is any branch other than `master`, replace `master` with the name of your branch in the `branches` section of `.travis.yml`.
* In `build.sh`, replace `[~GitHub user name~]` with your GitHub user name and `[~GitHub repository name~]` with the name of the repository for which you want to enable Jekyll+Prose.
* Make `build.sh` executable (Command: `chmod +x build.sh`).
* On GitHub, go to Account Settings -> Applications.
* In the Personal Access Tokens section of the page, click on 'Create new token'.
* Give the new token a description (e.g., `travis-push-[~name of the repository~]`) and click 'Create token'.
* Copy the token (**Warning:** If you do not copy the token now, you will not be able to view it again later. You will have to destroy the token and create a new one.).
* From the root folder of your GitHub repository's local copy, encrypt the token and the email address you use for GitHub to protect them (Command: `travis encrypt "GH_TOKEN=[~token you copied in the previous step~] GH_EMAIL=[~email you use for GitHub~]" --add env.global`).
* Add the Travis build status indicator to the `README.md` file of your GitHub repository as described in [The Travis documentation](http://about.travis-ci.org/docs/user/status-images/#Adding-Status-Images-to-README-Files).
* Sign-in to Travis at [travis-ci.org](http://travis-ci.org/).
* Click on your avatar/username at the top of the screen to go to your Profile page.
* In the Respositories tab, click on the Sync now button, then find the repository for which you want to enable Travis and turn Travis on.

## Setting up Jekyll+Prose

* From the root directory of your GitHub repository's local copy, create a blank Jekyll site (Command: `jekyll new --force --blank .`).
* Copy the file `_config.yml` included in this repository to the the root folder of your GitHub repository's local copy.
* If the branch from which you build your gh-pages branch is any branch other than `master`, replace `master` with the name of your branch in the value of the `prose_branch` section of `_config.yml`.
* In `_config.yml`, replace `[~GitHub user name~]` with your GitHub user name and `[~GitHub repository name~]` with the name of the repository for which you want to enable Jekyll+Prose.
* Create one or more layout templates in the `_layout` folder.
* Create an include for the Prose edit link in the `_includes` folder (see the file `prose-edit-link.html` included in this repository for an example).
* Add the line `editable: true` to the front matter of any document for which you want to enable Prose editing; add the line `editable: false` to the front matter of any document for which you want to disable Prose editing.
* Add a link to the file `CORS_check.js` included in this repository at the end of the `<body>` of each of your layout templates to enable the fallback to the GitHub Web interface for browsers that do not support CORS, which is required by Prose.

## Converting Web pages to Markdown

* Convert the Web page to Markdown (Command: `pandoc -f html -t
markdown -o [~Filename for the converted document~].md [~URL of the
Web page you want to convert~]`).
* Add `published: true` and `layout: [~Layout you want to use~]`
to the front matter of the converted document.
* In the converted document, remove all parts of the Web page that
are part of the layout.
* Test building the converted document (Command: `jekyll build`).
* If the build returns any errors, correct them and re-run the
build until there are no errors.
* Serve the built converted document (Command: `jekyll serve --watch`).
* Review the converted document in a Web browser (URL:
`localhost:4000/[~Path to the converted document~]`).