# Data Taps - README

This folder contains scripts and configuration needed to extract external source data using the open source [Singer Taps](https://singer.io) platform.

## Table of Contents

- [Getting Started Guide](#getting-started-guide)
  - [Step 1. Add your sources to plan.sh](#step-1-add-your-sources-to-scansh)
  - [Step 2. Add your secrets and configuration info](#step-2-add-your-secrets-and-configuration-info)
  - [Step 3. Add your table extracts to sync.sh](#step-3-add-your-table-extracts-to-syncsh)
  - [Step 4. Run the three scripts: install, scan, and sync](#step-4-run-the-three-scripts-install-scan-and-sync)

## Getting Started Guide

_The below examples use `tap-salesforce` to extract data and `target-csv` to save the files locally in the CSV data format._

### Step 1. Add your sources to `plan.sh`

```bash
# Use this script to create or update the metadata catalog for a specified tap.
# i.e.: s-tap discover TAP_NAME

s-tap discover salesforce
```

### Step 2. Add your secrets and configuration info

Create or modify your tap settings file(s) in the .secrets directory.

_Example for salesforce config `.secrets/tap-salesforce-config.json`:_

```json
{
    "api_type": "REST",
    "select_fields_by_default": true,
    "start_date": "2019-11-02T00:00:00Z",
    "username": "my.name@****.com.sfdc",
    "password": "**********",
    "security_token": "********",
    "disable_collection": false
}
```

### Step 3. Add your table extracts to `sync.sh`

```bash
#!/bin/bash
# Use this script to extract data for your project.

# Salesforce extracts:
s-tap sync salesforce Account
s-tap sync salesforce Opportunity
s-tap sync salesforce OpportunityHistory
s-tap sync salesforce User
```

### Step 4. Run the three scripts: `install`, `scan`, and `sync`

```bash
bash ./plan.sh       # Scans source metadata and creates catalog files with tables names, column names, and data types
bash ./sync.sh       # Sync data from your data sources
```
