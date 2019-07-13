# OpenVPN

This container runs [OpenVPN](https://openvpn.net/) in an SELinux environment.  This has only been tested on RHEL 8.0.

## Install

For now, run the install shell script and it will install and configure the systemd service that runs the container.

`tito` is not available on EL 8 yet but I will convert this to an RPM when that happens.

### Install Script

```bash
$ sudo ./install.sh
$ sudo systemctl enable openvpn
$ sudo systemctl start openvpn
```

### Post Install

Run through the steps below to initialize the Certificate Authority

https://hub.docker.com/r/kylemanna/openvpn/
