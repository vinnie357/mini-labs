# nix

declarative system management

## install multi-user

```bash
#!/bin/bash
HOME="/root" sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-env -i cowsay
cowsay 'nix is fully operational'
```

## uninstall multi-user

https://nixos.org/manual/nix/stable/installation/uninstall

```bash
sudo systemctl stop nix-daemon.service
sudo systemctl disable nix-daemon.socket nix-daemon.service
sudo systemctl daemon-reload

sudo rm -rf /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf /nix ~root/.nix-channels ~root/.nix-defexpr ~root/.nix-profile

for i in $(seq 1 32); do
  sudo userdel nixbld$i
done
sudo groupdel nixbld

#/etc/bash.bashrc
#/etc/bashrc
#/etc/profile
#/etc/zsh/zshrc
#/etc/zshrc

```