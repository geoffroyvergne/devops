#!/bin/bash -ve

echo "init-db"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE EXTENSION adminpack;

    CREATE USER sonar WITH PASSWORD 'sonar';
    CREATE DATABASE sonar;
    GRANT ALL PRIVILEGES ON DATABASE sonar TO sonar;
EOSQL