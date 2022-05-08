https://docs.docker.com/swarm/overview/
https://docs.docker.com/swarm/install-w-machine/

docker-machine create --driver virtualbox --engine-opt experimental=true manager1 &&
docker-machine create --driver virtualbox --engine-opt experimental=true worker1 &&
docker-machine create --driver virtualbox --engine-opt experimental=true worker2

docker swarm init --advertise-addr 192.168.99.106

docker swarm join \
    --token SWMTKN-1-68925d0glfamyl4yq7y102wktnem6vd6paghgdeb0r38tpckd3-1eu44r6d7xvtkioezmfqtsuf3 \
    192.168.99.106:2377

docker node ls

docker info

-------------

docker deploy --compose-file docker-compose.yaml management