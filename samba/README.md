# Samba

## Building

Build the container image.  The smb password is set in the environment at build time
```bash
SMBPASS="password" ./build.sh
```

## Running

To not conflict with the built-in service, this container runs as `samba.service` rather than `smb.service`

```bash
$ systemctl enable samba
$ systemctl start samba
```

## SELinux

You should label the filesystem you are exporting with `container_file_t`

```bash
$ semanage fcontext -a -t container_file_t "/export/samba(/.*)?"
$ restorecon -FRvv /export/samba
```

I had to apply a custom rule to make my setup work too but I don't know if this is always required

```bash
$ ausearch -c 'smbd' --raw | audit2allow -M my-smbd
$ semodule -X 300 -i my-smbd.pp
```
