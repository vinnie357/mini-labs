# packer

https://www.hashicorp.com/products/packer


## install
```bash
. scripts/packer.sh
```

## running

```bash
packer init ubuntu.pkr.hcl
packer validate -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
packer build -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
```