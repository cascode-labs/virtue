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
	@echo "  'make auto-docs' will continuosly rebuild the docs"
	@echo "     as they are updated"
	@echo "  'make docs' will build the documentation once"
	@echo "Other tasks"
	@echo "  'make clean' will clean up the work area"
	@echo ""

SHELL = /bin/tcsh
.PHONY: help clean \
		build \
		install-dev  \
		docs docs-single \
		install-conda
.ONESHELL:

install-dev:
	mamba env create -f environment.yml
	conda activate ids-dev
	pip install --no-deps -e .

build:
	flit build

release:
	make clean
	make build
	anaconda upload -u cascode-labs virtuoso.yml \
	  --description 'A \
	  [Virtue environment](https://www.cascode-labs.org/virtue/) \
	  for automating IC design'

clean:
	rm -rf dist

docs:
	cd docs; ./autobuild.sh

docs-single:
	cd docs; make html

install-conda:
	wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh"
	exec Mambaforge-Linux-x86_64.sh
	conda install -n base mamba anaconda-client
