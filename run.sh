#!/usr/bin/env bash
set -e

docker run -d \
    --name "${RUNNER_NAME}" \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e RUNNER_NAME="${RUNNER_NAME}" \
    "${RUNNER_NAME}"