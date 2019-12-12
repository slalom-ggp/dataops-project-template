FROM python:3.7

# Set version filters, e.g. '>=0.1.0', '>=1.0,<=2.0'
# Optionally, use the text 'skip' to skip or '' to use latest version
ARG dbt_version_filter=''
ARG meltano_version_filter='skip'

RUN mkdir -p /projects && \
    mkdir -p /.c && \
    mkdir -p /venv
WORKDIR /projects

RUN apt-get update && apt-get install -y -q \
    build-essential \
    git \
    g++ \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libpq-dev \
    python-dev \
    python3-dev \
    python3-pip \
    python3-venv

ENV MELTANOENV /venv/meltano
ENV MELTANO /venv/meltano/bin/meltano
RUN if [ "$meltano_version_filter" = "skip" ]; then exit 0; fi && \
    python -m venv $MELTANOENV && \
    $MELTANOENV/bin/pip3 install "meltano$meltano_version_filter" && \
    $MELTANO --version
RUN if [ "$meltano_version_filter" = "skip" ]; then exit 0; fi && \
    $MELTANO --version && \
    $MELTANO init sample-meltano-project && \
    cd sample-meltano-project && \
    $MELTANO upgrade && \
    $MELTANO discover all && \
    $MELTANO --version

# Configure DBT
ENV DBTENV /venv/dbt
ENV DBT /venv/dbt/bin/dbt
RUN python3 -m venv $DBTENV && \
    $DBTENV/bin/pip3 install "dbt$dbt_version_filter" && \
    $DBT --version
RUN $DBT init sample-dbt-project && \
    cd sample-dbt-project && \
    $DBT --version

# Configure dbt-spark
ENV DBTSPARKENV /venv/dbt-spark
ENV DBTSPARK /venv/dbt-spark/bin/dbt
RUN python3 -m venv $DBTSPARKENV && \
    $DBTSPARKENV/bin/pip3 install pyhive[hive] dbt-spark && \
    $DBTSPARK --version
RUN $DBTSPARK init sample-dbtspark-project && \
    cd sample-dbtspark-project && \
    $DBTSPARK --version

# Configure pipelinewise
ENV PIPELINEWISE_HOME /venv/pipelinewise
ENV PIPELINEWISEENV /venv/pipelinewise/.virtualenvs/pipelinewise
ENV PIPELINEWISE $PIPELINEWISEENV/bin/pipelinewise
RUN cd /venv && \
    git clone https://github.com/transferwise/pipelinewise.git && \
    cd pipelinewise && ./install.sh --acceptlicenses
RUN $PIPELINEWISE init --dir sample_pipelinewise_project --name sample_pipelinewise_project && \
    $PIPELINEWISE import --dir sample_pipelinewise_project

# Capture command history, allows recall if used with `-v ./.devcontainer/.bashhist:/root/.bash_history`
RUN mkdir -p /root/.bash_history && \
    echo "export PROMPT_COMMAND='history -a'" >> "/root/.bashrc" && \
    echo "export HISTFILE=/root/.bash_history/.bash_history" >> "/root/.bashrc"

RUN echo '#!/bin/bash \n\
echo "Starting boostrap.sh script..." \n\
source /venv/meltano/bin/activate \n\
meltano --version || true \n\
if [[ ! -d ".meltano" ]]; then \n\
    LOG_FILE=.meltano-install-log.txt \n\
    echo "Folder ''.meltano'' is missing. Beginning Meltano install as background process on `date`..." | tee -a $LOG_FILE \n\
    echo "Logging install progress to: $LOG_FILE" \n\
    echo "View progress with ''jobs -l'' or ''tail -f $LOG_FILE''" \n\
    nohup sh -c ''meltano upgrade && echo -e "Install complete on `date`\n\n"'' | tee -a $LOG_FILE & \n\
fi \n\
meltano --version || true \n\
date \n\
echo "Running meltano with provided command args: $@..." \n\
$@ \n\
' > /projects/bootstrap.sh && \
chmod 777 /projects/bootstrap.sh

# ENTRYPOINT ["$VENV/bin/meltano"]
ENTRYPOINT ["/projects/bootstrap.sh"]
CMD ["meltano", "ui"]
