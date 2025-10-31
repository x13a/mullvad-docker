#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="./mullvad.env"

main() {
    chmod 600 $ENV_FILE
    source $ENV_FILE

    if [ -z "$MULLVAD_ACCOUNT" ]; then
        echo "empty account, exit"
        exit 1
    fi

    docker compose up -d
    docker exec -it mullvad mullvad account login "$MULLVAD_ACCOUNT"
    docker exec -it mullvad mullvad relay set tunnel-protocol wireguard
    docker exec -it mullvad mullvad tunnel set wireguard rotate-key
    docker exec -it mullvad mullvad lan set allow
    docker exec -it mullvad mullvad auto-connect set on
    docker exec -it mullvad mullvad lockdown-mode set on
    docker exec -it mullvad mullvad relay set location "$MULLVAD_LOCATION"
    docker exec -it mullvad mullvad connect
    echo "done"
}

main "$@"
