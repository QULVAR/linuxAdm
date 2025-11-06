#!/bin/bash
set -euo pipefail

if [[ "${FOO:-}" = "5" && "${BAR:-}" = "1" ]]; then
	echo "Execution is forbidden when FOO=5 and BAR=1" >&2
	exit 1
fi

shopt -s nullglob

initial_files=( * )

while true; do
	sleep 1
	current_files=( * )
	
	for f in "${current_files[@]}"; do
		[[ -f "$f" ]] || continue
		
		found=0
		for old in "${initial_files[@]}"; do
			if [[ "$f" == "$old" ]]; then
				found=1
				break
			fi
		done
		
		if [[ $found -eq 0 ]]; then
			echo "New file appeared: $f"
			exit 0
		fi
	done
done

