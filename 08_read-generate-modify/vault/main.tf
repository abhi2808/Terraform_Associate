provider "vault" {
    address="http://127.0.0.1:8200"
    #token= "a valid token"  # mine runs on local host and is closed so cant hurt yet still
}  #dont do in actual production

data "vault_generic_secret" "example" {
    path="secret/app"
}

output "samp" {
    value = data.vault_generic_secret.example
    sensitive = true
}

variable "v1"{
    type=list(string)
    default=["a","b","c","d","e"]
}

variable "v2" {
    type=map(string)
    default = {
        a="apple"
        b="ball"
        c="cat"
    }
}

output "o1" {
    # value = var.v1[0]
    value = [for i in var.v1: i]
}

output "o2" {
    value = var.v2["a"]
}