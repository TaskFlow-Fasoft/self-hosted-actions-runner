#!/usr/bin/env bash
set -e

# instala deps do .NET
sudo ./bin/installdependencies.sh

: "${GH_URL:?GH_URL é obrigatório}"
: "${RUNNER_TOKEN:?RUNNER_TOKEN é obrigatório}"

if [ ! -f .runner ]; then
  echo "Configurando runner ${RUNNER_NAME}"
  ./config.sh --unattended \
              --url    "${GH_URL}" \
              --token  "${RUNNER_TOKEN}" \
              --name   "${RUNNER_NAME}" \
              --labels "${RUNNER_LABELS}" \
              --work   _work
  touch .runner
fi

echo "Iniciando runner…"
exec ./run.sh