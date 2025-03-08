output "kubernetes_public_address" {
  value = module.load_balancer.kubernetes_public_address
}

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "The ID of the created Subnet"
  value       = module.vpc.subnet_id
}


output "controller_ips" {
  description = "Private IPs of Kubernetes controllers"
  value       = [for instance in module.ec2.controller_instances : instance.private_ip]
}

output "worker_ips" {
  description = "Private IPs of Kubernetes worker nodes"
  value       = [for instance in module.ec2.worker_instances : instance.private_ip]
}

output "ssh_command_controllers" {
  description = "SSH commands to connect to Kubernetes controllers"
  value       = [for ip in module.ec2.controller_ips : "ssh -i ~/.ssh/kubernetes ubuntu@${ip}"]
}

output "ssh_command_workers" {
  description = "SSH commands to connect to Kubernetes workers"
  value       = [for ip in module.ec2.worker_ips : "ssh -i ~/.ssh/kubernetes ubuntu@${ip}"]
}
