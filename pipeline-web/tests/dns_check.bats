#!/usr/bin/env bats

setup() {
  # Configuración opcional, por ejemplo, puedes definir el dominio y la IP
  DOMAIN="${DOMAIN:-pipeline.local}"
  CODIGO_IP="${CODIGO_IP:-127.0.0.1}"
  SCRIPT_PATH="/path/to/dns_check.sh"  # Ajusta la ruta al script real
}


@test "El script dns_check.sh se ejecuta correctamente" {
  run bash "$SCRIPT_PATH"
  [ "$status" -eq 0 ]
}


@test "Resolución del dominio con dig" {
  run dig +short "$DOMAIN"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$CODIGO_IP" ]]
}

@test "Resolución del dominio con getent" {
  run getent hosts "$DOMAIN"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$CODIGO_IP" ]]
}

@test "Comprobando resolución incorrecta" {
  run getent hosts "$DOMAIN"
  ip_resuelto=$(echo "$output" | awk '{print $1}')
  [ "$ip_resuelto" = "$CODIGO_IP" ] || [ "$status" -ne 0 ]
}

@test "Comprobando que el dominio resuelve a la IP correcta" {
  # Aquí asumimos que el script añade el dominio a /etc/hosts si no se resuelve
  # Asegúrate de que la IP de la máquina coincida con la variable $CODIGO_IP
  run bash "$SCRIPT_PATH"
  [ "$status" -eq 0 ]
  [[ "$output" =~ "$DOMAIN" ]]
}
