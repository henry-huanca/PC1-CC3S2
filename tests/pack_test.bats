#!/usr/bin/env bats

@test "Empaquetado y checksum OK" {
  RELEASE="v0.3" make pack
  [ -f dist/pipeline-v0.3.tar.gz ]
  [ -f dist/SHA256SUMS ]
  run grep "pipeline-v0.3.tar.gz" dist/SHA256SUMS
  [ "$status" -eq 0 ]
}
