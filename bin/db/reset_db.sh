#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/../.." ;             a=$(cd "$a" && pwd) ; APP_HOME="$a"

if [[ ! -f "$APP_HOME/.env" ]]; then echo "File not found .env at $APP_HOME"; exit; fi
source "$APP_HOME/.env"

conn00="postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT"
psql $conn00 -c "DROP DATABASE if exists $DB_NAME;"
psql $conn00 -c "CREATE DATABASE $DB_NAME;"

conn="postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME"
psql $conn -f "$SCRIPT_HOME/seed_db.sql"
