# firecracker wsl2

## setup

```bash
# get images
. get_images.sh
```

## start

`Check for latest kernel builds  https://s3.amazonaws.com/spec.ccfc.min/`
```bash
curl -s https://s3.amazonaws.com/spec.ccfc.min/ | xmllint --xpath "//*/*" - | grep -e '<Key>firecracker-ci/v1.6/x86_64/vmlinux-'
```

```bash
KERNEL_VERSION=5.10.198
kernelImage="machines/vmlinux-${KERNEL_VERSION}"
diskImage="machines/ubuntu-22.04.ext4"
cat <<EOF > vmconfig.json
{
  "boot-source": {
    "kernel_image_path": "${kernelImage}",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off",
    "initrd_path": null
  },
  "drives": [
    {
      "drive_id": "rootfs",
      "path_on_host": "${diskImage}",
      "is_root_device": true,
      "partuuid": null,
      "is_read_only": false,
      "cache_type": "Unsafe",
      "io_engine": "Sync",
      "rate_limiter": null
    }
  ],
  "machine-config": {
    "vcpu_count": 2,
    "mem_size_mib": 1024,
    "smt": false,
    "track_dirty_pages": false
  },
  "cpu-config": null,
  "balloon": null,
  "network-interfaces": [],
  "vsock": null,
  "logger": null,
  "metrics": null,
  "mmds-config": null,
  "entropy": null
}
EOF
```

## run
```bash
API_SOCKET="/tmp/firecracker.socket"
# Remove API unix socket
rm -f $API_SOCKET
sudo firecracker --api-sock "${API_SOCKET}" --config-file vmconfig.json
#sudo firecracker --api-sock /tmp/firecracker.socket --config-file vmconfig.json
```

## stop

```bash
# to stop the firecracker vm issue a reboot command
reboot
# remove the used socket
rm -f $API_SOCKET
unset API_SOCKET

```