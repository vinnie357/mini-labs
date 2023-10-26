# windows hyperv

requires windows pro or higher (workstation)

```cmd
## cmd
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
```

```powershell
## powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
```