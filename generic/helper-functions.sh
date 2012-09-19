#!/usr/bin/env bash

############################


function url_verify(){
if [ $? -ne 0 ]
  then 
	echo "Not there; retrieve latest $1 version"
	exit 1;
  else 
	echo "OK"
fi
}
