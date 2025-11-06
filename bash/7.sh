#!/bin/bash

IFS=':' read -r -a dirs <<< "${PATH:-}"

seen=()

for dir in "${dirs[@]}"; do
    [[ -z "$dir" ]] && dir='.'

    already=0
    for s in "${seen[@]}"; do
        if [[ "$s" == "$dir" ]]; then
            already=1
            break
        fi
    done
    ((already)) && continue

    seen+=("$dir")

    if [[ ! -d "$dir" ]]; then
        continue
    fi

    count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
    echo "$dir => $count"
done

exit 0