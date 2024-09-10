#!/bin/bash

# Build a circuit from a Circom file.
# Requires 1 argument: path to Circom file.
# Outputs compiled files to 'target' directory.

set -euo pipefail

# Check that 1 argument was provided to shell script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_circom_file>"
    exit 1
fi

CIRCOM_FILE=$1
WORKING_DIR=$(dirname "$CIRCOM_FILE")
TARGET_DIR=$WORKING_DIR/target
LIB_DIR=$WORKING_DIR/node_modules

if [ -f "$(dirname "$CIRCOM_FILE")/package.json" ]; then
    echo "package.json found, running npm install..."
    # --prefix will set the directory where npm will run
    npm install --prefix "$(dirname "$CIRCOM_FILE")"
fi

echo "Building $CIRCOM_FILE circuit..."
# Create any necessary parent directories
mkdir -p "$TARGET_DIR"
circom "$CIRCOM_FILE" -l "$LIB_DIR" --r1cs --wasm --output "$TARGET_DIR"
