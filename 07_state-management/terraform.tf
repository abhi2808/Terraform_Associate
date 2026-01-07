terraform {
    required_providers {
        aws=">6.0.0"
    }
    
    /*
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "abhinavorg"
        workspaces {
            name="my-aws-app"
        }
    }
    */

    # access and secret key pushed using env vars
    # supports versioning using s3 bucket versioning
    # can encrypt using s3 bucket encryption policy
    
    
    backend "s3" { 
        bucket = "new-b-abhi" # first create
        key="prod/aws_infra"
        region = "ap-south-1"
        profile = "abhinav"
        dynamodb_table = "tf-lock"
        encrypt = true
    }
    
    
    /**
    backend "local" {
        path = "./terraform.tfstate"
    }
    **/
}