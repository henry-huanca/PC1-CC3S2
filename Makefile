# Makefile simple estilo estudiante (comentarios en español)
# Contrato: tools, build, test, run, pack, clean, help

SHELL := /bin/bash

# Variables esperadas por entorno (12-Factor): no las fijamos aquí
# Ejemplo de uso temporal:
#   PORT=8080 MESSAGE="Hola" RELEASE=v0.1 make run
# Requeridas mínimas para build/pack/run: RELEASE
RELEASE ?=

TOOLS := bash curl dig ss nc awk sed grep tee find

.PHONY: tools build test run pack clean help

help:
	@echo "Uso:"
	@echo "  make tools   - Verifica utilidades requeridas"
	@echo "  make build   - Prepara artefactos en out/"
	@echo "  make test    - Ejecuta pruebas Bats si están instaladas"
	@echo "  make run     - Ejecuta el pipeline dummy (Sprint 1)"
	@echo "  make pack    - Empaqueta en dist/ usando RELEASE"
	@echo "  make clean   - Limpia out/ y dist/"

tools:
	@missing=0; \
	for t in $(TOOLS); do \
	  if ! command -v $$t >/dev/null 2>&1; then \
	    echo "Falta herramienta: $$t"; missing=1; \
	  fi; \
	done; \
	if ! command -v bats >/dev/null 2>&1; then \
	  echo "Aviso: bats no encontrado (necesario para 'make test')."; \
	fi; \
	if [ $$missing -ne 0 ]; then \
	  echo "Instala las herramientas faltantes y vuelve a correr 'make tools'."; \
	  exit 1; \
	fi; \
	echo "OK: herramientas básicas presentes."

build:
	@test -n "$(RELEASE)" || (echo "ERROR: define RELEASE. Ej: RELEASE=v0.1 make build"; exit 1)
	@mkdir -p out dist
	@echo "$(RELEASE)" > out/release.txt
	@echo "Build listo en out/"

test:
	@if command -v bats >/dev/null 2>&1; then \
	  bats tests; \
	else \
	  echo "bats no está instalado. Instálalo para correr tests (Sprint 1 pide al menos 1)."; \
	  exit 1; \
	fi

run:
	@test -n "$(RELEASE)" || (echo "ERROR: define RELEASE. Ej: RELEASE=v0.1 make run"; exit 1)
	@bash src/pipeline.sh

pack:
	@test -n "$(RELEASE)" || (echo "ERROR: define RELEASE. Ej: RELEASE=v0.1 make pack"; exit 1)
	@mkdir -p dist
	@tar -czf dist/pipeline-$(RELEASE).tar.gz \
		Makefile src tests docs systemd .gitignore out
	@echo "Paquete: dist/pipeline-$(RELEASE).tar.gz"

clean:
	@rm -rf out/* dist/* 2>/dev/null || true
	@echo "Limpieza completa."
