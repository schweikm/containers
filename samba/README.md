# Samba

## Building

```bash
export SMBPASS="[password]"
sudo buildah bud -t localhost/samba:latest --build-arg SMBPASS .
```

## Running

```bash
podman run --rm --network host -v /export/samba:/export/samba localhost/samba:latest
```
