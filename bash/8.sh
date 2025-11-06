#!/bin/bash

names=()

while IFS='=' read -r name value; do
    case "$name" in
        LC_*) names+=("$name") ;;
    esac
done < <(env)

if (( ${#names[@]} <= 1 )); then
    exit 0
fi

first_value="${!names[0]}"

for name in "${names[@]}"; do
    if [[ "${!name}" != "$first_value" ]]; then
        exit 1
    fi
done

exit 0