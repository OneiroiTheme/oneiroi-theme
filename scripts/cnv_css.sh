#!/bin/sh

if [ -n "$1" ]; then
  content="$1"
elif [ ! -t 0 ]; then
  content=$(cat)
else
  script=$(basename $0)
  echo "Error: '$script' No input provided. Use a parameter or pipe input." >&2
  exit 1
fi

echo "$content" | grep -oP '([a-zA-Z-][a-zA-Z0-9_-]*)\s*:\s*[^;]+' | sed -E 's/\s*:\s*/=/'
