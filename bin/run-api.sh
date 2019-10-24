#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    PORT=6000; pipenv run  gunicorn  src.app:api                    -b "0.0.0.0:$PORT"  --reload
                                     #path to falcon api instance   #bind to address    #auto reload api if code changed
cd --
