
variable "project_name" {
  description = "my project name"
  type        = string
  default     = "LWP-LABS"
}

variable "dev_SG_id" {
  description = "security group id for ec2"
  type        = string
}

variable "dev_public_subnets_ids" {
  description = "subnets for SG"
  type        = list(string)
}