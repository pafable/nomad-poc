resource "aws_security_group" "nomad_access" {
  name        = "ssh-nomad-ui"
  description = "SSH Access"

  ingress {
    description      = "sshi"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "nomad ui"
    from_port        = 4646
    to_port          = 4646
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "nomad client to server"
    from_port   = 4647
    to_port     = 4647
    protocol    = "tcp"
    self        = true
  }

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, tomap({ "Environment" = var.environment }), tomap({ "Name" = "nomad-sg" }))
}
