#! /bin/bash

command_exists npm || return 0

export NODE_PATH=`npm root -g`
