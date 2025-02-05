#!/bin/bash

if [ ! -t 0 ]; then
  template=$(cat)
  view="$1"
  pattern=$2
elif [ -n "$1" ] && [ -n "$2" ]; then
  template="$1"
  view="$2"
  pattern=$3
else
  echo "Error: '$script' Expecting two inputs (pipe+arg1,or arg1+arg2)" >&2
  exit 1
fi

pattern=${pattern:-"s/{{\${key}}}/\${value}/g"}

while IFS='=' read -r key value; do
  if [[ $key =~ ^\s*\[ ]] || [[ -z $key ]]; then
    continue
  fi
  # key=$(echo "$key" | xargs)
  # value=$(echo "$value" | xargs)
  seds+="$(echo "$pattern" | sed "s/\${key}/${key}/;s/\${value}/${value}/");"
done <<<"$view"
echo "$template" | sed "$seds"
