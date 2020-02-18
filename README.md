# Welcome to the _`{your-project-name-here}`_ repo

Template project for new DataOps repositories.

What this template does:

1. extract-load data into a data lake (S3 or Azure) using the tap/target paradigm from Singer
2. transform data using SQL - running by default on DBT and Spark, but also compatible with Snowflake, Redshift and other database providers
3. host ad-hoc JDBC SQL queries via the included Thrift server
4. reduce TCO with little or no always-on compute resources
5. promote CI/CD best practices with built-in patterns for github CI (w/ addl. CI platforms to come)

In short: a sample project for enterprise-grade ELT that's containerized, cloud-based, serverless, scalable, open source, and DevOps-friendly. Storage is persisted in in the data lake (S3 supported now and Azure coming soon) and compute is dockerized to run on ECS Fargate and/or Kubernetes.

## What each folder in this repo does

1. `data` - This in the most important folder in the repo. It contains all business logic, source mappings, data transformations, and data analyses.
   1. `data/taps` - Logic to extract-load data into a data lake (S3 or Azure) using the tap/target paradigm from [Singer](https://www.singer.io).
   2. `data/transforms` - Transform data using SQL, using [DBT](www.getdbt.com) to orchestrate the transforms.
   3. `data/analyses` - Any queries, reports, notebooks, or analysis files which may be related to the project but not part of any automated execution schedule. These files are checked by the CI/CD pipeline to detect and prevent accidental breakages.
2. `tests` - Contains SQL queries ("tests") used to validate the integrity of output data.
3. `infra` - Terraform scripts which manage the cloud infrastructure needed by the project. Except when making changes to infrastructure, you can safely ignore this folder.
4. `.secrets` - This is a special folder whose contents are not committed to git. You can safely store secrets into this folder as needed for authentication and encryption.
5. `logs` - This is the default location for log output.
6. `tools` - Special tools or scripts that assist in automating certain processes. You can safely ignore this folder for now.
7. Other folders that begin with a dot (`.`). These folders store temporary files or tool-specific configs which can generally be ignored.

## Quick Intro to Gradle

* [Gradle Build Tool](www.gradle.org) is a simple and extensible build automation tool which streamlines repetitive tasks.
* The files called `gradlew` (for Max/Linux) and `gradlew.bat` (for Windows) are the gradle wrappers. They take care of automatically installing gradle (if needed) and then they run whatever task you request (examples below).
* The file called `build.gradle` is our build automation file, and contains logic needed to run all of the build tasks.

* _NOTE: Aside from a few basic concepts, it is not necessary to learn gradle in order to take advantage of this automation._

## Using Gradle to Run Tasks

| Command     | Description |
| ----------- | ------------ |
| `gradle tapPlan` | Connected to source data using the appropriate taps, and updates the extract plan |
| `gradle tapSync` | Runs the extract steps |
| `gradle dbtSeed` | Runs the DBT 'seed' task |

## Combining Gradle Tasks

You can combine multiple Gradle tasks simply by separating them with spaces:

```bash
gradlew tapPlan tapSync dbtSeed dbtRun
```

Gradle automatically manages the process to make sure each task is run in the correct order. Task dependencies are defined within the `build.gradle` file.
