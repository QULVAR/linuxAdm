#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <directory>" >&2
	exit 1
fi

dir=$1

if [[ ! -d "$dir" ]]; then
	echo "Error: directory '$dir' does not exist" >&2
	exit 1
fi

shopt -s nullglob dotglob

for sub in "$dir"/*/; do
	name=${sub%/}
	name=${name##*/}
	
	entries=( "$sub"* )
	count=${#entries[@]}
	
	echo "$count" > "$name"
done

