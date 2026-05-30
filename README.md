# AWS 3-Tier Infrastructure Project

## Overview

This project demonstrates the design and deployment of a scalable AWS infrastructure using Amazon VPC, EC2 Auto Scaling Groups, Launch Templates, Security Groups, and Amazon RDS.

The environment was built following cloud architecture best practices, including network segmentation, private database deployment, and automated compute provisioning.

## Architecture

The infrastructure consists of:

* Custom Amazon VPC
* Public and Private Subnets across multiple Availability Zones
* Internet Gateway
* Route Tables
* Frontend EC2 Auto Scaling Group
* Backend EC2 Auto Scaling Group
* Launch Templates
* Security Groups
* Amazon RDS MySQL Database

### High-Level Flow

Internet → Frontend Tier → Backend Tier → RDS Database

## AWS Services Used

* Amazon VPC
* Amazon EC2
* EC2 Launch Templates
* EC2 Auto Scaling Groups
* Amazon RDS (MySQL)
* Security Groups
* Internet Gateway
* Route Tables

## Network Design

### VPC

CIDR Block:

10.0.0.0/16

### Public Subnets

* public-subnet-a
* public-subnet-b

### Private Subnets

* private-subnet-a
* private-subnet-b

## Security

Security Groups were configured to control communication between infrastructure components and limit unnecessary exposure.

## Database Layer

Amazon RDS MySQL was deployed inside the VPC with controlled access through security groups.

## Screenshots

### VPC Overview
![VPC Overview](screenshots/vpc-overview.png)

### Subnets
![Subnets](screenshots/subnets.png)

### Route Tables
![Route Tables](screenshots/route-tables.png)

### Internet Gateway
![Internet Gateway](screenshots/internet-gateway.png)

### Frontend Auto Scaling Group
![Frontend ASG](screenshots/frontend-asg.png)

### Backend Auto Scaling Group
![Backend ASG](screenshots/backend-asg.png)

### EC2 Instances
![EC2 Instances](screenshots/ec2-instances.png)

### RDS Database
![RDS](screenshots/rds-overview.png)

See the screenshots folder for deployment evidence and configuration details.

## Key Learning Outcomes

* Designing custom VPC architectures
* Creating public and private subnet strategies
* Configuring route tables and internet access
* Deploying EC2 Launch Templates
* Implementing Auto Scaling Groups
* Managing Security Groups
* Deploying and managing Amazon RDS
* Understanding multi-tier AWS architectures

## Author

Jeet Zala
AWS Cloud Portfolio Project

