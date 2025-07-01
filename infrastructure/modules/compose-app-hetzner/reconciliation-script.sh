#!/bin/bash
set -e

# Prepare clone dir
REPO_DIR="/srv/gitops/repo"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[INFO] Initial clone of repo..."
    git clone --branch "${branch}" "${git_remote}" "$REPO_DIR"
else
    echo "[INFO] Updating existing repo..."
    git -C "$REPO_DIR" pull
fi

# Compare tracked file
REMOTE_FILE="$REPO_DIR/${compose_path}"

if ! diff -q "$REMOTE_FILE" "${compose_path}" >/dev/null; then
    echo "[INFO] Changes detected. Updating docker compose..."
    cp "$REMOTE_FILE" "${compose_path}"
    docker compose --file "${compose_path}" pull
    docker compose --file "${compose_path}" up --detach
else
    echo "[INFO] No changes detected."
fi
