resource "aws_iam_instance_profile" "nomad_profile" {
  name = "nomad-role"
  role = aws_iam_role.nomad_role.name
}

resource "aws_iam_role" "nomad_role" {
  name = "nomad_role"
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
}


