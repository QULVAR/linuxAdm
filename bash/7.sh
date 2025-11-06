#!/bin/bash
set -euo pipefail

IFS=':' read -r -a paths <<< "${PATH:-}"

for dir in "${paths[@]}"; do
	[[ -z "$dir" ]] && dir='.'
	
	if [[ -d "$dir" ]]; then
		shopt -s nullglob
		files=( "$dir"/* )
		count=0
		for f in "${files[@]}"; do
			[[ -f "$f" ]] && ((count++))
		done
		echo "$dir: $count"
	else
		echo "$dir: not a directory" >&2
	fi
done

