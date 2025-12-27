#!/usr/bin/env bash
set -euo pipefail
DOCKER_DIR="$(cd "$(dirname "$0")/.." && pwd)"
docker build -t python-app "$DOCKER_DIR"
docker rm -f python-app >/dev/null 2>&1 || true
docker run -d \
  -p 8052:8052 \
  --name python-app \
  python-app