# Backend config for terraform state.
#
# Update this file (uncommenting the below) to set the S3 storage location for the terraform
# state file. Otherwise, Terraform will automatically create a state file locally (not recommended
# for teams where multiple users may need to need to modify the infrastructure ).

# terraform {
#   backend "s3" {
#     bucket = "my-bucket-name"
#     key    = "infra/state"
#     region = "us-east-2"
#   }
# }
