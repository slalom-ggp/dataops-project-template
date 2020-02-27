module "secrets" {
  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  # TODO: Revert to stable source
  # source        = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/singer-taps?ref=master"
  source                   = "../../dataops-infra/components/aws/secrets-manager"
  name_prefix              = local.name_prefix
  resource_tags            = local.resource_tags
  # environment              = module.env.environment
  secrets_source_file_path = local.secrets_file_path

  # ADD OR MODIFY CONFIGURATION HERE:

  secrets_names = [
    "APPLICATION_A",
    "APPLICATION_B",
    "SIMPLE_SECRET"
  ]

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  kms_key_id = null # when null, use the default KMS key

  */
}

output "secrets_summary" {
  value = module.secrets.summary
}