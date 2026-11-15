#!/usr/bin/env bash
# Starts the Floci AWS emulator and the Floci UI. Safe to run again at any time.
set -euo pipefail

# Wait for the Docker daemon (docker-in-docker can take a moment to start)
for i in $(seq 1 60); do
  docker info >/dev/null 2>&1 && break
  echo "Waiting for Docker daemon... ($i)"
  sleep 2
done
if ! docker info >/dev/null 2>&1; then
  echo "ERROR: Docker daemon is not running. Rerun: bash .devcontainer/start-emulator.sh"
  exit 1
fi

if [ "$(docker ps -q -f name=^floci$)" ]; then
  echo "Floci is already running."
else
  # Remove a stopped container with the same name, if any
  docker rm -f floci >/dev/null 2>&1 || true
  echo "Starting Floci AWS emulator..."
  docker run -d --name floci -p 4566:4566 hectorvent/floci:latest
fi

if [ "$(docker ps -q -f name=^floci-ui$)" ]; then
  echo "Floci UI is already running."
else
  docker rm -f floci-ui >/dev/null 2>&1 || true
  echo "Starting Floci UI..."
  docker run -d --name floci-ui --network host \
    -e FLOCI_ENDPOINT=http://localhost:4566 \
    -e AWS_REGION="${AWS_REGION:-us-east-1}" \
    -e AWS_ACCESS_KEY_ID=test \
    -e AWS_SECRET_ACCESS_KEY=test \
    floci/floci-ui:latest
fi

# Wait until the emulator answers
for i in $(seq 1 30); do
  curl -s -o /dev/null http://localhost:4566 && break
  sleep 1
done

echo "Floci is ready at http://localhost:4566"
echo "Floci UI is ready at http://localhost:4500 (see the PORTS tab)"
