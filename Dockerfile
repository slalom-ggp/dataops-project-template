FROM slalomggp/dataops:latest-dev

ENV PROJECT_DIR /projects/my-project
COPY . $PROJECT_DIR
WORKDIR $PROJECT_DIR

RUN ls -la
RUN dbt-spark --version
# RUN dbt-spark compile --profiles-dir etc/dbt-config

# Install tap-salesforce
RUN python3 -m venv tap-salesforce
RUN tap-salesforce/bin/pip install git+https://gitlab.com/meltano/tap-salesforce.git@master
RUN ln -s /projects/my-project/tap-salesforce/bin/tap-salesforce /usr/bin/tap-salesforce

# Add tap-salesforce config template
RUN mkdir -p /projects/my-project/.secrets
RUN echo -e "{\n\t\"api_type\": \"BULK\",\n\t\"select_fields_by_default\": true,\n\t\"start_date\": \"2017-11-02T00:00:00Z\",\n\t\"username\": \"Account Email\",\n\t\"password\": \"Account Password\",\n\t\"security_token\": \"Security Token\"\n}" > /projects/my-project/.secrets/tap-salesforce-config.json

# Install target-s3
RUN python3 -m venv /venv/target-csv && \
    /venv/target-csv/bin/pip install target-csv && \
    ln -s /venv/target-csv/bin/target-csv /usr/bin/target-csv

# Install target-s3-csv
RUN python3 -m venv /venv/target-s3-csv && \
    /venv/target-csv/bin/pip install pipelinewise-target-s3-csv && \
    ln -s /venv/target-csv/bin/target-s3-csv /usr/bin/target-s3-csv
