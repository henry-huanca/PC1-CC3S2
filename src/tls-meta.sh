#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"
requerida CONFIG_URL || exit 1

THRESHOLD_DAYS="${THRESHOLD_DAYS:-7}"

host=$(echo "$CONFIG_URL" | sed 's~^https\?://~~; s~/.*~~')

mkdir -p out

# Metadatos del certificado (issuer, subject, fechas)
openssl s_client -servername "$host" -connect "$host:443" < /dev/null 2>/dev/null \
| openssl x509 -noout -issuer -subject -dates \
| tee out/tls-meta.txt

# Protocolo/cipher negociado (quick check)
printf "\n# NEGOCIACIÓN (protocolo/cipher)\n" | tee -a out/tls-meta.txt
openssl s_client -servername "$host" -connect "$host:443" < /dev/null 2>/dev/null \
| awk '/Protocol|Cipher/ && $2 ~/:/ {print $0}' | tee -a out/tls-meta.txt

# Días restantes del cert
notAfter=$(openssl s_client -servername "$host" -connect "$host:443" < /dev/null 2>/dev/null \
| openssl x509 -noout -enddate | cut -d= -f2)

expire_epoch=$(date -d "$notAfter" +%s)
now_epoch=$(date +%s)
days_left=$(( (expire_epoch - now_epoch) / 86400 ))

printf "\n# CERT_DAYS_LEFT=%s\n" "$days_left" | tee -a out/tls-meta.txt

if [ "$days_left" -lt "$THRESHOLD_DAYS" ]; then
  echo "[WARN] Certificado por vencer: $days_left días restantes (< $THRESHOLD_DAYS)" | tee -a out/tls-meta.txt
  exit 1
fi

echo "[INFO] Cert OK: $days_left días restantes" | tee -a out/tls-meta.txt
