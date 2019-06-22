# Pi-hole

This container runs [Pi-hole ](https://pi-hole.net/) in an SELinux environment.  This has only been tested on RHEL 8.0.

## Libvirt Issue

By default libvirt starts a dnsmasq instance for DHCP and DNS of virtual networks.  This causes the container to fail to bind to port 53.  You need to disable both of these services for all virtual networks.

Get a list of virtual networks

```bash
$ sudo virsh net-list -all
```

Then, for each virtual network that is NAT'd use:

```xml
<network>
  <name>default</name>
  <uuid>ba247bdf-21ec-487f-83b3-2c037680b22f</uuid>
  <forward mode='bridge'/>
  <bridge name='virbr0'/>
  <dns enable='no'/>
</network>
```

Then restart libvirtd and ensure that no dnsmasq instances are running

```bash
$ sudo systemctl restart libvirtd
$ sudo killall dnsmasq
```

## Install

For now, run the install shell script and it will install and configure the systemd service that runs the container.  Make any changes required in `pihole.sysconfig` and then run the script.

`tito` is not available on EL 8 yet but I will convert this to an RPM when that happens.

### Environment Variables

There are a number of environment variables that are required for Pi-hole to work.  You can use the default values if you want, but review them before deploying.

```bash
$ vim pihole.sysconfig
```

* `WEBPASSWORD` is the password for the admin webpage
* `DATA_DIR` is where persistent files are stored.  This should probably be its on LV

### Install Script

```bash
$ sudo ./install.sh
$ sudo systemctl enable pihole
$ sudo systemctl start pihole
```

## Web Interface

The default vhost seems to be broken when you access the interface through a non-standard port.  You can access the web interface at:

```plaintext
http://${SERVERIP}:${HTTPPORT}/admin/
```

For example,

```plaintext
http://172.16.100.117:18080/admin/
```

## Pi-hole Settings

Once you have the web interface running, you should make the following changes:

* Settings
    * DNS
        * Upstream DNS Servers - choose one you like
        * Interface listening behavior - choose **Listen on all interfaces, permit all origins**
