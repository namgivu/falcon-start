#!/bin/bash

API_PORT=8888

#region config db
    docstring='
        We will query via this command
        $PSQL $DB_CONNECTION/$DB_NAME
    '
    DB_CONTAINER='nn_falcon_start_postgres'

    DB_CONNECTION="postgresql://postgres:@:5432"  # without DB_NAME please
          DB_NAME='nn_falcon_start'

             PSQL="docker exec $DB_CONTAINER psql"
#endregion
