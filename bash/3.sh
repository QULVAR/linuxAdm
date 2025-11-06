#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <file>..." >&2
	exit 1
fi

status=0

for file in "$@"; do
	if [[ ! -f "$file" ]]; then
		echo "Error: file '$file' does not exist" >&2
		status=1
		continue
	fi
	
	lines=$(wc -l < "$file")
	lines=$(echo "$lines" | tr -d ' ')
	
	echo "$file: $lines"
done

exit "$status"

