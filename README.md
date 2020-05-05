# Welcome to the _`{your-project-name-here}`_ repo

Template project for new DataOps repositories.

## How this repo is organized

_The structure below is designed to minimize clutter and create separation between the various layers of the project - while still ensuring common resources are easy-to-locate._

1. `data` - This is, generally speaking, the most important folder in the repo. It contains all business logic, source mappings, data transformations, and data analyses. Generally speaking, project-specific source code should live here, but engine code should not.
   1. `data/taps` - Logic to extract-load data into a data lake (S3 or Azure) using the tap/target paradigm from [Singer](https://www.singer.io).
   2. `data/transforms` - Transform data using SQL, using [DBT](www.getdbt.com) to orchestrate the transforms.
   3. `data/analyses` - Any queries, reports, notebooks, or analysis files which may be related to the project but not part of any automated execution schedule. Storing files here allows them to be checked by the CI/CD pipeline to automatically detect any accidental breakages.
2. `docs` - A place to store documentation for use by other developers or consumers of the repo.
3. `infra` - Terraform scripts which manage the cloud infrastructure needed by the project. Except when making changes to infrastructure, you can safely ignore this folder.
4. `logs` - This is the default location for _local_ log output.
5. `tests` - Contains SQL queries ("tests") used to validate the integrity of output data.
6. `tools` - Special tools or scripts that assist in automating certain processes.
7. `"Dot" Folders`
   1. `.secrets` - This is a special folder whose contents are not committed to git. You can safely store secrets into this folder if needed for a project. _(DO NOT store secrets anywhere in the repo besides the `.secrets` folder.)_
   2. Other folders that begin with a dot ("."). These folders store temporary files or tool-specific configs (`.gradle`, `.git`, `.github`, `.vscode`, etc.)

## Quick Intro to Gradle

the [Gradle](www.gradle.org) build tool is a simple and extensible build automation tool, which streamlines repetitive tasks. For more info on how to use Gradle with this project, see the Gradle Overview and How-To at [tools/gradle/README.md](tools/gradle/README.md).
