#!/usr/bin/env bats

setup() {
  export CONFIG_URL="https://github.com"
}

@test "tls-meta genera metadatos y días de vigencia > 0" {
  make meta
  [ -f out/tls-meta.txt ]
  run grep -E "^notAfter=|# CERT_DAYS_LEFT=" out/tls-meta.txt
  [ "$status" -eq 0 ]
}
