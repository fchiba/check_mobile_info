#!/bin/bash

SCRIPT_DIR=`pwd`
CACHE_DIR=$HOME/check_cache
mkdir -p $CACHE_DIR 
cd $CACHE_DIR

for url in `cat $SCRIPT_DIR/urls.txt`; do
	#echo $url
	filename=`md5 -qs $url`
	#echo $filename
	wget -q -O $filename.new $url
	ret=$?
	if [ $ret != 0 ]; then
		echo "Error has occured while retrieving $url. code = $ret"
		continue
	fi
	if [ -e $filename ] ; then
		diff -u $filename $filename.new
	else
		diff -u /dev/null $filename.new
	fi
	mv $filename.new $filename
done
