#VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block       = terraform.workspace == "dev" ? var.dev_vpc_cidr : var.prod_vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-vpc")
  }
}
#IGW
resource "aws_internet_gateway" "dev_IGW" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-iGW")
  }
}
# Public Subnets
resource "aws_subnet" "dev_public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-public-subnet-${count.index + 1}")
  }
  depends_on = [aws_vpc.dev_vpc]
}
# Public Route Table
resource "aws_route_table" "dev_public_RT" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_IGW.id
  }
  tags = {
    "Name" = title("${var.project_name}-${terraform.workspace}-public-rT")
  }
}
# P-RT association with P-Subnets
resource "aws_route_table_association" "dev_public_RT_subnets" {
  count          = length(var.public_subnets_cidr)
  route_table_id = aws_route_table.dev_public_RT.id
  subnet_id      = element(aws_subnet.dev_public_subnets[*].id, count.index)
}