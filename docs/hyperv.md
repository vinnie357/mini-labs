# windows hyperv

requires windows pro or higher (workstation)

## cmd

```cmd
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
```
## powershell

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
```
## permissions for hyperv

```cmd
lusrmgr.msc
```

add  your user to Hyper-V Administrators

log out and login for the new permissions to take effect


## nested virt

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/enable-nested-virtualization

### vgrant can enable nested virt

```vagrant
config.vm.provider "hyperv" do |hyperv|
    hyperv.cpus = 2
    hyperv.memory = 2048
    # allow nested virtualization
    hyperv.enable_virtualization_extensions = true
```

verify nested virt on a vm

```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
# assumes kvm is installed for kvm-ok
sudo kvm-ok
```
