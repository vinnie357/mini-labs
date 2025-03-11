# cloud-hypervisor

https://www.cloudhypervisor.org/

- wsl
- nix
- git

```bash
sudo su

nix-shell -p cloud-hypervisor qemu mtools

git clone https://github.com/cloud-hypervisor/cloud-hypervisor.git

cd cloud-hypervisor

wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qemu-img convert -p -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw
wget https://github.com/cloud-hypervisor/rust-hypervisor-firmware/releases/download/0.4.2/hypervisor-fw

. ./scripts/create-cloud-init.sh

cloud-hypervisor \
	--kernel ./hypervisor-fw \
	--disk path=focal-server-cloudimg-amd64.raw path=/tmp/ubuntu-cloudinit.img \
	--cpus boot=4 \
	--memory size=1024M \
	--net "tap=,mac=,ip=,mask="

# default creds cloud/cloud123 set in cloud-init test_data/cloud-init/ubuntu/local/user-data

# exit
# sudo shutdown now
```