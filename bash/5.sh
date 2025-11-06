#!/bin/bash

: > logs.log

for f in /var/log/*.log; do
    if [[ -r "$f" ]]; then
        last_line=$(tail -n 1 "$f" 2>/dev/null || true)
        echo "$last_line" >> logs.log
    fi
done