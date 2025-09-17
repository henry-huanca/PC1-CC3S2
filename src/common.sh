#!/usr/bin/env bash
# Funciones comunes para el pipeline (Sprint 1)

msg() { echo -e "[INFO] $*"; }
err() { echo -e "[ERROR] $*" >&2; }

# Verifica que una variable esté definida
requerida() {
  local nombre="$1"
  if [ -z "${!nombre:-}" ]; then
    err "Variable requerida no definida: $nombre"
    return 1
  fi
}
