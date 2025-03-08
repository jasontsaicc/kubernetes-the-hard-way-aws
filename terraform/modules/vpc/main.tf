resource "aws_vpc" "kubernetes" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "kubernetes-the-hard-way"
  }
}

resource "aws_subnet" "kubernetes_subnet" {
  vpc_id            = aws_vpc.kubernetes.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "kubernetes-subnet"
  }
}

resource "aws_internet_gateway" "kubernetes_igw" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "kubernetes-igw"
  }
}

resource "aws_route_table" "kubernetes_rt" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.kubernetes_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kubernetes_igw.id
}

resource "aws_route_table_association" "kubernetes" {
  subnet_id      = aws_subnet.kubernetes_subnet.id  # 修正名稱
  route_table_id = aws_route_table.kubernetes_rt.id
}
