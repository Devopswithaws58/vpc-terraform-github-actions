resource "aws_s3_bucket" "dev_s3_bucket" {
  bucket = lower("${var.project_name}-${terraform.workspace}-remote-backend")
  tags = {
    "Name" = lower("${var.project_name}-${terraform.workspace}-remote-backend")
  }

}