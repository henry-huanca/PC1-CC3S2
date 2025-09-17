#!/usr/bin/env bash
# Pipeline dummy Sprint 1
# Estilo estudiante: claro y sin floro corporativo :)

set -euo pipefail
trap 'echo "[INFO] Saliendo limpio";' EXIT

source "$(dirname "$0")/common.sh"

# Variables mínimas
requerida RELEASE || exit 1

# Variables opcionales
: "${PORT:=}"
: "${MESSAGE:=}"
: "${CONFIG_URL:=}"
: "${DNS_SERVER:=}"
: "${TARGETS:=}"

mkdir -p out

msg "Guardando variables de entorno en out/variables.txt"
{
  echo "RELEASE=${RELEASE}"
  echo "PORT=${PORT}"
  echo "MESSAGE=${MESSAGE}"
  echo "CONFIG_URL=${CONFIG_URL}"
  echo "DNS_SERVER=${DNS_SERVER}"
  echo "TARGETS=${TARGETS}"
  date +"fecha=%Y-%m-%d %H:%M:%S"
} > out/variables.txt

msg "Sprint 1 listo: estructura + Makefile + evidencia básica"
msg "Revisa out/variables.txt"
