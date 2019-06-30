# containers

This repository contains a number of container images that I use on my server.

## Prerequisites

My server runs RHEL 8.0 and uses the container-tools module (`podman` and `buildah`).  These *should* work on EL 7 but may require some tweaks.

```bash
$ sudo dnf module enable  container-tools:rhel8
$ sudo dnf module install container-tools:rhel8
```

## Working

* `pihole` - Runs [Pi-hole](https://pi-hole.net/) to block ads at the network level
* `openvpn` - Runs [OpenVPN](https://openvpn.net/) to enable private Virtual Private Network

## In Progress

* `samba` - Runs Samba server to serve files to Windows hosts
