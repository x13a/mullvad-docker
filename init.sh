#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="${ENV_FILE:-./mullvad.env}"

main() {
    chmod 600 $ENV_FILE
    source $ENV_FILE
    if [ -z "$MULLVAD_ACCOUNT" ] || [ -z "$MULLVAD_LOCATION" ]; then
        echo "empty account or location, exit" >&2
        exit 1
    fi
    docker compose up -d
    docker exec -it mullvad mullvad account login "$MULLVAD_ACCOUNT"
    docker exec -it mullvad mullvad lan set allow
    docker exec -it mullvad mullvad auto-connect set on
    docker exec -it mullvad mullvad lockdown-mode set on
    docker exec -it mullvad mullvad relay set location "$MULLVAD_LOCATION"
    docker exec -it mullvad mullvad connect
    echo "done"
}

main "$@"
