data "aws_caller_identity" "current" {}
data "local_file" "dbt_config_yml" { filename = "../dbt_project.yml" }

locals {
  dbt_config        = yamldecode(data.local_file.dbt_config_yml.content)
  aws_account       = data.aws_caller_identity.current.account_id
  project_shortname = local.config["shortname"]
  project_name      = local.config["name"]
  aws_region        = local.config["region"]
  aws_secret_name_prefix = lookup(
    local.config,
    "aws_secret_name_prefix",
    "${upper(local.config["project_shortname"])}_SECRETS"
  )
}

provider "aws" {
  region  = local.aws_region
  version = "~> 2.10"
}

module "dbt_infra" {
  source            = "./modules/aws-dbt"  # OR for Azure: "./modules/azure-dbt"
  repository_name   = "${var.name_prefix}Docker-Registry"
  image_name        = lower(local.project_shortname)
  project_shortname = local.project_shortname
}
