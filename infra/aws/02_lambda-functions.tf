module "lambda_functions_on_aws" {
  source                = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/lambda-functions-on-aws?ref=master"
  name_prefix           = local.name_prefix
  aws_region            = local.aws_region

  # CONFIGURE HERE:

  num_linux_instances   = 1
  num_windows_instances = 0

  /*
  # OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  admin_cidr            = []
  default_cidr          = ["0.0.0.0/0"]

  */
}

output "summmary" { value = module.tableau_server_on_aws.summary }
