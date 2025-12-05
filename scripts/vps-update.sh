#!/bin/bash

# ==================================================================================
# OKICRAFT VPS Auto-Updater Script
# ==================================================================================
# This script checks for the latest release on GitHub, downloads it, and updates
# the Minecraft server files running in a Docker container.
#
# REQUIREMENTS:
# - curl, jq, unzip
# - Docker
#
# SETUP:
# 1. Edit the CONFIGURATION section below.
# 2. Make executable: chmod +x vps-update.sh
# 3. Run manually or add to crontab (e.g., hourly: 0 * * * * /path/to/vps-update.sh)
# ==================================================================================

# --- CONFIGURATION ---
GITHUB_REPO="okisooo/OKICRAFT"
DOCKER_CONTAINER_NAME="mc-server"       # Name of your docker container
SERVER_ROOT="/opt/minecraft/data"       # Path to the volume/folder mounted to /data
BACKUP_DIR="/opt/minecraft/backups"     # Where to store backups before updating
CURRENT_VERSION_FILE="version.txt"      # File to store current installed version

# --- LOGIC ---

# 1. Get latest release info from GitHub
echo "Checking for updates..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest")
TAG_NAME=$(echo "$LATEST_RELEASE" | jq -r .tag_name)
ASSET_URL=$(echo "$LATEST_RELEASE" | jq -r '.assets[] | select(.name | endswith(".zip")) | .browser_download_url')

if [ "$TAG_NAME" == "null" ] || [ -z "$TAG_NAME" ]; then
    echo "Error: Could not fetch latest release."
    exit 1
fi

# 2. Check if already installed
INSTALLED_VERSION=""
if [ -f "$SERVER_ROOT/$CURRENT_VERSION_FILE" ]; then
    INSTALLED_VERSION=$(cat "$SERVER_ROOT/$CURRENT_VERSION_FILE")
fi

if [ "$INSTALLED_VERSION" == "$TAG_NAME" ]; then
    echo "Server is already up to date ($TAG_NAME)."
    exit 0
fi

echo "New version found: $TAG_NAME (Current: $INSTALLED_VERSION)"

# 3. Prepare for update
echo "Downloading update..."
mkdir -p /tmp/okicraft_update
cd /tmp/okicraft_update
curl -L -o server-pack.zip "$ASSET_URL"

echo "Unzipping..."
unzip -q server-pack.zip
# Find the inner folder name (e.g., OKICRAFT-Server-1.0.0)
INNER_FOLDER=$(ls -d */ | head -n 1)

# 4. Stop Server
echo "Stopping Docker container..."
docker stop "$DOCKER_CONTAINER_NAME"

# 5. Backup
echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
# Backup world and config
tar -czf "$BACKUP_DIR/backup_${TIMESTAMP}_${INSTALLED_VERSION}.tar.gz" -C "$SERVER_ROOT" world config

# 6. Apply Updates
echo "Applying updates..."

# Remove old mods, config, libraries, scripts to ensure no conflicts
rm -rf "$SERVER_ROOT/mods"
rm -rf "$SERVER_ROOT/config"
rm -rf "$SERVER_ROOT/defaultconfigs"
rm -rf "$SERVER_ROOT/libraries"
rm -f "$SERVER_ROOT/start.sh"
rm -f "$SERVER_ROOT/start.bat"

# Copy new files
# We use cp -rT to copy contents of the inner folder to SERVER_ROOT
cp -rT "$INNER_FOLDER" "$SERVER_ROOT"

# Restore permissions if needed
chmod +x "$SERVER_ROOT/start.sh"

# Update version file
echo "$TAG_NAME" > "$SERVER_ROOT/$CURRENT_VERSION_FILE"

# 7. Start Server
echo "Starting Docker container..."
docker start "$DOCKER_CONTAINER_NAME"

echo "Update to $TAG_NAME complete!"

# Cleanup
cd ~
rm -rf /tmp/okicraft_update
