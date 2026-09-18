resource "aws_db_subnet_group" "three_tier" {
  name        = "three-tier-lab-db-subnet-group"
  description = "Private database subnet group for three-tier lab"

  subnet_ids = [
    aws_subnet.db_1.id,
    aws_subnet.db_2.id
  ]
}

resource "aws_db_instance" "three_tier" {
  identifier = "database-1"

  engine         = "mysql"
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class

  allocated_storage = var.rds_allocated_storage
  storage_type      = "gp2"
  storage_encrypted = true

  db_subnet_group_name = aws_db_subnet_group.three_tier.name

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  publicly_accessible = false
  multi_az            = false
  network_type        = "IPV4"

  username = "admin"

  parameter_group_name = "default.mysql8.4"
  option_group_name    = "default:mysql-8-4"
  license_model        = "general-public-license"

  backup_retention_period = 1
  backup_window           = "01:16-01:46"
  maintenance_window      = "fri:21:27-fri:21:57"

  auto_minor_version_upgrade = true
  deletion_protection        = false
  copy_tags_to_snapshot      = true

  max_allocated_storage = 1000

  monitoring_interval          = 0
  performance_insights_enabled = false

  apply_immediately   = false
  skip_final_snapshot = true

  lifecycle {
    ignore_changes = [
      password
    ]
  }
}