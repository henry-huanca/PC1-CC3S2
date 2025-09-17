#!/usr/bin/env bats

# Este test valida que el target `make tls` genere las evidencias esperadas
@test "tls-check genera evidencias HTTP y HTTPS" {
  # Ejecutamos el target tls con una URL real
  CONFIG_URL=https://github.com make tls

  # Archivos esperados
  [ -f out/tls-http.txt ]
  [ -f out/tls-https.txt ]

  # Chequeo básico de contenido: HTTP debe mencionar 301 o 308 (redirección)
  run grep -E "HTTP/1\.1 (301|308)" out/tls-http.txt
  [ "$status" -eq 0 ]

  # Chequeo básico de contenido: HTTPS debe mencionar 'TLS' en el handshake
  run grep -E "TLSv1\." out/tls-https.txt
  [ "$status" -eq 0 ]
}
