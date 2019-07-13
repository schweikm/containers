#!/bin/bash
set -u

install -m 0644 samba.sysconfig /etc/sysconfig/samba
install -m 0644 samba.service   /etc/systemd/system/samba.service
systemctl daemon-reload
