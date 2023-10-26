# little crazy nested virt 

trying to use vagrant hyperv and maas from wsl2


- have hyperv
- vagrant

```bash
cat << 'EOF' > vagrantfile

Vagrant.configure(2) do |config|
    config.vm.box = "generic/ubuntu2204"
    config.vm.provider "hyperv"
end

EOF
```