ARG source_image=slalomggp/dataops:latest
FROM ${source_image}

ENV PROJECT_DIR /projects/my-project
COPY . $PROJECT_DIR
WORKDIR $PROJECT_DIR
RUN mkdir -p $PROJECT_DIR/.secrets

RUN ls -la
RUN dbt-spark --version

# Install custom UDFs into Spark:
ENV SPARK_UDF_MODULE ${PROJECT_DIR}/tools/spark/udfs
RUN python3 -m pip install -r $SPARK_UDF_MODULE/requirements.txt

# Test Compile:
# RUN dbt-spark compile --profiles-dir tools/dbt/config
