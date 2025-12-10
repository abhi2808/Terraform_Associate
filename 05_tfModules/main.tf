provider "aws" {
    region = "ap-south-1"
    profile = "abhinav"
}

module "server" {
    source = "./modules/server"
    ami = "ami-02b8269d5e85954ef" # enter valid 
    subnet_id = "subnet-06319e2fe4f2dea7d" # enter valid
    security_groups = [
        "sg-0e1876a807a7a9d88"
    ]
}// can create another using same commands diff name

output "size" {
    value = module.server.size  # cant utilize directly unless a child module explicitely provides us this as output
}


# module from registry
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}