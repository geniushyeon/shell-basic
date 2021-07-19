#!/bin/bash

echo "This shell script name is $0"
echo "I can speak $1 and $2"
echo "This shell script parameters are $*"
echo "This shell script parameters are $@"
echo "This parameter count is $#"

for language in "$@"
do
  echo "I can speak $language"
done
