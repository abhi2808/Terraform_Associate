terraform {
  required_version = "~> 1.13.1" // use >= or ~>(only ver after last . differs)
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    random = {
      source = "hashicorp/random"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}