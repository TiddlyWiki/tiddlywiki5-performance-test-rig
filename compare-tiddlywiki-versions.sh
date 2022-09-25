#!/bin/bash

# Build and test two versions of TiddlyWiki

FIRST=$1 # Tag of first commit to compare eg v5.1.23
SECOND=$2 # Tag of second commit to use eg master
OUTPUT=$3 # Output folder

if [ -z "$FIRST" ]; then
	echo "Missing parameter: first tag to compare"
	exit 1
fi

if [ -z "$SECOND" ]; then
	echo "Missing parameter: second tag to compare"
	exit 1
fi

if [ -z "$OUTPUT" ]; then
	echo "Missing parameter: output directory"
	exit 1
fi

./build-tiddlywiki-at-version.sh ./wiki $FIRST $OUTPUT/$FIRST || exit 1

./build-tiddlywiki-at-version.sh ./wiki $SECOND $OUTPUT/$SECOND || exit 1

node ./index.js $OUTPUT/$FIRST/index.html || exit 1

node ./index.js $OUTPUT/$SECOND/index.html || exit 1
