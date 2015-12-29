#! /bin/bash

if command_exists javac ; then
    alias javac='javac -J-Dfile.encoding=UTF-8'
    alias java='java -Dfile.encoding=UTF-8'
fi
