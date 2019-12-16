FROM slalomggp/dataops:latest-dev

# # Set version filters, e.g. '>=0.1.0', '>=1.0,<=2.0'
# # Optionally, use the text 'skip' to skip or '' to use latest version
# ARG dbt_version_filter=''
# ARG meltano_version_filter='skip'

ENV PROJECT_DIR /projects/my-project
COPY . $PROJECT_DIR
WORKDIR $PROJECT_DIR

RUN ls -la
# RUN dbt compile --profiles-dir etc/dbt-config

CMD ["spark", "start_spark", "--with_jupyter"]
