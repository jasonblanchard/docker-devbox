#! /usr/bin/env bash

# TODO: move this script to init.d
# http://askubuntu.com/questions/83473/how-to-execute-script-on-shutdown

docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
