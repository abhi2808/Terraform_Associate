provider "aws" {
    region = "ap-south-1"
    profile = "abhinav"
}

resource "aws_vpc" "state-vpc" {
    cidr_block = "172.31.0.0/18"
    tags = {
      Name="state-vpc"
      Region="ap-south-1"
    }
}