locals{
    f="abhinav"
}
locals{
    l="bisht"
}

locals{  # can group if whenn need to add multiple together(local.name), eg in tags
    name={
        first=local.f
        last=local.l
    }
}

variable "iptest" {
    type = string
    default = "abhinav"

    validation {
        condition = contains(["abhinav", "2-abhinav", "3-abhinav", "4-abhinav", "5-abhinav", "6-abhinav"], lower(var.iptest))
        error_message = "not abhinav"
    }

    validation {
        condition = lower(var.iptest) == var.iptest
        error_message = "not in lower cases"
    }
}

variable "dns" {
    type = string
    default = "8.8.8.8"
}

# export TF_VAR_iptest="2-abhinav" setting env var
# iptest="3-abhinav" in terraform.tfvars 
# iptest="5-abhinav" in terraform.auto.tfvars
# terraform apply -var iptest="4-abhinav"
# ^ each override the previous

output "optest" {
    value = var.iptest
}

output "dns" {
    value = var.dns
}