# Data Directory

_This folder contains all business logic and data transformation rules, including source and target definitions, tests, and data analysis._

```yml
project-root    # The root directory
 - data         # This subfolder
   - analyses   # Reports, notebooks, and queries for data analysis
   - seeds      # Raw data files (CSVs) containing manual data inputs
   - taps       # Source definitions for the EL (Extract-Load) pipeline
   - tests/sql  # SQL tests which should always return 0 results
   - transforms # Data transformations written as SQL queries
```
