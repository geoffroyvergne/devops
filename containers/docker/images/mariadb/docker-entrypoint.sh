#!/bin/bash

if [ "$(ls -A /var/lib/mysql/)" ];
then
echo "Mariadb already installed"
else
echo "install Mariadb"
mysql_install_db --user=mysql --basedir=/usr/ --ldata=/var/lib/mysql/
fi

TMP_SQL_FILE=/tmp/init.sql

cat > $TMP_SQL_FILE <<-EOSQL
		UPDATE mysql.user SET host = "%", password = PASSWORD("root") WHERE user = "root" LIMIT 1 ;
		DELETE FROM mysql.user WHERE user != "root" OR host != "%" ;
		DROP DATABASE IF EXISTS test ;
		FLUSH PRIVILEGES ;
EOSQL

echo "Mariadb configuration done"

#mysqld --init-file=$TMP_SQL_FILE $@

exec "$@"