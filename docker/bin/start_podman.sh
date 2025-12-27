#!/usr/bin/env bash
set -euo pipefail
DOCKER_DIR="$(cd "$(dirname "$0")/.." && pwd)"
podman build -t python-app "$DOCKER_DIR"
podman rm -f python-app-lab >/dev/null 2>&1 || true
podman run -d \
  -p 8052:8052 \
  --name python-app-lab \
  python-app