#!/usr/bin/env bash

git submodule update --init
./dotbot/bin/dotbot -d . -c ./dotbot.yaml
