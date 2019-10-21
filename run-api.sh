#!/usr/bin/env bash
PORT=6000; pipenv run  gunicorn  src.app:api                    -b "0.0.0.0:$PORT"  --reload
                                 #path to falcon api instance   #bind to address    #auto reload api if code changed
