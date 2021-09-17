#!/bin/bash

# Build the test wiki with a particular commit of TiddlyWiki

TAG=$1 # Tag of commit to use eg v5.1.23, master
OUTPUT=$2 # Output folder

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

tiddlywiki wiki --output $OUTPUT --build
