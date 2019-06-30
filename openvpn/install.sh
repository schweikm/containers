#!/bin/bash
set -u

install -m 0644 openvpn.sysconfig /etc/sysconfig/openvpn
install -m 0644 openvpn.service   /etc/systemd/system/openvpn.service
systemctl daemon-reload

. /etc/sysconfig/openvpn

mkdir -vp ${DATA_DIR}/etc/openvpn

res=1
while [[ ${res} -ne 0 ]]; do
    podman pull ${IMAGE}:${TAG}
    res=$?
done

semanage fcontext -a  -t container_file_t "${DATA_DIR}(/.*)?"
restorecon -FRvv ${DATA_DIR}
setsebool -P container_manage_cgroup on
setsebool -P domain_kernel_load_modules 1

firewall-cmd --permanent --add-service=openvpn
firewall-cmd --reload
