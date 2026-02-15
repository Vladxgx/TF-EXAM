resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu_2204.id #use latest aws ubuntu 22.04 AMI
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  tags = { Name = "${var.name_prefix}-web-server" }
}

#lookup for latest official official ubuntu AMI
data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
  