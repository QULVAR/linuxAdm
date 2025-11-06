#!/bin/bash

IFS=':' read -r -a dirs <<< "${PATH:-}"

seen=()

for dir in "${dirs[@]}"; do
    [[ -z "$dir" ]] && dir='.'

    skip=0
    for s in "${seen[@]}"; do
        if [[ "$s" == "$dir" ]]; then
            skip=1
            break
        fi
    done
    ((skip)) && continue

    seen+=("$dir")

    if [[ -d "$dir" ]]; then
        count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
    else
        count=0
    fi

    echo "$dir => $count"
done