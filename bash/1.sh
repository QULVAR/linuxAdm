#!/bin/bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 <output_file> <seconds>" >&2
	exit 1
fi

outfile=$1
seconds=$2

if ! [[ "$seconds" =~ ^[0-9]+$ ]]; then
	echo "Error: <seconds> must be a non-negative integer" >&2
	exit 1
fi

: > "$outfile"

for (( i=0; i<seconds; i++ )); do
	ts=$(date "+%d.%m.%y %H:%M")
	load=$(</proc/loadavg)
	echo "$ts = $load" >> "$outfile"
	sleep 1
done

