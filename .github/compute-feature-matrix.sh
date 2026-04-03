#!/usr/bin/env bash
# Usage: compute-feature-matrix.sh <event_name> <changed_cargo-lambda> <changed_lambroll> <changed_ngrok>
# Outputs a JSON array of feature names to GITHUB_OUTPUT (or stdout when GITHUB_OUTPUT is unset).
set -euo pipefail

event_name="${1:-}"
shift

all_features=("cargo-lambda" "lambroll" "ngrok")
declare -A changed=(
  ["cargo-lambda"]="${1:-false}"
  ["lambroll"]="${2:-false}"
  ["ngrok"]="${3:-false}"
)

features=()
for feature in "${all_features[@]}"; do
  if [ "$event_name" = "workflow_dispatch" ] || [ "${changed[$feature]}" = "true" ]; then
    features+=("$feature")
  fi
done

if [ ${#features[@]} -eq 0 ]; then
  json="[]"
else
  json=$(printf '%s\n' "${features[@]}" | jq -R . | jq -sc .)
fi

echo "features=$json" | tee -a "${GITHUB_OUTPUT:-/dev/stdout}"
