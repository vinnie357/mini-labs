#https://github.com/hashicorp/packer-plugin-amazon
#https://github.com/hashicorp/packer-plugin-azure
#https://github.com/hashicorp/packer-plugin-googlecompute
#https://github.com/hashicorp/packer-plugin-vagrant
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
    azure = {
      version = ">= 1.4.2"
      source  = "github.com/hashicorp/azure"
    }
    googlecompute = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/googlecompute"
    }
    vagrant = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}
# shared variables
variable "project_prefix" {
  type    = string
  default = "mini"
}
variable "version" {
  type    = string
  default = "0.0.0"
}

# gcp variables
variable "account_file" {
  type    = string
  default = null
}
variable "additional_labels" {
  type    = map(string)
  default = {}
}
variable "project_id" {
  type    = string
  default = null
}

variable "image_base_name" {
  type    = string
  default = "ubuntu"
}

variable "image_family" {
  type    = string
  default = "lab-ubuntu"
}

variable "image_storage_location" {
  type    = string
  default = "us"
}

variable "source_image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "source_image" {
  type    = string
  default = null
}
variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "machine_type" {
  type    = string
  default = "n1-standard-2"
}

# aws variables
variable "aws_instance_type" {
  type    = string
  default = "t3.small"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "aws_ami_filter" {
  type = string
  default = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}
# vagrant variables
variable "vagrant_source_path" {
    default = "generic/ubuntu2204"
    description = << EOF
    source_path (string) - URL of the vagrant box to use, or the name of the vagrant box. hashicorp/precise64, 
    ./mylocalbox.box and https://example.com/my-box.box are all valid source boxes.
    EOF
}
variable "vagrant_provider" {
    default = "hyperv"
}
variable "vagrant_force" {
    default = true
}

# azure variables

# local variables
locals {
  suffix            = "v${var.version}"
  bucket_name       = "${var.project_prefix}-build-dependencies"
  consul_version    = "1.15.2-1"
  nomad_version     = "1.5.2-1"
  cni_version       = "1.2.0"
}

source "vagrant" "my-vagrant" {
  communicator = "ssh"
  source_path = "${var.vagrant_source_path}"
  provider = "${var.vagrant_provider}"
  add_force = var.vagrant_force
}

// source "googlecompute" "my-gcp" {
//   project_id          = var.project_id
//   source_image_family = var.source_image_family
//   source_image        = var.source_image
//   ssh_username        = "labuser"
//   zone                = var.zone
//   disk_size           = 20
//   machine_type        = var.machine_type
//   tags                = ["packer"]
//   // account_file        = var.account_file
//   impersonate_service_account = "gce-packer-sa@${var.project_id}.iam.gserviceaccount.com"
//   service_account_email       = "gce-packer-sa@${var.project_id}.iam.gserviceaccount.com"
//   image_name                  = "${var.image_base_name}-${var.image_storage_location}-${local.suffix}"
//   image_family                = var.image_family
//   image_storage_locations     = [var.image_storage_location]
//   image_licenses              = ["projects/vm-options/global/licenses/enable-vmx"]
// }

// source "amazon-ebs" "my-aws" {
//   ami_name      = "${var.image_base_name}-${var.image_storage_location}-${local.suffix}"
//   instance_type = var.aws_instance_type
//   region        = var.aws_region
//   #iam_instance_profile = "packer"
//   #https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs#ami-block-device-mappings-example
//   #https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
//   launch_block_device_mappings {
//     device_name           = "/dev/sda1"
//     volume_size           = 20
//     volume_type           = "gp2"
//     delete_on_termination = true
//   }
//   ami_block_device_mappings {
//     device_name           = "/dev/sda1"
//     volume_size           = 20
//     volume_type           = "gp2"
//     delete_on_termination = true
//   }
//   run_volume_tags = {
//     Name = "packer-${var.image_base_name}-${var.image_storage_location}-${local.suffix}"
//   }
//   tags = {
//     OS_Version    = "Ubuntu"
//     Release       = "${local.suffix}"
//     Base_AMI_Name = "{{ .SourceAMIName }}"
//   }
//   source_ami_filter {
//     filters = {
//       name                = "${var.aws_ami_filter}"
//       root-device-type    = "ebs"
//       virtualization-type = "hvm"
//     }
//     most_recent = true
//     owners      = ["099720109477"] # Canonical
//   }
//   ssh_username = "ubuntu"
// }

// # gcp
// build {
//   sources = ["source.googlecompute.my-gcp"]

//   provisioner "shell" {
//     execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
//     environment_vars = [
//       "PROJECT_PREFIX=${var.project_prefix}",
//       "DEPS_BUCKET=${local.bucket_name}",
//       "CONSUL_VERSION=${local.consul_version}",
//       "NOMAD_VERSION=${local.nomad_version}",
//       "CNI_VERSION=${local.cni_version}",
//     ]
//     scripts = [
//       "scripts/upgrade-debian.sh",
//       "../scripts-library/ubuntu/base-debian.sh",
//       "../scripts-library/ubuntu/jq-debian.sh",
//       "../scripts-library/ubuntu/qemu-debian.sh",
//       "../scripts-library/ubuntu/cni-plugins-debian.sh",
//       "scripts/upgrade-debian.sh",

//     ]
//   }
// }
// # aws
// build {
//   sources = ["source.amazon-ebs.my-aws"]

//   provisioner "shell" {
//     execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
//     environment_vars = [
//       "PROJECT_PREFIX=${var.project_prefix}",
//       "DEPS_BUCKET=${local.bucket_name}",
//       "CONSUL_VERSION=${local.consul_version}",
//       "NOMAD_VERSION=${local.nomad_version}",
//       "CNI_VERSION=${local.cni_version}",
//     ]
//     scripts = [
//       "scripts/upgrade-debian.sh",
//       "../scripts-library/ubuntu/base-debian.sh",
//       "../scripts-library/ubuntu/jq-debian.sh",
//       "../scripts-library/ubuntu/qemu-debian.sh",
//       "../scripts-library/ubuntu/cni-plugins-debian.sh",
//       "scripts/upgrade-debian.sh",

//     ]
//   }
// }
# vagrant
build {
  sources = ["source.vagrant.my-vagrant"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
    environment_vars = [
      "PROJECT_PREFIX=${var.project_prefix}",
      "DEPS_BUCKET=${local.bucket_name}",
      "CONSUL_VERSION=${local.consul_version}",
      "NOMAD_VERSION=${local.nomad_version}",
      "CNI_VERSION=${local.cni_version}",
    ]
    scripts = [
      "scripts/upgrade-debian.sh",
      "../scripts-library/ubuntu/base-debian.sh",
      "../scripts-library/ubuntu/jq-debian.sh",
      "../scripts-library/ubuntu/qemu-debian.sh",
      "../scripts-library/ubuntu/cni-plugins-debian.sh",
      "scripts/upgrade-debian.sh",

    ]
  }
}