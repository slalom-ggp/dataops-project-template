#!/bin/bash

# Use this script to extract data for your project.

# Salesforce extracts:

./utils/sync.sh salesforce Account
./utils/sync.sh salesforce Opportunity
./utils/sync.sh salesforce OpportunityHistory
./utils/sync.sh salesforce User
