FROM slalomggp/dataops:latest-dev

ENV PROJECT_DIR /projects/my-project
COPY . $PROJECT_DIR
WORKDIR $PROJECT_DIR

RUN ls -la
RUN $DBTSPARK --version && \
    $DBTSPARK compile --profiles-dir etc/dbt-config
