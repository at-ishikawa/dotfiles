#! /bin/bash

command_exists gcloud || return 0

source <(kubectl completion bash)
