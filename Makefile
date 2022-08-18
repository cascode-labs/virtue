help:
	@echo ""
	@echo "Build a Virtue package or install Virtue for development"
	@echo ""
	@echo "Build Packages"
	@echo "  'make build' will build both a wheel and sdist"
	@echo "  'make build-wheel' will build just a wheel"
	@echo "  'make build-sdist' will build just a sdist"
	@echo "  'make upload-virtuoso-env' will upload the virtuoso environment"
	@echo "    definition file to our anaconda cloud"
	@echo "Install"
	@echo "  'make install-conda-dev' will install a conda development environment"
	@echo "Build documentation"
	@echo "  'make auto-build-docs' will continuosly rebuild the docs"
	@echo "     as they are updated"
	@echo "  'make build-docs' will build the documentation once"
	@echo "Other tasks"
	@echo "  'make clean' will clean up the work area"
	@echo ""

.PHONY: help build build-wheel build-sdist \
		install-conda-dev auto-build-docs build-docs clean \
		copy-data build-all build-docs-only auto-build-docs-only \
		install-conda-dev-only install-pip-dev build-wheel-only build-sdist-only

build: copy-data build-all

install-conda-dev: copy-data install-conda-dev-only install-pip-dev

build-docs: copy-data build-docs-only

auto-build-docs: copy-data auto-build-docs-only

build-wheel: copy-data build-wheel-only

build-sdist: copy-data build-sdist-only

upload-virtuoso-env:
	anaconda upload -u cascode-labs virtuoso.yml \
	  --description 'A \
	  [Virtue environment](https://www.cascode-labs.org/virtue/) \
	  for automating IC design'

clean:
	rm -rf dist

copy-data:
	cp -rf pyproject.toml virtue/pyproject.toml

build-all:
	flit build

build-docs-only:
	cd docs; make html

auto-build-docs-only:
	cd docs;exec autobuild.sh

install-conda-dev-only:
	conda env create -f environment.yml

install-pip-dev:
	pip install --no-deps -e .

build-wheel-only:
	flit build --format wheel

build-sdist-only:
	flit build --format wheel
