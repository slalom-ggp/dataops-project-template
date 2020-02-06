module "dbt_on_aws" {

  # BOILERPLATE HEADER (NO NEED TO CHANGE):

  source          = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/dbt?ref=master"
  name_prefix     = local.name_prefix
  resource_tags   = local.project_tags
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets

  # ADD OR MODIFY CONFIGURATION HERE:

  container_image            = file("../../Dockerimage")
  dbt_run_command            = "./gradlew runAll"
  scheduled_refresh_times    = ["0500", "1700"]
  environment_vars = {
    # "PROJECT_GIT_URL" = "git+https://github.com/slalom-ggp/dataops-infra.git"
    "WITH_SPARK"      = "true"
  }

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  docker_registry_url        = ""
  docker_user                = ""
  docker_password            = ""
  scheduled_refresh_interval = "1 minute"

  */
}

# BOILERPLATE OUTPUT (NO NEED TO CHANGE):
output "dbt_summary" { value = module.dbt_on_aws.summary }
