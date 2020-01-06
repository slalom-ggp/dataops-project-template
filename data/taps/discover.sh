#!/bin/bash

set -e

TAP_NAME=$1

NO_CATALOG_COMMITS=true  # 'false' if catalog should be versioned in git

ROOT_DIR=/projects/my-project
SECRET_CONF=$ROOT_DIR/.secrets/tap-$TAP_NAME-config.json
if [[ $NO_CATALOG_COMMITS == true ]]; then
    CATALOG_DIR=$ROOT_DIR/.output/taps/$TAP_NAME-catalog
else
    CATALOG_DIR=$ROOT_DIR/data/taps/$TAP_NAME
fi

START=`date`
echo -e "Starting '$TAP_NAME' discovery at: $START"

DISCOVER_CMD="tap-$TAP_NAME --config $SECRET_CONF --discover > $CATALOG_DIR/$TAP_NAME-catalog-full.json"
echo "Running command to extract the $TAP_NAME '$TABLE_NAME' table to '$TARGET_NAME':\n\t$DISCOVER_CMD"
$DISCOVER_CMD

echo -e "Completed '$TAP_NAME' discovery"
echo -e "Start time: $START\nEnd time:   $(date)"
