module "singer_taps_on_aws" {

  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  # TODO: Revert to stable source
  # source        = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/singer-taps?ref=master"
  source          = "../../dataops-infra/catalog/aws/singer-taps"
  name_prefix     = local.name_prefix
  resource_tags   = local.resource_tags
  environment     = module.env.environment

  # ADD OR MODIFY CONFIGURATION HERE:

  container_image         = "slalomggp/dataops:test-project-latest-dev"
  tap_plan_command        = "./data/taps/plan.sh"
  tap_sync_command        = "./data/taps/sync.sh"
  scheduled_sync_interval = "4 hours"
  environment_vars        = {
    PARDOT_USERNAME_KEY_ID = module.secrets.secrets_ids["APPLICATION_A"]
  }
  environment_secrets     = {
    PARDOT_USERNAME = module.secrets.secrets_ids["APPLICATION_A"]
  }

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  docker_registry_url        = ""
  docker_user                = ""
  docker_password            = ""
  scheduled_sync_interval    = "1 minute"
  scheduled_sync_times       = ["0300", "1200", "1800"]
  scheduled_timezone         = "PST"

  */
}

# BOILERPLATE OUTPUT (NO NEED TO CHANGE):
output "singer_summary" { value = module.singer_taps_on_aws.summary }
