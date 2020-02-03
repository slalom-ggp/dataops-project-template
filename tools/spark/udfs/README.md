# Spark User Defined Functions (UDFs)

This directory stores any python UDFs needed by the Spark cluster. Functions should be declared in python files and referenced in a file called `udf_index.yml`.

## Example UDF Script

`dates_udf.py`

```python
import datetime

def month_index(date: datetime.datetime):
    return date.year() * 12 + date.month()
```

## Example UDF Index

`udf_index.yml`:

```yaml
udfs:
  month_index: "dates_udf.py:month_index()"
```
