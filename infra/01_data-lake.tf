output "data_lake_summary" { value = module.data_lake.summary }
module "data_lake" {
  # BOILERPLATE HEADER (NO NEED TO CHANGE):
  source        = "git::https://github.com/slalom-ggp/dataops-infra//catalog/aws/data-lake?ref=main"
  name_prefix   = local.name_prefix
  environment   = module.env.environment
  resource_tags = local.resource_tags

  # For documentation and additional options, see:
  # https://infra.dataops.tk/catalog/aws/data-lake
}
