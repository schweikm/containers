#!/bin/bash
set -eu

sudo buildah bud -t localhost/samba:latest --build-arg SMBPASS=${SMBPASS} .
