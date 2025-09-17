#!/usr/bin/env bats

setup() {
  export CONFIG_URL="https://github.com"
}

@test "HSTS presente en respuesta HTTPS" {
  make hsts
  run grep -i "^strict-transport-security:" out/hsts-headers.txt
  [ "$status" -eq 0 ]
}

@test "HTTP redirige a HTTPS" {
  make redirects
  run grep -i "^location: https://" out/redirects.txt
  [ "$status" -eq 0 ]
}
