#!/bin/bash
set -euo pipefail

names=( $(compgen -v LC_) )

if [[ ${#names[@]} -le 1 ]]; then
	echo "OK"
	exit 0
fi

ref_value=${!names[0]}

for name in "${names[@]}"; do
	if [[ "${!name}" != "$ref_value" ]]; then
		echo "Error: LC_* variables have different values" >&2
		exit 1
	fi
done

echo "OK"

