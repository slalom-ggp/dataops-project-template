FROM python:3.7

ARG MELTANO_MIN_VERSION=1.16

ENV PROJECTS /projects

RUN mkdir -p /projects && \
    mkdir -p /.source && \
    mkdir -p /.c

WORKDIR /projects

ENV VENV /virtualenvs/meltano

RUN mkdir -p /virtualenvs && \
    python -m venv $VENV && \
    $VENV/bin/pip3 install 'meltano>=${MELTANO_MIN_VERSION}' && \
    $VENV/bin/meltano --version

ENV PROJECT_NAME demo-project
ENV PROJECT_DIR /projects/$PROJECT_NAME

RUN $VENV/bin/meltano --version && \
    $VENV/bin/meltano init $PROJECT_NAME

WORKDIR $PROJECT_DIR

# SHELL ["/bin/bash", "-c"]

RUN $VENV/bin/meltano upgrade && \
    $VENV/bin/meltano discover all

# Configure DBT for Spark

RUN apt-get update && apt-get install -y \
    g++ \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    python-dev

ENV DBTVENV /virtualenvs/dbt

RUN python3 -m venv $DBTVENV && \
    $DBTVENV/bin/pip3 install dbt && \
    $DBTVENV/bin/dbt --version
RUN $DBTVENV/bin/pip3 install pyhive[hive] dbt-spark

# Capture command history, allows recall if used with `-v ./.devcontainer/.bashhist:/root/commandhistory`
RUN mkdir -p /root/commandhistory && \
    echo "export PROMPT_COMMAND='history -a'" >> "/root/.bashrc" && \
    echo "export HISTFILE=/root/commandhistory/.bash_history" >> "/root/.bashrc"

RUN echo '#!/bin/bash \n\
echo "Starting boostrap.sh script..." \n\
source /virtualenvs/meltano/bin/activate \n\
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
