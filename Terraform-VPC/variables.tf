variable "dev_vpc_cidr" {
  description = "dev vpc cidr range"
  type        = string
}

variable "prod_vpc_cidr" {
  description = "prod vpc cidr range"
  type        = string
}

variable "public_subnets_cidr" {
  description = "public subnets cidr range"
  type        = list(string)
}
variable "inbount_port_numbers" {
  description = "inbound rules allow connection to instance"
  type        = list(number)
}
