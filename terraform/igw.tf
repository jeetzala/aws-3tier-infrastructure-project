resource "aws_internet_gateway" "three_tier" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "three-tier-lab-igw"
  }
}
