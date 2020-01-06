#!/bin/bash

# Use this script to extract data for a specified tap.

./utils/sync.sh salesforce Account
./utils/sync.sh salesforce Opportunity
./utils/sync.sh salesforce OpportunityHistory
./utils/sync.sh salesforce User
