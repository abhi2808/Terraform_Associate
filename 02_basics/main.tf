provider "aws"{
    region="ap-south-1"
    profile = "abhinav"
}

provider "random"{
}

locals{
    team="api_mgmt_dev"
    server_name="ec2-${var.environment}-api"
}

data "aws_region" "current"{  //exports name, endpoint and description
}

data "aws_availability_zones" "available"{}  //avability zones in a region

data "aws_ami" "ubuntu"{
    most_recent = true
    filter{
        name="name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    filter{
        name="virtualization-type"
        values=["hvm"]
    }
    owners = ["099720109477"] //canonical
}

resource "aws_vpc" "tera-vpc" {
    cidr_block = "172.31.0.0/18"
    tags={
        Name="tera-VPC"
        Environment="Demo"
        Region="${data.aws_region.current.name}"
    }
}

resource "aws_instance" "prac-instance" {
    ami= "${data.aws_ami.ubuntu.id}"
    instance_type="t2.micro"
    subnet_id="subnet-06319e2fe4f2dea7d"
    vpc_security_group_ids=["sg-0720edc164bb74b9d"]
    tags = {
        "Name"="${local.server_name}"
        "Terraform"="true"
        "Team"="${local.team}"
    }
}

resource "aws_s3_bucket" "my-new-bucket" {
    bucket="abhinav-new-bucket-${random_id.randomness.hex}"
    tags={
        Name="23456789-abhinav-new-bucket"
        Description="My unique bucket"
    }
}

resource "aws_s3_bucket_acl" "my_acl" {
    bucket = aws_s3_bucket.my-new-bucket.id
    acl="private"
}

resource "random_id" "randomness"{
    byte_length = 16
}

resource "aws_subnet" "variable-subnet"{
    vpc_id="vpc-04e7ab6d8e776e61f"
    cidr_block=var.var-cidr//"172.31.0.0/24"
    availability_zone = "ap-south-1a" //now can do: tolist(data.availability_zones.available.names)[each.value], will make on in each az
    map_public_ip_on_launch = var.var-sub-autoip //true
    tags={
        Name="variable-sub"
        Terraform="true"
    }
}