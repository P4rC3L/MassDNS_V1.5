#!/bin/bash

set -e
# ================= CONFIG =================
INSTALL_DIR="/home/kali/recon"          # <-- Make the required change here
REPO_NAME="massdns"
REPO_URL="https://github.com/blechschmidt/massdns.git"

SCRIPT_NAME="massdns.sh"

# Replace with your raw script URL later
SCRIPT_URL="https://github.com/P4rC3L/MassDNS_V1.5/massdns.sh"

INSTALL_BIN="/usr/bin"

# ==========================================

echo "[*] Starting MassDNS installation..."

# -------------------------
# Root check
# -------------------------

if [ "$EUID" -ne 0 ]; then
    echo "[!] Run with sudo:"
    echo "sudo $0"
    exit 1
fi

# -------------------------
# Package checker
# -------------------------

check_package() {

    PACKAGE="$1"

    if ! dpkg -s "$PACKAGE" >/dev/null 2>&1; then
        echo "[*] Installing: $PACKAGE"
        apt update
        apt install -y "$PACKAGE"
    else
        echo "[+] Found: $PACKAGE"
    fi
}

check_package git
check_package gcc
check_package make
check_package curl

# -------------------------
# Create install dir
# -------------------------

mkdir -p "$INSTALL_DIR"

cd "$INSTALL_DIR"

# -------------------------
# Clone or update repo
# -------------------------

if [ -d "$REPO_NAME" ]; then
    echo "[*] Repo exists, updating"
    cd "$REPO_NAME"
    git pull
else
    echo "[*] Cloning MassDNS"
    git clone "$REPO_URL"
    cd "$REPO_NAME"
fi

# -------------------------
# Build if needed
# -------------------------

if [ ! -f "./bin/massdns" ]; then
    echo "[*] Building MassDNS"
    make
else
    echo "[+] MassDNS already compiled"
fi

# -------------------------
# Download wrapper script
# -------------------------

cd "$INSTALL_DIR"

if [ ! -f "$SCRIPT_NAME" ]; then
    echo "[*] Downloading wrapper script"
    curl -L \
    -o "$SCRIPT_NAME" \
    "$SCRIPT_URL"
else
    echo "[+] Wrapper already exists"
fi

# -------------------------
# Permissions
# -------------------------

chmod +x "$SCRIPT_NAME"
cp "$SCRIPT_NAME" "$INSTALL_BIN"

# -------------------------
# Verify install
# -------------------------

if command -v "$SCRIPT_NAME" >/dev/null 2>&1; then
    echo
    echo "[+] Installation complete"
    echo
    echo "[+] Wrapper available globally:"
    echo "    $SCRIPT_NAME"
    echo
    echo "[+] MassDNS path:"
    echo "    $INSTALL_DIR/$REPO_NAME"
    echo
else
    echo "[!] Installation failed"
fi
