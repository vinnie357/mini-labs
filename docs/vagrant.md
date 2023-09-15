# vagrant

https://gist.github.com/HonkinWaffles/ec48e5c37f2c410c07d97cfb0a0d016d#file-vagrant_setup-md

```markdown
# Vagrant With Windows, WSL2 and Hyper-V
To say getting this configuration working is a pain in the ass is an understatement. However, once it is working correctly you gain access to tools like Ansible and full performance VMs inside Windows. This guide covers the steps I followed to get things working correctly with this configuration. It is possible that something may not work for you however I have been able to reproduce this success on two Windows 11 Pro machines and expect this to work for others.

This guide assumes basic knowledge of Windows and Linux systems and how Vagrant operates. Due to the difficulty of setting this up you may need to do some additional troubleshooting

## Requirements
* Windows Professional - Hyper-V can only be installed on Windows Professional systems or higher
* WSL2 - Due to the massive differences between WSL1 and WSL2 this guide will only cover support for WSL2
* CPU Virtualization - While the vast majority of modern CPUs support virtualization you may need to enable it in your BIOS

# Getting Started

## Windows
* There is a good chance you will need to enable long filename support. Head into the registry and head to ``HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`` and change ``LongPathsEnabled`` to ``1``

* Install Vagrant in Windows from the [Vagrant website](https://www.vagrantup.com/downloads)
* Reboot your PC to finish the registry update and the Vagrant install

## WSL
* Open WSL as a Windows Administrator (Either by opening the WSL app or the Windows terminal application)
* Update your repository to include the most recent version of Vagrant on your WSL install. (In my case I am using Ubuntu 20.04)
    ```
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt update && sudo apt upgrade -y
    ```

    ```
    sudo apt install vagrant
    ```
* Add the following variables to the end of the ``~/.profile`` file and refresh your source
    ```
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    ```
    ```
    source ~/.profile
    ```
* Create ``/etc/wsl.conf`` and add the following to the file
    ```
    [automount]
    options = "metadata"
    ```
* You could restart  WSL with ``wsl --shutdown`` in Powershell, but if you run into errors reboot your PC and try again

* Navigate to somewhere on your ``C:\\`` drive in WSL (``/mnt/c/``) and create a folder. **This is required due to how Vagrant and Hyper-V handles files.**
* Then inside that folder create a file named ``vagrantfile``
* Add the following into the file
    ```
    Vagrant.configure(2) do |config|
        config.vm.box = "generic/ubuntu2004"
        config.vm.provider "hyperv"
    end
    ```
* Save the file and then run ``vagrant up``
* If everything is setup correctly then you are done and you have setup Vagrant in WSL to control Hyper-V
```