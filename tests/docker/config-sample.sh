#!/bin/bash

 DB_PORT=7777
API_PORT=8888

 DB_CONTAINER=`docker ps | grep $DB_PORT  | rev | cut -d' ' -f1 | rev`  # get container name from DB_PORT
API_CONTAINER=`docker ps | grep $API_PORT | rev | cut -d' ' -f1 | rev`  # get container name from API_PORT

#region config db
    docstring='
    We will query via this command
    $PSQL $DB_CONNECTION/$DB_NAME
    '

    DB_CONNECTION="postgresql://postgres:@:5432"  # without DB_NAME please
          DB_NAME='nn_falcon_start'
             PSQL="docker exec $DB_CONTAINER psql"
#endregion
