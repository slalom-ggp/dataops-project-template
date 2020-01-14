# dataops-project-template

Template project for new dataops repos.

What this template does:

1. extract-load data into a data lake (S3 or Azure) using the tap/target paradigm from Singer
2. transform data using SQL (running by default on DBT and Spark)
3. maintain virtual data lake tables using SparkSQL and Delta lake (for ACID transactions) 
4. host ad-hoc JDBC SQL queries via the included Thrift server
5. reduce TCO with little or no always-on compute resources
6. promote CI/CD best practices with built-in patterns for github CI (w/ addl. CI platforms to come)

In short, a sample project for enterprise-grade ELT that's containerized, cloud-based, serverless, scalable, open source, and DevOps-friendly. Storage is persisted in in the data lake (S3 or Azure) and compute is dockerized to run on ECS Fargate and/or Kubernetes.
