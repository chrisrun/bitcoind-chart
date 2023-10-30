#!/usr/bin/env bash

set -e
# For debugging:
# set -x

# Versions available (per https://bitcoincore.org/bin) are:
#
# (there are earlier versions available, but the binary URLs don't conform to the
# same pattern.)
#

VERSIONS=(
0.13.0
0.13.1
0.13.2
0.14.3
0.15.2
0.16.3
0.17.0
0.17.0.1
0.17.1
0.17.2
0.18.0
0.18.1
0.19.0.1
0.19.1
0.20.0
0.20.1
0.20.2
0.21.0
0.21.1
0.21.2
22.0
23.0
23.1
24.0
24.0.1
25.0
25.1
)

err() {
  >&2 echo "$@"
}

if [ ! -f /etc/debian_version ] && [ ! -f /etc/lsb_release ]; then
  err "This script is intended for use on Debian-based systems."
  exit 1
fi

VERSION="$1"
INSTALL_PREFIX="${2:-/}"

URL_BASE="https://bitcoincore.org/bin/bitcoin-core-${VERSION}"
FILENAME="bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz"

if [ -z "${VERSION}" ]; then
  err "Usage: get-bitcoin.sh <version> [<install-prefix>]"
  err
  err "Available versions are:"

  for v in "${VERSIONS[@]}"; do
    err "  ${v}"
  done

  err
  exit 1
fi

set -x

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

# Verify signing key fingerprints here:
#
#   https://github.com/bitcoin/bitcoin/tree/master/contrib/builder-keys

curl -O "${URL_BASE}/SHA256SUMS.asc"
curl -O "${URL_BASE}/${FILENAME}"

# In version 22.0, release signing changed from a single key signing in 
# SHA256SUMS.asc to multiple keys signing SHA256SUMS. 
#
# See here for more information: https://github.com/bitcoin/bitcoin/pull/23020

tar -xzvf "${FILENAME}"
DIR=$(find . -name 'bitcoin-*' -type d | head -n 1)
ls -lah ${DIR}
rm "${DIR}"/bin/bitcoin-qt
cp -r "${DIR}"/* "${INSTALL_PREFIX}"

echo
echo "Bitcoin installed:"
echo
"${INSTALL_PREFIX}/bin/bitcoind" --version || true