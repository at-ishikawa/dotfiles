#! /bin/bash

command_exists kubectl || return 0

source <(kubectl completion bash)
