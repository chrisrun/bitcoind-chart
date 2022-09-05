#!/bin/bash

set -e

# Add rpc credentials if non empty.
if [ -n "${RPCUSER}" ]; then
   PARAMS="$PARAMS --rpcuser=${RPCUSER}"
fi
if [ -n "${RPCPASSWORD}" ]; then
   PARAMS="$PARAMS --rpcpassword=${RPCPASSWORD}"
fi
if [ -n "${DATADIR}" ]; then
   PARAMS="$PARAMS --datadir=${DATADIR}"
fi
if [ -n "${CONF}" ]; then
   PARAMS="$PARAMS --conf=${CONF}"
fi

# Add user parameters to command.
PARAMS="$PARAMS $@"

# Start bitcoin node.
exec bitcoind $PARAMS
