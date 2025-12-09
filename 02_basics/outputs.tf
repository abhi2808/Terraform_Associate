output "hello-world" {
  description = "..."
  value       = "Hello, World!"
}

output "vpc_id" {
  description = "...1"
  value       = aws_vpc.tera-vpc.id
}