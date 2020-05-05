# Gradle Build Tool - Overview and How-To

* [Gradle Build Tool](www.gradle.org) is a simple and extensible build automation tool, which streamlines repetitive tasks.
* The files called `gradlew` (for Max/Linux) and `gradlew.bat` (for Windows) are the gradle wrappers. They take care of automatically installing gradle (if needed) and then they run whatever task you request (examples below).
* The file called `build.gradle` is our build automation file, and contains logic needed to run all of the build tasks.

* _NOTE: Aside from a few basic concepts, it is not necessary to learn gradle in order to take advantage of this automation._

## Using Gradle to Run Tasks

| Command          | Description                                                                       |
| ---------------- | --------------------------------------------------------------------------------- |
| `gradle tapPlan` | Connected to source data using the appropriate taps, and updates the extract plan |
| `gradle tapSync` | Runs the extract steps                                                            |
| `gradle dbtSeed` | Runs the DBT 'seed' task                                                          |

## Combining Gradle Tasks

You can combine multiple Gradle tasks simply by separating them with spaces:

```bash
gradlew tapPlan tapSync dbtSeed dbtRun
```

Gradle automatically manages the process to make sure each task is run in the correct order. Task dependencies are defined within the `build.gradle` file.
