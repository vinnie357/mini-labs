#!/bin/bash
#https://gaganmanku96.medium.com/kubernetes-setup-with-minikube-on-wsl2-2023-a58aea81e6a3
cat << 'EOF' > /etc/wsl.conf

# enable disk mounts
[automount]
options = "metadata"
# enable systemd
[boot]
systemd=true

EOF

# restart your wsl instance