module "data_late_on_aws" {
  source                = "../../catalog/data-lake-on-aws"
  name_prefix           = local.name_prefix
  aws_region            = local.aws_region

  # CONFIGURE HERE:


  /*
  # OPTIONALLY, COPY-PASTE ADDITIONAL SETTINGS FROM BELOW:

  admin_cidr            = []
  default_cidr          = ["0.0.0.0/0"]
  */
}
