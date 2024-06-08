variable "dev_vpc_id" {
  description = " vpc id for security group "
  type        = string
}
variable "project_name" {
  description = "my project name"
  type        = string
  default     = "LWP-LABS"
}

variable "inbount_port_numbers" {
  description = "inbound rules allow connection to instance"
  type        = list(number)
}