# How to enable nfs for vagrant on fedora

1. Install nfs-server
```bash
sudo dnf install nfs-utils && sudo systemctl enable nfs-server
```

2. Enable services in firewall
```bash
sudo firewall-cmd --permanent --add-service=nfs \
    && sudo firewall-cmd --permanent --add-service=rpc-bind \
    && sudo firewall-cmd --permanent --add-service=mountd \
    && sudo firewall-cmd --reload
```

3. Enable udp in nfs-server

   Ensure this option is enabled in file `/etc/nfs.conf`:
```bash
[nfsd]
udp=y
```

4. Restart nfs-server.service
```bash
sudo systemctl restart nfs-server.service
```
