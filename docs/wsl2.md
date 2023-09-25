# wsl2

## enable

```powershell
# as admin
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

## wsl distro install

```powershell
wsl --set-default-version 2
wsl --update
wsl --list --online
wsl --install -d <DISTRO-NAME>
```

## already running? check your version ubuntu

```bash
cat /etc/lsb-release 
```


## restarting to enable systemd

https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/

```powershell
# stop
wsl --shutdown
# get latest
wsl --update
# check version
wsl --version
# start wsl
wsl
```






