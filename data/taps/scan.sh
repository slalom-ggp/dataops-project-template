#!/bin/bash

# Use this script to create or update the metadata catalog for a specified tap.
# i.e.: s-tap discover TAP_NAME

pip3 install --upgrade git+https://github.com/slalom-ggp/dataops-tools.git@feat/taputils

SELECT_FILE=/projects/my-project/data/taps/data.select

s-tap plan salesforce $SELECT_FILE
s-tap plan pardot $SELECT_FILE
