# Data Taps - README

This folder contains scripts and configuration needed to extract data using the [Singer Taps](https://singer.io) platform.

## Table of Contents

- [Getting Started Guide](#getting-started-guide)
  - [Step 1. Install your taps and targets with install.sh](#step-1-install-your-taps-and-targets-with-installsh)
  - [Step 2. Add your secrets and configuration info](#step-2-add-your-secrets-and-configuration-info)
  - [Step 3. Add your sources to scan.sh](#step-3-add-your-sources-to-scansh)
  - [Step 4. Add your table extracts to sync.sh](#step-4-add-your-table-extracts-to-syncsh)
  - [Step 5. Run the three scripts: install, scan, and sync](#step-5-run-the-three-scripts-install-scan-and-sync)

## Getting Started Guide

_The below examples use `tap-salesforce` to extract data and `target-csv` to save the files locally in the CSV data format._

### Step 1. Install your taps and targets with `install.sh`

Update your `install.sh` script to include your taps and targets:

```bash
# Use this script to install any taps and targets needed for this project.
# i.e.: ./utils/install.sh PLUGIN_NAME [ INSTALL_SOURCE [ PLUGIN_ALIAS ] ]

# Install taps:
./utils/install.sh tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master

# Install targets:
./utils/install.sh target-csv
./utils/install.sh target-s3-csv pipelinewise-target-s3-csv
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

### Step 3. Add your sources to `scan.sh`

```bash
# Use this script to create or update the metadata catalog for a specified tap.
# i.e.: ./utils/discover.sh TAP_NAME

./utils/discover.sh salesforce
```

### Step 4. Add your table extracts to `sync.sh`

```bash
#!/bin/bash
# Use this script to extract data for your project.

# Salesforce extracts:
./sync.sh salesforce Account
./sync.sh salesforce Opportunity
./sync.sh salesforce OpportunityHistory
./sync.sh salesforce User
```

### Step 5. Run the three scripts: `install`, `scan`, and `sync`

```bash
./install.sh    # Installs your plugins (if they are not installed already)
./scan.sh       # Scans source metadata and creates catalog files with tables names, column names, and data types
./sync.sh       # Sync data from your data sources
```
