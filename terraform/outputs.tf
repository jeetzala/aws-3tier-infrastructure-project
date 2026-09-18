output "vpc_id" {
  description = "Three-tier VPC ID"
  value       = aws_vpc.three_tier.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "app_subnet_ids" {
  description = "Application subnet IDs"
  value = [
    aws_subnet.app_1.id,
    aws_subnet.app_2.id
  ]
}

output "db_subnet_ids" {
  description = "Database subnet IDs"
  value = [
    aws_subnet.db_1.id,
    aws_subnet.db_2.id
  ]
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.three_tier.dns_name
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.three_tier.arn
}

output "frontend_instance_id" {
  description = "Frontend EC2 instance ID"
  value       = aws_instance.frontend.id
}

output "backend_instance_id" {
  description = "Backend EC2 instance ID"
  value       = aws_instance.backend.id
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.three_tier.address
}

output "rds_port" {
  description = "RDS port"
  value       = aws_db_instance.three_tier.port
}

output "rds_secret_arn" {
  description = "RDS credentials secret ARN"
  value       = aws_secretsmanager_secret.rds_credentials.arn
}
