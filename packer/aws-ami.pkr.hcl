packer {
  required_plugins {
    amazon = {
      version = " >= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nomad_ami" {
  ami_name      = "nomad"
  instance_type = "t2.micro"
  region        = "us-east-2"
  ssh_username  = "ec2-user"
  source_ami_filter {
    most_recent = true
    owners      = ["137112412989"]
    filters = {
      name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
      virtualization-type = "hvm"
    }
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y && sudo yum upgrade -y
    sudo amazon-linux-extras install epel -y
    sudo yum install ansible -y
  EOF
  tags = {
    "owner"       = "phil"
    "environment" = "prod"
  }
}

build {
  sources = [
    "source.amazon-ebs.nomad_ami"
  ]

  provisioner "ansible-local" {
    playbook_file = "./000-nomad.yml"
  }

  provisioner "file" {
    source      = "nomad-configs"
    destination = "/tmp/nomad-configs"
  }
}