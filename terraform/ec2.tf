resource "aws_instance" "nomad_instance" {
  count                       = var.num[terraform.workspace]
  key_name                    = var.key_name
  ami                         = data.aws_ami.amzlin2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.sg]

  # user_data                   = <<-EOF
  #   #!/bin/bash
  #   sudo yum update -y && sudo yum upgrade -y
  #   sudo yum install -y yum-utils
  #   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  #   sudo yum -y install nomad
  # EOF

  tags = merge(var.tags, tomap({
    "Environment" = var.environment
  }))
}

output "aws_instances" {
  value = aws_instance.nomad_instance.*.public_dns
}
