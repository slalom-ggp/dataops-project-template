module "ecr_docker_registry" {
  source            = "./modules/aws-ecr"
  repository_name   = "${local.name_prefix}Docker-Registry"
  image_name        = lower(local.project_shortname)
  project_shortname = local.project_shortname
}

module "aws_ecs" {
  source                = "./modules/aws-ecs"
  name_prefix           = local.name_prefix
  region                = local.aws_region
  vpc_id                = module.aws_vpc.vpc_id
  subnet_ids            = module.aws_vpc.private_subnet_ids
  ecs_security_group    = module.aws_vpc.ecs_security_group
  aws_secrets_manager   = local.aws_secrets_manager
  container_name        = "${local.name_prefix}Container"
  container_image       = "${module.ecr_docker_registry.ecr_image_url}:latest-dev"
  container_entrypoint  = "/home/jovyan/bin/bootstrap_ecs.sh"
  container_run_command = "python3 bin/run.py"

  # FARGATE: No always-on cost, no EC2 instances to manage, max 30GB RAM
  fargate_container_num_cores = local.ecs_fargate_container_num_cores
  fargate_container_ram_gb    = local.ecs_fargate_container_ram_gb

  # STANDARD EC2: Faster execution time, any instance type, must manage EC2 intances, 
  #               significant EC2 costs if not turned off
  ec2_instance_type       = local.ecs_ec2_instance_type
  ec2_container_num_cores = local.ecs_ec2_container_num_cores
  ec2_container_ram_gb    = local.ecs_ec2_container_ram_gb
  min_ec2_instances       = local.ecs_ec2_instances
  max_ec2_instances       = local.ecs_ec2_instances + 1
}
