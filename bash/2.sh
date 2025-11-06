#!/bin/bash

if [[ $# -ne 1 ]]; then
    exit 1
fi

path="$1"

if [[ ! -d "$path" ]]; then
    exit 1
fi

shopt -s nullglob

for subdir in "$path"/*/; do

    [[ -d "$subdir" ]] || continue

    name="${subdir%/}"
    name="${name##*/}"

    count=$(find "$subdir" -mindepth 1 -maxdepth 1 2>/dev/null | wc -l)

    echo "$count" > "$name"
done

exit 0