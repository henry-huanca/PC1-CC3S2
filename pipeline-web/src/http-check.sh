#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Fallo en la línea $LINENO"; exit 1' ERR

PORT="${PORT:-8080}"
TARGETS="${TARGETS:-http://127.0.0.1:$PORT}"
CODIGO_DE_ESTADO_ESPERADO="${CODIGO_DE_ESTADO_ESPERADO:-200}"

log() { echo "[INFO] $*"; }

http_checks() {
  log "Verificando disponibilidad de curl..."
  command -v curl >/dev/null 2>&1 || { echo "[ERROR] Falta curl"; exit 1; }

  log "Ejecutando GET verbose: curl -v $TARGETS"
  curl -v "$TARGETS" || true
  echo

  log "Verificando código de estado y mostrando cuerpo"
  if ! codigo_de_estado="$(curl -s -o /dev/null -w "%{http_code}" "$TARGETS")"; then
    echo "Fallo: no se pudo contactar el destino"
    exit 1
  fi

  rc=0
  if [ "$codigo_de_estado" = "$CODIGO_DE_ESTADO_ESPERADO" ]; then
    echo "Código correcto: $codigo_de_estado"
  else
    echo "Código incorrecto (esperado $CODIGO_DE_ESTADO_ESPERADO, recibido $codigo_de_estado)"
    rc=1
  fi

  log "Mostrando cuerpo de la respuesta"
  curl -s "$TARGETS" || true
  echo
  log "Mostrando cabeceras"
  curl -sI "$TARGETS" || true
  echo
  log "HTTP checks completados"

  exit "$rc"
}

http_checks