resource "aws_instance" "frontend" {
  ami                         = var.frontend_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  iam_instance_profile        = aws_iam_instance_profile.three_tier_ec2_ssm.name
  associate_public_ip_address = true
  monitoring                  = false
  ebs_optimized               = true

  user_data = <<-USERDATA
#!/bin/bash
dnf update -y
dnf install -y nginx
systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Three-Tier AWS Lab</title>
</head>
<body>
    <h1>Frontend Tier</h1>
    <p>three-tier-lab</p>
    <p>Amazon Linux + NGINX</p>
</body>
</html>
EOF
USERDATA

  user_data_replace_on_change = false

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
  }

  tags = {
    Name = "three-tier-lab-frontend-1"
  }
}

resource "aws_instance" "backend" {
  ami                         = var.backend_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.app_1.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  iam_instance_profile        = aws_iam_instance_profile.three_tier_ec2_ssm.name
  associate_public_ip_address = false
  monitoring                  = false
  ebs_optimized               = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
  }

  tags = {
    Name = "three-tier-lab-backend-1"
  }
}
