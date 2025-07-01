#!/bin/bash
set -e

REPO_DIR="/srv/gitops/repo"
COMPOSE_FILE="$REPO_DIR/${compose_path}"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[INFO] Initial clone of repo..."
    git clone --branch "${branch}" "${git_remote}" "$REPO_DIR"
else
    echo "[INFO] Updating existing repo..."
    git -C "$REPO_DIR" pull
fi

docker compose --file "$COMPOSE_FILE" pull
docker compose --file "$COMPOSE_FILE" up --detach
