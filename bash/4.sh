#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <planet>" >&2
	exit 1
fi

name=$(echo "$1" | tr '[:upper:]' '[:lower:]')

case "$name" in
	mercury|меркурий)
		echo 0 ;;
	venus|венера)
		echo 0 ;;
	earth|земля)
		echo 1 ;;
	mars|марс)
		echo 2 ;;
	jupiter|юпитер)
		echo 79 ;;
	saturn|сатурн)
		echo 83 ;;
	uranus|уран)
		echo 27 ;;
	neptune|нептун)
		echo 14 ;;
	*)
		echo "No such planet: $1" >&2
		exit 1 ;;
esac

