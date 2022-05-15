output "ec2-public" {
  value = {
    public_ip = [ for value in aws_instance.public_instance : [value.public_ip, value.tags] ]
  }
}
output "ec2-private" {
  value = {
    public_ip = [ for value in aws_instance.private_instance : value.private_ip ]
  }
}