resource "aws_iam_instance_profile" "nomad_profile" {
  name = "nomad-profile"
  role = aws_iam_role.nomad_role.name
}

resource "aws_iam_role" "nomad_role" {
  name = "nomad-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "nomad-inline-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ssm:PutParameter",
            "ssm:GetParameter",
            "ssm:GetParameters"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
  tags = merge(var.tags, tomap({ "Environment" = var.environment }), tomap({ "Name" = "nomad-role" }))
}


