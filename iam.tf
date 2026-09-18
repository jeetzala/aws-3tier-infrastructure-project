resource "aws_iam_role" "three_tier_ec2_ssm" {
  name        = "three-tier-lab-ec2-ssm-role"
  path        = "/"
  description = "IAM role for EC2 Systems Manager access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.three_tier_ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "read_rds_secret" {
  name = "three-tier-lab-read-rds-secret"
  role = aws_iam_role.three_tier_ec2_ssm.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ReadThreeTierRDSSecret"
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = var.rds_secret_arn
      }
    ]
  })
}

resource "aws_iam_instance_profile" "three_tier_ec2_ssm" {
  name = "three-tier-lab-ec2-ssm-role"
  path = "/"
  role = aws_iam_role.three_tier_ec2_ssm.name
}