#!/bin/bash

VIRTUAL_IP=${KEEPALIVED_VIRTUAL_IP:-127.0.0.1} # required
IP_CHECK=${KEEPALIVED_IP_CHECK:-127.0.0.1}
PORT_CHECK=${KEEPALIVED_PORT_CHECK:-1883}
INTERFACE_CHECK=${KEEPALIVED_INTERFACE_CHECK:-eth0}
INSTANCE_STATE=${KEEPALIVED_INSTANCE_STATE:-MASTER}
INSTANCE_PRIORITY=${KEEPALIVED_INSTANCE_PRIORITY:-101} # required

# Init failover config
cat>/etc/keepalived/keepalived.conf<<EOF
vrrp_script chk_haproxy {
  script "</dev/tcp/${IP_CHECK}/${PORT_CHECK}"
  interval 2
  weight 2
}
vrrp_instance VI_1 {
  interface ${INTERFACE_CHECK}
  state ${INSTANCE_STATE}
  virtual_router_id 51
  priority ${INSTANCE_PRIORITY}
  virtual_ipaddress {
    ${VIRTUAL_IP}
  }
  track_script {
    chk_haproxy
  }
}
EOF

cat /etc/keepalived/keepalived.conf

#keepalived --use-file /etc/keepalived/keepalived.conf --dont-fork --log-console $@

exec "$@"