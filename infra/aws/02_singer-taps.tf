module "singer_taps_on_aws" {

  # BOILERPLATE HEADER (NO NEED TO CHANGE):

  source        = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/singer-taps?ref=master"
  name_prefix   = local.name_prefix
  resource_tags = local.project_tags
  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.private_subnets

  # ADD OR MODIFY CONFIGURATION HERE:

  container_image      = file("../../Dockerimage")
  tap_plan_command     = "./gradlew tapPlan"
  tap_sync_command     = "./gradlew tapPlan tapSync"
  scheduled_timezone   = "PST"
  scheduled_sync_times = ["0300"]
  environment_vars     = {}
  environment_secrets  = {}

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  docker_registry_url     = ""
  docker_user             = ""
  docker_password         = ""
  scheduled_sync_interval = "1 minute"
  scheduled_sync_interval = "4 hours"

  */
}

# BOILERPLATE OUTPUT (NO NEED TO CHANGE):
output "singer_summary" { value = module.singer_taps_on_aws.summary }
