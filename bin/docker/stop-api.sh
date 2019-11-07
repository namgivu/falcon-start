#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    # stop the container ie stop the api app
    cn='nn_falcon_start'; # cn aka CONTAINER_NAME
    docker stop $cn 1>/dev/null 2>&1
    docker rm   $cn 1>/dev/null 2>&1
cd - 1>/dev/null
