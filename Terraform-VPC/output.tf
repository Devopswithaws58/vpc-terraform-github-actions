output "dev_vpc_cidr" {
  value = var.dev_vpc_cidr
}

output "public_subnets_cidr" {
  value = var.public_subnets_cidr[*]
}