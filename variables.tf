variable "aws_region" {
  description = "AWS region for the three-tier infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name used for AWS resource names and tags"
  type        = string
  default     = "three-tier-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the three-tier VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type for frontend and backend"
  type        = string
  default     = "t3.micro"
}

variable "frontend_ami" {
  description = "AMI used by the existing frontend EC2 instance"
  type        = string
  default     = "ami-081720d39920a9281"
}

variable "backend_ami" {
  description = "AMI used by the existing backend EC2 instance"
  type        = string
  default     = "ami-04afd8e501a128ee3"
}

variable "alb_original_vpc_id" {
  description = "Original VPC associated with the ALB security group"
  type        = string
  default     = "vpc-0af4b1a46bfa5b719"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "rds_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.4.9"
}

variable "rds_allocated_storage" {
  description = "Initial RDS storage in GiB"
  type        = number
  default     = 20
}

variable "rds_secret_arn" {
  description = "ARN of the existing RDS credentials secret"
  type        = string
  default     = "arn:aws:secretsmanager:eu-central-1:649170435174:secret:three-tier-lab/rds-credentials-8X2SXM"
}