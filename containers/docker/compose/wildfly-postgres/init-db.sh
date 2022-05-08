#!/bin/bash -ve

echo "init-db"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE EXTENSION adminpack;

    CREATE USER wildfly WITH PASSWORD 'wildfly';
    CREATE DATABASE wildfly;
    GRANT ALL PRIVILEGES ON DATABASE wildfly TO wildfly;
EOSQL