import datetime

from pyspark.sql.functions import udf
from pyspark.sql import types


@udf("long")
def times_five(value):
    return value * 5

@udf("long")
def times_six(value):
    return value * 6
