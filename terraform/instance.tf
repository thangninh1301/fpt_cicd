resource "aws_instance" "public_instance" {
  count           = 3
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet[count.index % length(aws_subnet.public_subnet)].id
  security_groups = [aws_security_group.public.id]
  key_name        = var.key_name
  tags            = {
    Name = var.instance_name[count.index]
  }
}
resource "aws_instance" "private_instance" {
  count           = 1
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet[count.index % length(aws_subnet.private_subnet)].id
  security_groups = [aws_security_group.private.id]
  key_name        = var.key_name
  tags            = {
    Name = "private instance"
  }
}

