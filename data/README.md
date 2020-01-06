# Data Directory

_This folder contains all business logic and data transformation rules, including source and target definitions, tests, and data analysis._

```yml
project-root    # The root directory
 - data         # This subfolder
   - analysis   # Analyses which run on top of the data model
   - seeds      # Input files (CSVs) containing manual data mappings
   - taps       # Source definitions for the extract/load pipeline
   - tests/sql  # SQL tests which should always return 0 results
   - transforms # Data transformations written in SQL
```
