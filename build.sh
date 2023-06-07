#!/bin/bash
VERSION=$(virtue --version)
DIST_PATH="dist/$VERSION"
echo "Building IDS-skill"
echo "  building version $VERSION"
rm -rf "$DIST_PATH"
mkdir -p "$DIST_PATH"

# Copy in SKILL Code
cp -rf virtue "$DIST_PATH/"
ln -s "virtue/virtue.cdsinit.ils" "$DIST_PATH/virtue.cdsinit.ils"
ln -s "virtue/virtue.cdsLibMgr.il" "$DIST_PATH/virtue.cdsLibMgr.il"

# Build Python package
flit build
mkdir "$DIST_PATH/pkgs"
mv "dist/virtue-skill-${VERSION:1}.tar.gz" "$DIST_PATH/pkgs/"
mv "dist/virtue_skill-${VERSION:1}-py3-none-any.whl" "$DIST_PATH/pkgs/"
# Build executable
#pyinstaller -F -n virtue virtue/cli.py
#mv dist/virtue "$DIST_PATH/"

echo "  build saved to $DIST_PATH"
echo "  build complete!"