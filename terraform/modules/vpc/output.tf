output "vpc_id" {
  value = aws_vpc.kubernetes.id
}

output "subnet_id" {
  value = aws_subnet.kubernetes_subnet.id
}
