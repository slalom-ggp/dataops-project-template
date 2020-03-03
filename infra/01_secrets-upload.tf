output "secrets_summary" { value = module.secrets.summary }
module "secrets" {
  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  source        = "../../dataops-infra/components/aws/secrets-manager"
  name_prefix   = "${local.name_prefix}"
  resource_tags = local.resource_tags
  # TODO: Point to a text file which contains your credentials in JSON or YAML format:
  secrets_file  = "../.secrets/aws-secrets-manager-secrets.yml"
  # secrets_file  = "../data/taps/.secrets/tap-pardot-config.json"

  # ADD OR MODIFY CONFIGURATION HERE:

  secrets_file_map = {
    # TODO: Update the secrets here to match your data sources
    # Example:
    # AWS Secrets Name = "name_in_file"
    SAMPLE_TAP_username = "SAMPLE_username",
    SAMPLE_TAP_password = "SAMPLE_password",
    SAMPLE_TAP_user_key = "SAMPLE_user_key",

    S3_CSV_aws_access_key_id     = "S3_CSV_aws_access_key_id",
    S3_CSV_aws_secret_access_key = "S3_CSV_aws_secret_access_key",
  }

  /* OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  kms_key_id = null # when null, use the default KMS key

  */
}
