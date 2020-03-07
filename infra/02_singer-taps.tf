output "singer_summary" { value = module.singer_taps_on_aws.summary }
module "singer_taps_on_aws" {
  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  source        = "../../dataops-infra/catalog/aws/singer-taps"
  name_prefix   = local.name_prefix
  resource_tags = local.resource_tags
  environment   = module.env.environment

  # ADD OR MODIFY CONFIGURATION HERE:

  source_code_folder    = "../data/taps"
  source_code_s3_bucket = module.data_lake.s3_metadata_bucket
  scheduled_timezone    = "PST"
  scheduled_sync_times  = ["0600"]
  taps = [
    {
      id = "sample-tap"
      settings = {
        # How far back to backfill:
        start_date = "2020-02-28T00:00:00Z"
      }
      secrets = {
        # TODO: Map in your own secrets from local files:
        username = "../.secrets/aws-secrets-manager-secrets.yml:SAMPLE_TAP_username"
        password = "../.secrets/aws-secrets-manager-secrets.yml:SAMPLE_TAP_password"
      }
    }
  ]
  target = {
    # Output to S3 CSV by default:
    id = "s3-csv"
    settings = {
      # TODO: update S3 target path:
      s3_key_prefix = "data/raw/sample-tap/v1/"
      s3_bucket     = module.data_lake.s3_data_bucket
    }
    secrets = {
      # TODO: Make sure you have provided secrets into the secrets file here:
      aws_access_key_id     = "../.secrets/aws-secrets-manager-secrets.yml:S3_CSV_aws_access_key_id"
      aws_secret_access_key = "../.secrets/aws-secrets-manager-secrets.yml:S3_CSV_aws_secret_access_key"
    }
  }
}