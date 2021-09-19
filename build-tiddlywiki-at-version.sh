#!/bin/bash

# Build the test wiki with a particular commit of TiddlyWiki

WIKI=$1 # Path to wiki to be built
TAG=$2 # Tag of commit to use eg v5.1.23, master
OUTPUT=$3 # Output folder

if [ -z "$WIKI" ]; then
	echo "Missing parameter: wiki path"
	exit 1
fi

if [ -z "$TAG" ]; then
	echo "Missing parameter: commit tag"
	exit 1
fi

if [ -z "$OUTPUT" ]; then
	echo "Missing parameter: output directory"
	exit 1
fi

pushd ../TiddlyWiki5 # <--- Change this to point to your clone of https://github.com/Jermolene/TiddlyWiki5
git checkout $TAG || exit 1
popd

tiddlywiki $WIKI --load ./payload --output $OUTPUT --build
