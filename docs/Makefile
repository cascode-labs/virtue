# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help clean Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	cp -rf ../virtue ./source/_static/src
	cp -f  ../LICENSE ./source/_static/LICENSE
	cp -rf ../conda-recipe ./source/_static/conda-recipe
	cp -rf ../tests  ./source/_static/tests
	cp -rf ../virtuoso.yml  ./source/_static/virtuoso.yml
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	rm -rf ./source/_static/src
	rm -f ./source/_static/LICENSE
	rm -rf ./source/_static/conda-recipe
	rm -rf ./source/_static/tests
	rm -rf ./source/_static/virtuoso.yml
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
