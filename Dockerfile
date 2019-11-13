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

# Capture command history, allows recall if used with `-v ./local-bashhistory:/root/commandhistory`
RUN mkdir -p /root/commandhistory && \
    echo "export PROMPT_COMMAND='history -a'" >> "/root/.bashrc" && \
    echo "export HISTFILE=/root/commandhistory/.bash_history" >> "/root/.bashrc"

# ENTRYPOINT ["$VENV/bin/meltano"]
ENTRYPOINT ["/virtualenvs/meltano/bin/meltano"]
CMD ["ui"]
