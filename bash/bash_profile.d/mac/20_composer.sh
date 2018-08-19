#! /bin/bash

command_exists composer || return 0

# PATH=$PATH:$(composer config -g home)/$(composer config -g bin-dir)
