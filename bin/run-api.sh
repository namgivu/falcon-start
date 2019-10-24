#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    PORT=6000; pipenv run  gunicorn  src.app:api                    -b "0.0.0.0:$PORT"  --reload
                                     #path to falcon api instance   #bind to address    #auto reload api if code changed
cd --

#TODO make this script printing log to file - extra params for :gunicorn as below
# --timeout 666    --capture-output      --error-logfile=logfile   --access-logfile=logfile  --log-level=debug                        --threads=2                             --worker-connections=2
# #worker timeout  #save output to file  #where to save error log  #where to save access log #TODO remove this and setting from .env  # num of threads for handling requests  # num of simultaneous clients
