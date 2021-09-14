packer {
  required_plugins {
    amazon = {
      version = " >= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nomad_server_client_ami" {
  ami_name      = "nomad-server-client-${formatdate("YYYY-MM-DD-hh-mm-ss",timestamp())}"
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
  tags = {
    "owner"       = "phil"
    "environment" = "Dev"
    "Name"        = "nomad-server-client"
  }
}

build {
  sources = [
    "source.amazon-ebs.nomad_server_client_ami"
  ]

  provisioner "shell" {
    script = "./init.sh"
  }

  provisioner "file" {
    source      = "./nomad-configs"
    destination = "/tmp"
  }

  provisioner "ansible-local" {
    playbook_file = "./ansible-playbooks/nomad-server.yml"
  }
}
