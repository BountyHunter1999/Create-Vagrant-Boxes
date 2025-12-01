packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  // timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  today = regex_replace(timestamp(), "T.*", "")
  ami_name  = "${var.ami_prefix}-${local.today}"
}


// Bulder Section
// https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs
source "amazon-ebs" "ubuntu" {
  // access_key = "LSIAQAAAAAAVNCBMPNSG"
  // secret_key = "test"
  // custom_endpoint_ec2 = "http://localhost.localstack.cloud:4566"
  ami_name = local.ami_name

  source_ami_filter {
    filters = {
      name = var.ami_filter_name
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    owners = ["amazon"]
    most_recent = true
  }

  instance_type = var.instance_type
  region        = var.region
  // source_ami    = "ami-0c1f44f890950b53c"

  ssh_username = var.ssh_username
  ssh_timeout  = var.ssh_timeout

  tags = {
    Name = local.ami_name
    Creator = var.creator
    CreatedWith = "Packer"
    CreatedAt = local.today
  }
}

// Provisioner
build {
  name    = "packer-build"
  sources = ["source.amazon-ebs.ubuntu"]

  // provisioner "shell" {
  //     inline = [
  //         "sudo apt-get update",
  //         "sudo apt-get install -y nginx",
  //         "sudo systemctl enable nginx",
  //         "sudo systemctl start nginx",
  //         "sudo ufw allow proto tcp from any to any port 22,80,443",
  //         "echo 'y' | sudo ufw enable"
  //     ]
  // }

  provisioner "shell" {
    # these scripts will run in isolation
    scripts = [
      "${path.root}/scripts/ubuntu/install-docker.sh",
    ]
  }

  post-processors {
    // Take the image we created in AWS and also create a Vagrant box from it to be used locally
    post-processor "vagrant" {}

    // take output of 1st post-processor and use it as input for the 2nd post-processor
    post-processor "compress" {}
  }

  post-processor "manifest" {
    output = "builds/${local.ami_name}.json"
  }
}