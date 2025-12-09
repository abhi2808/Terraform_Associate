provider "aws" {
    region = "ap-south-1"
    profile = "abhinav"
}

/*
resource "aws_instance" "my-imported-instance-dev"{  #terraform import aws_instance.my-imported-instance (instance id) in cli

}
*/

resource "aws_s3_bucket" "my-bucket" {
    bucket = "abhi-bucket-nav"
    tags = {
    Name        = "23456789-abhinav-new-bucket"
    Description = "My unique bucket"
  } 
}