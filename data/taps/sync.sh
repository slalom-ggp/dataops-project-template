#!/bin/bash

# Use this script to extract data for your project.

# Salesforce extracts:

s-tap sync salesforce Account
s-tap sync salesforce Opportunity
s-tap sync salesforce OpportunityHistory
s-tap sync salesforce User
