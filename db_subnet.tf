resource "aws_subnet" "db_subnets" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count + 4)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "db-subnet-${count.index + 1}"
  }
}
