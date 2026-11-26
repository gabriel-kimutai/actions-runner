#!/usr/bin/env bash
set -euo pipefail

cd /home/runner/actions-runner

if [ ! -f .runner ]; then
  : "${RUNNER_URL:?set RUNNER_URL in .env}"
  : "${RUNNER_TOKEN:?set RUNNER_TOKEN in .env (the --token value from GitHub, valid for one hour)}"
  ./config.sh --unattended --replace \
    --url "$RUNNER_URL" \
    --token "$RUNNER_TOKEN" \
    --name "${RUNNER_NAME:-$(hostname)}" \
    --labels "${RUNNER_LABELS:-}" \
    --work _work
fi

unset RUNNER_TOKEN
exec ./run.sh
