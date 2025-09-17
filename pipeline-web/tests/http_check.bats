#!/usr/bin/env bats

@test "HTTP check con TARGET válido" {
  run env PORT=8080 TARGETS="http://httpbin.org:80" bash src/http-check.sh
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Código correcto" ]]
}

@test "HTTP check con TARGET inválido" {
  run env TARGETS="http://noexiste.local:8080" bash src/http-check.sh
  [ "$status" -ne 0 ]
  [[ "$output" =~ "Fallo" || "$output" =~ "Could not resolve host" || "$output" =~ "Código incorrecto" ]]
}