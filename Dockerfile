FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl jq build-essential git sudo docker.io vim ca-certificates unzip libaio1 gcc && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/runner && \
    usermod -aG docker runner

ARG RUNNER_VERSION=2.323.0
ARG RUNNER_ARCH=x64
ARG RUNNER_SHA256=e8e24a3477da17040b4d6fa6d34c6ecb9a2879e800aa532518ec21e49e21d7b4

RUN mkdir actions-runner && cd actions-runner && \
    curl -o actions-runner-linux-x64-2.324.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.324.0/actions-runner-linux-x64-2.324.0.tar.gz && \
    echo "e8e24a3477da17040b4d6fa6d34c6ecb9a2879e800aa532518ec21e49e21d7b4  actions-runner-linux-x64-2.324.0.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-x64-2.324.0.tar.gz

ENV GH_URL="https://github.com/TaskFlow-Fasoft" \
    RUNNER_TOKEN="AV77POPVY5UHJFMVHWQTZ43IFUIYU" \
    RUNNER_NAME="self-hosted-runner" \
    RUNNER_LABELS="self-hosted-runner" \
    RUNNER_ALLOW_RUNASROOT="1"

COPY entrypoint.sh /entrypoint.sh
COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /entrypoint.sh /usr/local/bin/run.sh

USER runner
WORKDIR /actions-runner

ENTRYPOINT ["/entrypoint.sh"]