#!/bin/bash

# Use this script to install any taps and targets needed for this project.
# i.e.: s-tap install PLUGIN_NAME [ INSTALL_SOURCE [ PLUGIN_ALIAS ] ]

# Install taps:
s-tap install tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master
s-tap install tap-pardot

# Install targets:
s-tap install target-csv
s-tap install target-s3-csv pipelinewise-target-s3-csv
