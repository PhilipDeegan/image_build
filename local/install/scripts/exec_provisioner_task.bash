#!/usr/bin/env -S pkgx +jetporch.com +taskfile.dev bash

set -x

function pp {
    local -r message="${1}"

    printf '\e[104m[ %s ] %s\e[0m\n' \
           "$( date '+%Y/%m/%d-%H:%M:%S' )" \
           "${message}"
}

function main {
    local -r INVENTORY="${PWD}/provisioner/inventory.pkgx"
    local -r PLAYBOOKS="${PWD}/provisioner/playbooks"
    local -r ROLES="${PWD}/provisioner/roles"

    #cd "${PROVISIONER_REPO_PATH}"

    if [ "X${PKR_VAR_CONSTRUCTOR_EXEC_PROVISIONER_TASK_INSTALL}" == "Xtrue" ]; then
        ssh-keygen -f "${HOME}/.ssh/known_hosts" -R "${REMOTE_FQDN}"
        task install
             
    else
        pp 'Set the environment variable PKR_VAR_CONSTRUCTOR_EXEC_PROVISIONER_TASK_INSTALL to true to execute the provisioner install task'
    fi
    #
    # cleanup cloud-init
    #
    #cd "${CONSTRUCTOR_REPO_PATH}"
    task post-install
}

main