module "azure_functions" {
  source                = "git::https://github.com/slalom-ggp/dataops-infra.git//catalog/azure-functions?ref=master"
  name_prefix           = local.name_prefix
  aws_region            = local.aws_region

  # CONFIGURE HERE:


  /*
  # OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  admin_cidr            = []
  default_cidr          = ["0.0.0.0/0"]

  */
}

output "summmary" { value = module.tableau_server_on_aws.summary }
