resource "aws_security_group" "kubernetes" {
  vpc_id = var.vpc_id
  name   = "kubernetes"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16", "10.200.0.0/16"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubernetes"
  }
}


resource "aws_instance" "controller" {
  count                 = 3
  ami                   = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  subnet_id             = var.subnet_id
  vpc_security_group_ids = [aws_security_group.kubernetes.id]  # 修正這一行
  private_ip            = "10.0.1.1${count.index}"
  associate_public_ip_address = true

  tags = {
    Name = "controller-${count.index}"
  }
}

resource "aws_instance" "worker" {
  count                 = 3
  ami                   = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  subnet_id             = var.subnet_id
  vpc_security_group_ids = [aws_security_group.kubernetes.id]  # 修正這一行
  private_ip            = "10.0.1.2${count.index}"
  associate_public_ip_address = true

  tags = {
    Name = "worker-${count.index}"
  }
}
