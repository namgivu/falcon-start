#!/bin/bash

docker run  --name nn_flaskstart2020  -d  -p 20730:5000 "namgivu/flask-start:2020"
#      .    container name                              image tag
    docker ps | grep -E "nn_flaskstart2020|20730|namgivu/flask-start:2020|IMAGE|NAMES|PORTS|" --color=always
    #                    c                 p     i                        header
