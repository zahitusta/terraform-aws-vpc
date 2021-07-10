resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr1
  map_public_ip_on_launch = true             # Assigns Public IP for instance  
  availability_zone       = "${var.region}a" # Deploys subnet to AZ 1
  tags                    = var.tags
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr2
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b"
  tags                    = var.tags
}


resource "aws_subnet" "public3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr3
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}c"
  tags                    = var.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public.id
}