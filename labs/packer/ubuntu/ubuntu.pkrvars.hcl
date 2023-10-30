# shared
project_prefix  = "mini"
image_base_name = "ubuntu"
version         = "0-0-0"

# gcp
project_id          = "my-project-id"
image_family        = "ubuntu"
source_image_family = "ubuntu-2204-lts"
machine_type        = "n1-standard-4"
zone                = "us-east1-b"

# aws
aws_region        = "us-east-1"
aws_instance_type = "t3.small"
aws_ami_filter    = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

#vagrant
vagrant_source_path = "./ubuntu2204.box"