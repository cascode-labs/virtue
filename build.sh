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
mv "dist/virtue-skill-${VERSION:1}.tar.gz" "$DIST_PATH/"

# Build executable
#pyInstaller

echo "  build saved to $DIST_PATH"
echo "  build complete!"