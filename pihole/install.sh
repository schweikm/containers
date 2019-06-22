#!/bin/bash
set -u

install -m 0644 pihole.sysconfig /etc/sysconfig/pihole
install -m 0644 pihole.service   /etc/systemd/system/pihole.service
systemctl daemon-reload

. /etc/sysconfig/pihole

mkdir -vp ${DATA_DIR}/etc/pihole
mkdir -vp ${DATA_DIR}/etc/dnsmasq.d

res=1
while [[ ${res} -ne 0 ]]; do
    podman pull ${IMAGE}:${TAG}
    res=$?
done

semanage fcontext -a  -t container_file_t "${DATA_DIR}(/.*)?"
restorecon -FRvv ${DATA_DIR}
setsebool -P container_manage_cgroup on
