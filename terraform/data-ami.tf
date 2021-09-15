data "aws_ami" "nomad_server_client" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nomad-server-client-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.owner_id]
}
