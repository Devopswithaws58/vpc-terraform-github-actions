variable "dev_SG_id" {
  description = "sg for alb"
  type        = string
}

variable "dev_public_subnets_ids" {
  description = "subnet ids for ALB"
  type        = list(string)
}

variable "project_name" {
  description = "my project name"
  type        = string
  default     = "LWP-LABS"
}

variable "dev_vpc_id" {
  description = "vpc id for TG"
  type        = string
}

variable "docker_instances_ids" {
  description = "instance ids for target group"
  type        = list(string)
}