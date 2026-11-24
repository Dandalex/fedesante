#!/usr/bin/env bash
# Installe Tectonic (version épinglée, identique à .github/workflows/build.yml).
# Exécuté automatiquement à la création du codespace (postCreateCommand).
# DEST permet de choisir le dossier d'installation (défaut : /usr/local/bin).
set -euo pipefail

VERSION="0.16.9"
DEST="${DEST:-/usr/local/bin}"
URL="https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%40${VERSION}/tectonic-${VERSION}-x86_64-unknown-linux-musl.tar.gz"

if command -v tectonic >/dev/null 2>&1 && tectonic --version | grep -q "${VERSION}"; then
  echo "Tectonic ${VERSION} est déjà installé."
  exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
curl -fsSL "$URL" | tar -xz -C "$tmp"

if [ -w "$DEST" ]; then
  install -m 0755 "$tmp/tectonic" "$DEST/tectonic"
else
  sudo install -m 0755 "$tmp/tectonic" "$DEST/tectonic"
fi

"$DEST/tectonic" --version
echo "Tectonic installé dans $DEST. Ouvrir rapport/main.tex et enregistrer pour compiler."
