#!/usr/bin/env bash

if [ x"$@" = x"quit" ]
then
    exit 0
fi
echo "reload"
echo "quit"
echo -en "aap\0icon\x1flutris_touhou-luna-nights\n"
