packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

// Bulder Section
// https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs
source "amazon-ebs" "ubuntu" {
    // access_key = "LSIAQAAAAAAVNCBMPNSG"
    // secret_key = "test"
    // custom_endpoint_ec2 = "http://localhost.localstack.cloud:4566"
    ami_name = "packer-ubuntu"

    instance_type = "t2.micro"
    region = "us-east-1"
    source_ami = "ami-0c1f44f890950b53c"
    ssh_username = "ubuntu"
}

// Provisioner
build {
    name = "packer-build"
    sources = ["source.amazon-ebs.ubuntu"]

    provisioner "shell" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y nginx",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "sudo ufw allow proto tcp from any to any port 22,80,443",
            "echo 'y' | sudo ufw enable"
        ]
    }

    // Take the image we created in AWS and also create a Vagrant box from it to be used locally
    post-processor "vagrant" {

    }

    // take output of 1st post-processor and use it as input for the 2nd post-processor
    post-processor "compress" {

    }
}