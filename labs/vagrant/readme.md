# vagrant

trying to use vagrant hyperv and from wsl2


- [hyperv](../../docs/hyperv.md)
- vagrant


https://app.vagrantup.com/generic/boxes/ubuntu2204


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
 symlinks

```bash
mkdir /mnt/c/Users/<you>/mini-labs
ln -s /mnt/c/Users/<username>/mini-labs ~/mini-labs

#ln -s /mnt/c/Users/vinni/mini-labs ~/
#cd ~/mini-labs
#unlink mini-labs
```

## work around windows vs linux file permissions
```bash
mkdir -p /mnt/c/Users/vinni/mini-labs/vagrant
cp -r ./ /mnt/c/Users/vinni/mini-labs/vagrant
# updates
#cp -r ~/mini-labs/labs/vagrant/ /mnt/c/Users/vinni/mini-labs/
cd /mnt/c/Users/vinni/mini-labs/vagrant
vagrant up
```

## default creds

vagrant:vagrant

## created default external bridged hyperv vswitch

this allows the vm, wsl, and your machine to connect to the vm.

https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-switch-for-hyper-v-virtual-machines?tabs=powershell

```powershell
Get-NetAdapter
New-VMSwitch -Name vagrant  -NetAdapterName Wi-fi
```

## optional

I like to use a libary of scripts and some local scripts for faster iteration or changes

so local scripts will be in `./scripts` and the scripts library will source from `../scripts-library`

https://github.com/vinnie357/scripts-library

```bash
# adding it
git submodule add -b main https://github.com/vinnie357/scripts-library/
# updating it
git submodule update --recursive --remote
```