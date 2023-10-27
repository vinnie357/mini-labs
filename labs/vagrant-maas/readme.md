# little crazy nested virt 

trying to use vagrant hyperv and maas from wsl2


- [hyperv](../../docs/hyperv.md)
- vagrant

## windows file permissions cause some fun with where your vagrant files are:

https://github.com/hashicorp/vagrant/issues/11724

this impacts, vagrants access to powershell/cmd/hyperv and your project files

some users use symlinks to the user home dir /mnt/c/Users/youruser/* where wsl is allowed to create files by default, others just create their files there.

```bash
cat << 'EOF' > vagrantfile

Vagrant.configure(2) do |config|
    config.vm.box = "generic/ubuntu2204"
    config.vm.provider "hyperv"
end

EOF
```
mkdir /mnt/c/Users/<you>/mini-labs
ln -s /mnt/c/Users/<username>/mini-labs ~/mini-labs

ln -s /mnt/c/Users/vinni/mini-labs ~/

cd ~/mini-labs
unlink mini-labs

## work around windows vs linux file permissions
```bash
mkdir -p /mnt/c/Users/vinni/mini-labs/vagrant-maas
cp -r $PWD /mnt/c/Users/vinnie/mini-labs/vagrant-maas
cd /mnt/c/Users/vinnie/mini-labs/vagrant-maas
vagrant up
``