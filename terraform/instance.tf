resource "aws_instance" "public_production" {
  ami = var.image_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet[0].id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "public node_1"
  }
}
#resource "aws_instance" "private_node_1" {
#  ami = var.image_id
#  instance_type = var.instance_type
#  subnet_id = aws_subnet.private_subnet[count.index]
#  security_groups = [aws_security_group.private.id]
#  key_name = var.key_name
#  tags = {
#    Name = "node_2"
#  }
#}

