resource "aws_instance" "nomad_server" {
  count                       = var.num[terraform.workspace]
  key_name                    = var.key_name
  ami                         = data.aws_ami.nomad_server_client.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.nomad_profile.name
  vpc_security_group_ids      = [aws_security_group.nomad_access.id]
  user_data                   = <<-EOF
    #!/bin/bash
    sudo ansible-playbook /tmp/nomad-configs/nomad-server-init.yml --extra-vars public=$(curl http://169.254.169.254/latest/meta-data/public-hostname)" > /tmp/ansible-init.log
  EOF
  tags                        = merge(var.tags, tomap({ "Environment" = var.environment }), tomap({ "Name" = "nomad-server" }))
}

output "nomad_servers" {
  value = aws_instance.nomad_server.*.public_dns
}
