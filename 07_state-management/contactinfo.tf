variable "name" {
    type = "string"
    sensitive = true
    default = "abhinav"
}

output "name" {
    sensitive = true # need to add this to work
    value = var.name
}