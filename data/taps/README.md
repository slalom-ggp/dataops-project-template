# Data Taps - README

This folder contains scripts and configuration needed to extract data using the [Singer Taps](https://singer.io) platform.

## Getting Started

_The below examples use `tap-salesforce` to extract data and `target-csv` to save the files locally in the CSV data format._

### Step 1. Install your taps and targets

Example to install the `tap-salesforce` plugin from the Meltano gitlab fork:

```bash
./data/taps/install.sh tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master
```

### Step 2. Add secrets and configuration info

Create or modify your tap settings file in the .secrets directory.

Example file `.secrets/tap-salesforce-config.json`:

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

### Step 3. Run discovery to scan the source metadata

```bash
./data/taps/discover.sh salesforce
```

### Step 4. Add the list of tables into your `data/taps/sync_all.sh` extract script

```bash
#!/bin/bash

./sync.sh salesforce Account
./sync.sh salesforce Opportunity
./sync.sh salesforce OpportunityHistory
./sync.sh salesforce User
```

## Step 5. Run the extracts using `sync` or `sync_all`

Examples to run individual table extracts:

```bash
./sync.sh salesforce Account
./sync.sh salesforce User
```

Example to run all extracts in one command:

```bash
./sync_all.sh
```
