#!/bin/sh

if [ ! -t 0 ]; then
  content=$(cat)
  key="$1"
elif [ -n "$1" ]; then
  content="$1"
  key="$2"
else
  script=$(basename $0)
  echo "Error: '$script' No input provided. Use a parameter or pipe input." >&2
  exit 1
fi

echo "$content" | awk -F'=' -v key="$key" '$1 == key {print $2}'
