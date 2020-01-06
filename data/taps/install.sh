#!/bin/bash

# Use this script to install any taps and targets needed for this project.
# i.e.: ./utils/install.sh PLUGIN_NAME [ INSTALL_SOURCE [ PLUGIN_ALIAS ] ]

# Install taps:
./utils/install.sh tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master

# Install targets:
./utils/install.sh target-csv
./utils/install.sh target-s3-csv pipelinewise-target-s3-csv
