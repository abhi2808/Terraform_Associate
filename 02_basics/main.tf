provider "aws" {
  region  = "ap-south-1"
  profile = "abhinav"
}

provider "random" {
}

locals { // reusable values
  team        = "api_mgmt_dev"
  server_name = "ec2-${var.environment}-api"
}

data "aws_region" "current" { //exports name, endpoint and description
}

data "aws_availability_zones" "available" {} //avability zones in a region

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] //canonical
}

resource "aws_vpc" "tera-vpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name        = "tera-VPC"
    Environment = "Demo"
    Region      = "${data.aws_region.current.description}"
  }
}

# 1. Create an Internet Gateway
resource "aws_internet_gateway" "tera-igw" {
  vpc_id = aws_vpc.tera-vpc.id

  tags = {
    Name = "tera-IGW"
  }
}

# 2. Create a route table with route to IGW
resource "aws_route_table" "tera-rt" {
  vpc_id = aws_vpc.tera-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tera-igw.id
  }

  tags = {
    Name = "tera-public-RT"
  }
}

# 3. Associate the route table with your subnet
resource "aws_route_table_association" "tera-rta" {
  subnet_id      = aws_subnet.variable-subnet.id
  route_table_id = aws_route_table.tera-rt.id
}

resource "aws_s3_bucket" "my-new-bucket" {
  bucket = "abhinav-new-bucket-${random_id.randomness.hex}"
  tags = {
    Name        = "23456789-abhinav-new-bucket"
    Description = "My unique bucket"
  }
}

resource "aws_s3_bucket_acl" "my_acl" {
  bucket = aws_s3_bucket.my-new-bucket.id
  acl    = "private"
}

resource "random_id" "randomness" {
  byte_length = 16
}

resource "aws_subnet" "variable-subnet" {
  vpc_id                  = aws_vpc.tera-vpc.id
  cidr_block              = var.var-cidr       //"172.31.0.0/24"
  availability_zone       = "ap-south-1a"      //now can do: tolist(data.availability_zones.available.names)[each.value], will make on in each az
  map_public_ip_on_launch = var.var-sub-autoip //true
  tags = {
    Name      = "variable-sub"
    Terraform = "true"
  }
}

resource "tls_private_key" "generated" { //creates a key
  algorithm = "RSA"
}

resource "local_file" "key-pem" { //stores it in local file system
  content  = tls_private_key.generated.private_key_pem
  filename = "tls-ab-key.pem"
}

resource "aws_key_pair" "aws-kp" {
  key_name   = "my-aws-key"
  public_key = tls_private_key.generated.public_key_openssh
  lifecycle {
    ignore_changes = [key_name]
  }
}

resource "local_file" "key-pem-2" { //stores it in local file system
  content  = tls_private_key.generated.private_key_pem
  filename = "my-aws-key.pem"
}

resource "aws_security_group" "my-sg" {
  name        = "new-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.tera-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1 # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "prac-instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.variable-subnet.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws-kp.key_name
  tags = {
    "Name"      = "${local.server_name}"
    "Terraform" = "true"
    "Team"      = "${local.team}"
  }

  connection { # for the provisioner to connect to the instance
    user        = "ubuntu"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.key-pem-2.filename}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /tmp",
      "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
      "sudo sh /tmp/assets/setup-web.sh"
    ]
  }
}

//  comment
#   comment
/*
    comment
*/