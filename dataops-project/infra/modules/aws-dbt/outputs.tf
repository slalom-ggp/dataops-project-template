output "docker_repo_image_url" { value = module.ecr_docker_registry.ecr_image_url }
output "ecs_logging_url" { value = module.aws_ecs.ecs_logging_url }
output "ecs_cluster_name" { value = module.aws_ecs.ecs_cluster_name }
