#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"
requerida CONFIG_URL || exit 1

url="$CONFIG_URL"
mkdir -p out

# Cabeceras de respuesta (solo HTTPS)
curl -s -D- -o /dev/null "$url" | tee out/hsts-headers.txt

if grep -i '^strict-transport-security:' out/hsts-headers.txt >/dev/null; then
  echo "[INFO] HSTS presente" | tee -a out/hsts-headers.txt
else
  echo "[WARN] HSTS ausente" | tee -a out/hsts-headers.txt
  exit 1
fi
