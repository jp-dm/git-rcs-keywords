#!/bin/bash
# $Header$
# @author Kimmo R. M. Hovi
# Script to install the filters in a public place if run as root, and take them into use

if [ $EUID = 0 ]; then
    if [ ! -d /usr/local/share/git_filters ]; then
	mkdir -p /usr/local/share/git_filters && \
	    chmod 0755 /usr/local/share/git_filters && \
	    cp .git_filters/rcs-keywords.smudge /usr/local/share/git_filters && \
	    cp .git_filters/rcs-keywords.clean /usr/local/share/git_filters && \
	    chmod 0755 /usr/local/share/git_filters/rcs-keywords.{clean,smudge} && \
	    echo "Filters installed in /usr/local/share/git_filters"
    fi
fi

if [ ! -r /usr/local/share/git_filters/rcs-keywords.clean ]; then
    if [ $EUID = 0 ]; then
	echo "Oops, something went terribly wrong in installing the filters"
    else
	echo "Oops, filters not installed in global directory. Please run as root to install"
    fi
fi

git config --global filter.rcs-keywords.clean \
    "/usr/local/share/git_filters/rcs-keywords.clean" && \
echo "Filters configured. Note that you still need to
enable keyword filtering in your project. Please see
README for more information."
