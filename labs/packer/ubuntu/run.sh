#!/bin/bash
packer init ubuntu.pkr.hcl
packer validate -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
#packer build -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl
#debug
#https://developer.hashicorp.com/packer/docs/commands/build
packer build -debug -on-error=ask -var-file=ubuntu.pkrvars.hcl ubuntu.pkr.hcl