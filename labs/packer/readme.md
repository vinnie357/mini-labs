# Packer 

build the same image from code for all substrates.

`Note: this isn;t working end to end yet theres some wsl2 translations to deal with around packer`

## needs

- [packer](../../docs/packer.md)


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

## running ubuntu

 - [generic/ubuntu2204.box](https://app.vagrantup.com/generic/boxes/ubuntu2204)

`optional: download the base box so you don't have to pull from source each time
this requires updating the vagrant_source_path to your download in the ubuntu.pkrvars.hcl`

```bash
cd ubuntu
packer init ubuntu.pkr.hcl
packer validate -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
packer build -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
```

`note: current wsl issues are all permissions, hyperv vagrant calls need to be on the windows filesystem,
while the packer ssh keys need be have linux file permissions for ssh.`

## work around windows vs linux file permissions
```bash
mkdir -p /mnt/c/Users/vinni/mini-labs/packer
cp -r ./ /mnt/c/Users/vinni/mini-labs/packer
cd /mnt/c/Users/vinni/mini-labs/packer/ubuntu
. run.sh
```

## wsl2 issues

- file permissions wsl2 vs windows
- access to hyperv apis
- access to hyperv networking - network stazas are ignored per: https://developer.hashicorp.com/vagrant/docs/providers/hyperv/limitations
- dchp service for new vms, when attached to wsl vswitch

