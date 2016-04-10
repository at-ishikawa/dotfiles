#! /bin/bash

command_exists docker-machine || return 0
[ "$DOCKER_MACHINE_NAMES" = "" ] && return 0

function run_docker_machines() {
    DOCKER_MACHINE_NAMES=$@

    running_machines=$(docker-machine ls --filter state=Running --format {{.Name}})

    for docker_machine_name in ${DOCKER_MACHINE_NAMES[@]}
    do
        machine_running=false
        for running_machine in ${running_machines[@]}
        do
            if [ "$running_machine" = "$docker_machine_name" ]; then
                machine_running=true
                break
            fi
        done

        if $machine_running; then
            eval $(docker-machine env $docker_machine_name)
        else
            docker-machine start $docker_machine_name >/dev/null && echo <<EOF &
Started Docker Host $docker_machine_name.
Run eval $(docker-machine env $docker_machine_name) to configure environment variables.
EOF
        fi
    done
}

run_docker_machines ${DOCKER_MACHINE_NAMES[@]}
