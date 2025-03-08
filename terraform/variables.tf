variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "AWS Availability Zone"
  default     = "ap-northeast-1c"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default = "ami-072298436ce5cb0c4"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}
