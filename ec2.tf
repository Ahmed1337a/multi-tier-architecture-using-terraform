resource "aws_instance" "app" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = var.instance_type
  subnet_id     = var.private_subnets[count.index]
  vpc_security_group_ids = [var.app_sg_id]
  user_data     = var.user_data

  tags = {
    Name = "App-${count.index}"
  }
}
