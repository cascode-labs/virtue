help:
	@echo ""
	@echo "Build a Virtue package or install Virtue for development"
	@echo "  'make build' will build both a wheel and sdist"
	@echo "  'make install-conda-dev' will install a conda development environment"
	@echo "  'make clean' will clean up the work area"
	@echo "   ---"
	@echo "  'make build-wheel' will build just a wheel"
	@echo "  'make build-sdist' will build just a sdist"
	@echo ""

.PHONY: help Makefile build install-dev clean

build: copy-data build-all

install-conda-dev: copy-data install-conda-dev-only install-pip-dev

build-wheel: copy-data build-wheel-only

build-sdist: copy-data build-sdist-only

copy-data:
	cp -rf pyproject.toml virtue/pyproject.toml

build-all:
	flit build

install-conda-dev-only:
	conda env create -f environment.yml

install-pip-dev:
	pip install --no-deps -e .

build-wheel-only:
	flit build --format wheel

build-sdist-only:
	flit build --format wheel

clean:
	rm -rf dist
