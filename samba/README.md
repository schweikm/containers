# Samba

## Building

Build the container image.  The smb password is set in the environment at build time
```bash
export SMBPASS="[password]"
./build.sh
```

## Running

```bash
$ systemctl enable samba
$ systemctl start samba
```



# ausearch -c 'smbd' --raw | audit2allow -M my-smbd
# semodule -X 300 -i my-smbd.pp

