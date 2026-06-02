#!/bin/bash

# Default values
INPUT_FILE=""
OUTPUT_FILE="$PWD/massdns.txt"

usage() {
    echo "Usage: $(basename "$0") -L <subdomain_file>"
    exit 1
}

# Parse arguments
while getopts "L:" opt; do
    case $opt in
        L)
            INPUT_FILE="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

# Validate input
if [ -z "$INPUT_FILE" ]; then
    echo "[!] No input file specified"
    usage
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "[!] File not found: $INPUT_FILE"
    exit 1
fi

echo "[*] Input file: $INPUT_FILE"
echo "[*] Output file: $OUTPUT_FILE"

# Run MassDNS
cat "$INPUT_FILE" | /home/kali/recon/massdns/bin/massdns \
-r "/home/kali/recon/massdns/lists/resolvers.txt" \
-t A \
-o S \
-w "$OUTPUT_FILE"

echo "[+] Finished"
echo "[+] Results saved to:"
echo "    $OUTPUT_FILE"
