#!/usr/bin/env bash
set -euo pipefail

# dependencies
for dep in curl jq tar sha256sum; do
  command -v "$dep" >/dev/null 2>&1 || { echo "Missing: $dep" >&2; exit 1; }
done

# detect platform (arch-first keys in Zig index.json)
case "$(uname -m)" in
  x86_64|amd64) ARCH_KEY="x86_64" ;;
  aarch64|arm64) ARCH_KEY="aarch64" ;;
  *) echo "Unsupported arch: $(uname -m)" >&2; exit 1 ;;
esac

case "$(uname -s)" in
  Linux)  OS_KEY="linux"  ;;
  Darwin) OS_KEY="macos" ;;
  MINGW*|MSYS*|CYGWIN*) OS_KEY="windows" ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

PLATFORM="${ARCH_KEY}-${OS_KEY}"

# fetch Zig's official download index
JSON="$(curl -fsSL https://ziglang.org/download/index.json)"

# pick the latest stable semver key (exclude "master")
VER="$(echo "$JSON" \
  | jq -r 'keys - ["master"]
            | map(select(test("^[0-9]+\\.[0-9]+\\.[0-9]+$")))
            | sort_by(split(".")|map(tonumber)) | last')"

if [[ -z "$VER" || "$VER" == "null" ]]; then
  echo "Could not determine stable Zig version." >&2
  exit 1
fi

# artifact info
TARBALL_URL="$(echo "$JSON" | jq -r --arg v "$VER" --arg p "$PLATFORM" '.[$v][$p].tarball')"
SHASUM="$(echo "$JSON" | jq -r --arg v "$VER" --arg p "$PLATFORM" '.[$v][$p].shasum')"

if [[ -z "$TARBALL_URL" || "$TARBALL_URL" == "null" ]]; then
  echo "No tarball found for $PLATFORM in $VER" >&2
  exit 1
fi

echo "➡ Installing Zig $VER ($PLATFORM)"
echo "   $TARBALL_URL"

# download + verify + extract
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT
cd "$TMPDIR"

curl -fLO "$TARBALL_URL"
FILE="$(basename "$TARBALL_URL")"

if [[ -n "$SHASUM" && "$SHASUM" != "null" ]]; then
  echo "$SHASUM  $FILE" | sha256sum -c -
fi

tar -xf "$FILE"

# install into ~/.local/zig/<version>, update ~/.local/zig/current
INSTALL_ROOT="$HOME/.local/zig"
DEST="$INSTALL_ROOT/$VER"
mkdir -p "$INSTALL_ROOT"

EXTRACTED_DIR="$(find . -maxdepth 1 -type d -name "zig-*-$VER" | head -n1)"
mv "$EXTRACTED_DIR" "$DEST"

ln -sfn "$DEST" "$INSTALL_ROOT/current"

# ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

# symlink zig binary into ~/.local/bin
ln -sfn "$INSTALL_ROOT/current/zig" "$HOME/.local/bin/zig"

echo
echo "✅ Installed: $DEST"
echo "🔗 Symlink updated: $INSTALL_ROOT/current"
echo "🚀 Zig binary linked at: $HOME/.local/bin/zig"
echo
echo "Now you can run 'zig version' directly."

