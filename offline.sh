#!/bin/bash

set -e

regex='^http://([^/]*)'

while read line
do
    path="$(echo "$line" | sed 's/^http:\/\//resources\//')" || exit 1
    [ -f "$path" ] && continue || :
    dpath="$(dirname "$path")"
    mkdir -p "$dpath"
    curl -L "$line" -o "$path"
done < "${1:-/dev/stdin}"
