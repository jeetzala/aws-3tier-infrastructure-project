resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-public-2"
  }
}

resource "aws_subnet" "app_1" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-app-1"
  }
}

resource "aws_subnet" "app_2" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-app-2"
  }
}

resource "aws_subnet" "db_1" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.21.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-db-1"
  }
}

resource "aws_subnet" "db_2" {
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = "10.0.22.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "three-tier-lab-db-2"
  }
}