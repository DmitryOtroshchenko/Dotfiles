#!/usr/bin/env bash

git submodule update --init --recursive
./dotbot/bin/dotbot -d . -c ./dotbot.yaml
