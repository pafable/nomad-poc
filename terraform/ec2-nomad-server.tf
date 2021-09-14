resource "aws_instance" "nomad_server" {
  count                       = var.num[terraform.workspace]
  key_name                    = var.key_name
  ami                         = data.aws_ami.nomad_server.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.sg]
  tags = merge(var.tags, tomap({
    "Environment" = var.environment
  }))
}

output "nomad_servers" {
  value = aws_instance.nomad_instance.*.public_dns
}
