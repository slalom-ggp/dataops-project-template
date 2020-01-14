#!/bin/bash
# Use this script to extract data for your project.

set -e  # Stop on failure

# Configure CSV target (local)

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")
DATA_DIR=$(dirname "$SCRIPT_DIR")
ROOT_DIR=$(dirname "$DATA_DIR")
CSV_OUT_DIR=$ROOT_DIR/.output/taps/target-csv
mkdir -p $CSV_OUT_DIR
export TARGET_CSV_destination_path=$CSV_OUT_DIR

# Configure S3 CSV target

export TARGET_S3_CSV_aws_access_key_id=$AWS_ACCESS_KEY_ID
export TARGET_S3_CSV_aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
export TARGET_S3_CSV_bucket_name=propensity-to-buy
export TARGET_S3_CSV_s3_key_prefix=sync-test/
export TARGET_S3_CSV_encryption_type=kms
# Replace with your own ID:
export TARGET_S3_CSV_encryption_key=f4a1bf33-5862-4eb5-b8f9-6881a50521ba 

# Salesforce extracts:

s-tap sync --target_name=s3-csv salesforce Account
s-tap sync --target_name=s3-csv salesforce Opportunity
s-tap sync --target_name=s3-csv salesforce OpportunityHistory
s-tap sync --target_name=s3-csv salesforce User

# Pardot extracts:

s-tap sync --target_name=s3-csv pardot campaigns
s-tap sync --target_name=s3-csv pardot email_clicks
s-tap sync --target_name=s3-csv pardot list_memberships
s-tap sync --target_name=s3-csv pardot lists
s-tap sync --target_name=s3-csv pardot opportunities
s-tap sync --target_name=s3-csv pardot prospect_accounts
s-tap sync --target_name=s3-csv pardot prospects # OK (~50 minutes)
s-tap sync --target_name=s3-csv pardot users
s-tap sync --target_name=s3-csv pardot visitor_activities # OK (~2 hours)
s-tap sync --target_name=s3-csv pardot visitors
s-tap sync --target_name=s3-csv pardot visits
