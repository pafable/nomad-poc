resource "aws_instance" "nomad_client" {
  count                       = var.num[terraform.workspace]
  key_name                    = var.key_name
  ami                         = data.aws_ami.nomad_server_client.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  iam_instance_profile        = var.role
  vpc_security_group_ids      = [aws_security_group.nomad_access.id]
  user_data                   = <<-EOF
    #!/bin/bash
    sleep 20
    sudo ansible-playbook /tmp/nomad-configs/nomad-client-init.yml --extra-vars "hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname) server=$(aws ssm get-parameter --name nomad-server --region us-east-2 | jq .'Parameter'.'Value' | tr -d '"')" > /tmp/ansible-init.log
  EOF
  tags                        = merge(var.tags, tomap({ "Environment" = var.environment }), tomap({ "Name" = "nomad-client" }))
  depends_on = [
    aws_instance.nomad_server
  ]
}

output "nomad_clients" {
  value = aws_instance.nomad_client.*.public_dns
}
