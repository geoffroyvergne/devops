
docker-compose -f ./compose/docker-compose-web.yaml up
docker-compose -f ./compose/docker-compose-web.yaml ps

docker-compose -f ./compose/docker-compose-nginx-php-mariadb.yaml up
docker-compose -f ./compose/docker-compose-nginx-php-mariadb.yaml ps

docker-compose -f ./compose/docker-compose-nginx-php-mariadb.yaml scale nginx=3
docker-compose -f ./compose/docker-compose-nginx-php-mariadb.yaml scale php=3