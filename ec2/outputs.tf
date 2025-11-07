output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.example.id
}

output "public_ip" {
  description = "The EC2 instance public IP"
  value       = aws_instance.example.public_ip
}

output "private_ip" {
  description = "The EC2 instance private IP"
  value       = aws_instance.example.private_ip
}

output "key_name" {
  description = "The EC2 key pair name"
  value       = aws_key_pair.deployer_key.key_name
}
