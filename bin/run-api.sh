#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

if [[ ! -f "$APP_HOME/.env" ]]; then echo "File not found .env at $APP_HOME"; exit; fi
source "$APP_HOME/.env"

cd "$APP_HOME"
    echo "Running API at port=$API_PORT..."
    pipenv run  gunicorn  src.app:api                    -b "0.0.0.0:$API_PORT"  --reload
                          #path to falcon api instance   #bind to address       #auto reload api if code changed
cd - 1>/dev/null

#TODO make this script printing log to file - extra params for :gunicorn as below
# --timeout 666    --capture-output      --error-logfile=logfile   --access-logfile=logfile  --log-level=debug                        --threads=2                             --worker-connections=2
# #worker timeout  #save output to file  #where to save error log  #where to save access log #TODO remove this and setting from .env  # num of threads for handling requests  # num of simultaneous clients
