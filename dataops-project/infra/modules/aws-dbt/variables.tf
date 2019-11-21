variable "name_prefix" { default = "PTB-" }
variable "region" { default = "us-east-2" }
variable "prefer_fargate" { default = true }
variable "fargate_container_num_cores" {
  description = "The number of vCPUs. (e.g. 0.25, 0.5, 1, 2, 4) (https://aws.amazon.com/fargate/pricing/)"
  default     = 4
}
variable "fargate_container_ram_gb" {
  description = "Container RAM, in 1 GB incrememts. (max 30GB if 4 vCPUs) (https://aws.amazon.com/fargate/pricing/)"
  default     = 30
}
variable "ec2_instance_type" {
  default = "r5a.8xlarge" # https://aws.amazon.com/ec2/pricing/on-demand/
}
variable "ec2_container_num_cores" {
  description = "The number of vCPUs. (https://aws.amazon.com/fargate/pricing/)"
  default     = 10
}
variable "ec2_container_ram_gb" {
  description = "Container RAM, in 1 GB incrememts. (https://aws.amazon.com/fargate/pricing/)"
  default     = 60
}
