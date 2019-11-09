#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/../.." ;             a=$(cd "$a" && pwd) ; APP_HOME="$a"

#TODO forced this script running in a container name :nn_falcon_start_postgres

if [[ ! -f "$APP_HOME/.env" ]]; then echo "File not found .env at $APP_HOME"; exit; fi
source "$APP_HOME/.env"

conn00="postgresql://postgres:@:5432"
psql $conn00 -c "DROP DATABASE if exists $DB_NAME;"
psql $conn00 -c "CREATE DATABASE $DB_NAME;"

conn="postgresql://postgres:@:5432/$DB_NAME"
psql $conn -f "$SCRIPT_HOME/seed_db.sql"
