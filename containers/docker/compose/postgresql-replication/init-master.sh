#!/bin/bash -ve

echo "init-master"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE EXTENSION adminpack;

    CREATE USER docker WITH PASSWORD 'docker';
    CREATE DATABASE docker;
    GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
EOSQL