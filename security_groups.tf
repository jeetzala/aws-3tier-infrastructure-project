resource "aws_security_group" "alb" {
  name                   = "three-tier-lab-alb-sg"
  description            = "Security group for internet-facing Application Load Balancer"
  vpc_id                 = var.alb_original_vpc_id
  revoke_rules_on_delete = false

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_security_group_vpc_association" "alb" {
  security_group_id = aws_security_group.alb.id
  vpc_id            = aws_vpc.three_tier.id
}

resource "aws_security_group" "frontend" {
  name                   = "three-tier-lab-frontend-sg"
  description            = "Security group for frontend web servers"
  vpc_id                 = aws_vpc.three_tier.id
  revoke_rules_on_delete = false

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend" {
  name                   = "three-tier-lab-backend-sg"
  description            = "Security group for backend application servers"
  vpc_id                 = aws_vpc.three_tier.id
  revoke_rules_on_delete = false

  ingress {
    description     = "Allow application traffic from frontend"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database" {
  name                   = "three-tier-lab-database-sg"
  description            = "Security group for RDS MySQL database"
  vpc_id                 = aws_vpc.three_tier.id
  revoke_rules_on_delete = false

  ingress {
    description     = "Allow MySQL only from backend servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}