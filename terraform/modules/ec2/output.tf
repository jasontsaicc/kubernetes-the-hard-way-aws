output "controller_instances" {
  value = aws_instance.controller[*]
}

output "worker_instances" {
  value = aws_instance.worker[*]
}

output "controller_ips" {
  description = "Private IPs of Kubernetes controllers"
  value       = [for instance in aws_instance.controller[*] : instance.private_ip]
}

output "worker_ips" {
  description = "Private IPs of Kubernetes worker nodes"
  value       = [for instance in aws_instance.worker[*] : instance.private_ip]
}