FROM python:3.7

ENV PROJECTS /projects

RUN mkdir -p /projects && \
    mkdir -p /.source && \
    mkdir -p /.c

WORKDIR /projects

ENV VENV /virtualenvs/meltano

RUN mkdir -p /virtualenvs && \
    python -m venv $VENV && \
    $VENV/bin/pip3 install meltano && \
    $VENV/bin/meltano --version

ENV PROJECT_NAME demo-project
ENV PROJECT_DIR /projects/$PROJECT_NAME

RUN $VENV/bin/meltano --version && \
    $VENV/bin/meltano init $PROJECT_NAME

WORKDIR $PROJECT_DIR

# SHELL ["/bin/bash", "-c"]

RUN $VENV/bin/meltano upgrade && \
    $VENV/bin/meltano discover all

# Capture command history, allows recall if used with `-v ./.devcontainer/.bashhist:/root/commandhistory`
RUN mkdir -p /root/commandhistory && \
    echo "export PROMPT_COMMAND='history -a'" >> "/root/.bashrc" && \
    echo "export HISTFILE=/root/commandhistory/.bash_history" >> "/root/.bashrc"

RUN echo '#!/bin/bash \n\
echo "Starting boostrap.sh script..." \n\
source /virtualenvs/meltano/bin/activate \n\
meltano --version \n\
echo "Running meltano with provided command args ($@)..." \n\
$@ \n\
' > /projects/bootstrap.sh && \
chmod 777 /projects/bootstrap.sh

# ENTRYPOINT ["$VENV/bin/meltano"]
ENTRYPOINT ["/projects/bootstrap.sh"]
CMD ["meltano", "ui"]
