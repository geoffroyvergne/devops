NAME=chrome
IMAGE="jess/chrome"
IP=$(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')

all: start

create:
	@if [[ -z `nerdctl ps -a | grep '${NAME}'` ]] ; then \
		nerdctl create \
			--name="${NAME}" \
			--memory 512mb \
			--net host \
			--security-opt seccomp:unconfined \
			--env "DISPLAY=${IP}:0" \
			"${IMAGE}"; \
	fi;

start: create
	@if [[ -z `netstat -an | grep 6000` ]]; then \
		open -a XQuartz; \
	fi;
	@xhost "+${IP}";
	@nerdctl start ${NAME};

stop:
	@nerdctl stop ${NAME}

rm: stop
	@nerdctl rm -v ${NAME}
	@nerdctl rmi -f ${IMAGE}

.PHONY: create start stop rm
