output "dev_vpc_id" {
  value = aws_vpc.dev_vpc.id
}
output "dev_public_subnets_ids" {
  value = aws_subnet.dev_public_subnets.*.id
}
