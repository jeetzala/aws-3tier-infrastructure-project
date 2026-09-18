resource "aws_route_table" "public" {
  vpc_id = aws_vpc.three_tier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three_tier.id
  }

  tags = {
    Name = "three-tier-lab-public-rt"
  }
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "three-tier-lab-app-rt"
  }
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "three-tier-lab-db-rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app_1" {
  subnet_id      = aws_subnet.app_1.id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "app_2" {
  subnet_id      = aws_subnet.app_2.id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "db_1" {
  subnet_id      = aws_subnet.db_1.id
  route_table_id = aws_route_table.db.id
}

resource "aws_route_table_association" "db_2" {
  subnet_id      = aws_subnet.db_2.id
  route_table_id = aws_route_table.db.id
}
