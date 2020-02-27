module "data_lake_on_aws" {

  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  # TODO: Revert to stable source
  # source        = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/aws/singer-taps?ref=master"
  source      = "../../dataops-infra/catalog/aws/data-lake"
  name_prefix = local.name_prefix
  environment = module.env.environment

  # CONFIGURE HERE:


  /*
  # OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  vpc_id               = module.env.vpc_id
  public_subnets       = module.env.public_subnets
  private_subnets      = module.env.private_subnets
  admin_cidr           = []
  default_cidr         = ["0.0.0.0/0"]
  lambda_python_source = "${path.module}/python/fn_lambda_logger"
  s3_triggers = {
    "fn_lambda_logger" = {
      triggering_path     = "uploads/*"
      function_handler    = "main.lambda_handler"
      environment_vars    = {}
      environment_secrets = {}
    }
  }

  */
}
