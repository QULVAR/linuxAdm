#!/bin/bash
set -euo pipefail

output="logs.log"
: > "$output"

shopt -s nullglob

for f in /var/log/*.log; do
	[[ -f "$f" ]] || continue
	last_line=$(tail -n 1 "$f" 2>/dev/null || true)
	echo "$f: $last_line" >> "$output"
done