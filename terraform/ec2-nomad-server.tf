resource "aws_instance" "nomad_server" {
  count                       = var.num[terraform.workspace]
  key_name                    = var.key_name
  ami                         = data.aws_ami.nomad_server_client.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.sg]
  user_data = <<-EOF
  sudo ansible-playbook /tmp/nomad-configs/nomad-server-init.yml 
  EOF
  tags = merge(var.tags, tomap({"Environment" = var.environment}), tomap({"Name" = "nomad-server"}))
}

output "nomad_servers" {
  value = aws_instance.nomad_server.*.public_dns
}
