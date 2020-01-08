#!/bin/bash
# Use this script to extract data for your project.

set -e  # Stop on failure

# Salesforce extracts:

s-tap sync salesforce Account
s-tap sync salesforce Opportunity
s-tap sync salesforce OpportunityHistory
s-tap sync salesforce User

# Pardot extracts:

s-tap sync pardot campaigns
s-tap sync pardot email_clicks
s-tap sync pardot list_memberships
s-tap sync pardot lists
s-tap sync pardot opportunities
s-tap sync pardot prospect_accounts
s-tap sync pardot prospects
s-tap sync pardot users
s-tap sync pardot visitor_activities
s-tap sync pardot visitors
s-tap sync pardot visits
