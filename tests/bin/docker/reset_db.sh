#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/../../.." ;          a=$(cd "$a" && pwd) ; APP_HOME="$a"

source "$SCRIPT_HOME/config.sh"
if [[ -z $DB_CONTAINER ]];  then echo "DB_CONTAINER is required"; exit; fi
if [[ -z $DB_CONNECTION ]]; then echo "DB_CONNECTION is required"; exit; fi
if [[ -z $DB_NAME ]];       then echo "DB_NAME is required"; exit; fi
if [[ -z $PSQL ]];          then echo "PSQL is required"; exit; fi


c_postgres=$DB_CONTAINER  # :c_postgres aka container for postgres db
    c_path='/falcon_start/tests/bin/docker'  # c_path aka folder path on container :c_postgres
echo; echo "Copy seed_db.sql to $c_postgres:$c_path..."
    docker exec $c_postgres bash -c "mkdir -p $c_path"
    docker cp "$APP_HOME/bin/db/seed_db.sql" "$c_postgres:$c_path"


echo; echo "Reset database..."
    # close all current connection
    $PSQL "$DB_CONNECTION" -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME';" 1>/dev/null;

    # drop then create db
    $PSQL "$DB_CONNECTION" -c "DROP DATABASE if exists $DB_NAME;"
    $PSQL "$DB_CONNECTION" -c "CREATE DATABASE $DB_NAME;"

    # create table & rows
    $PSQL "$DB_CONNECTION/$DB_NAME" -f "$c_path/seed_db.sql"
