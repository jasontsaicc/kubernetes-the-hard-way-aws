variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_id" {
  type        = list(string)
  description = "List of subnet IDs"
}

