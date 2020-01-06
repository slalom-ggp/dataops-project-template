#!/bin/bash

set -e

TAP_NAME=$1
TABLE_NAME=$2
TARGET_NAME=csv

NO_CATALOG_COMMITS=true

ROOT_DIR=/projects/my-project
SECRET_CONF=$ROOT_DIR/.secrets/tap-$TAP_NAME-config.json
if [[ $NO_CATALOG_COMMITS == true ]]; then
    CATALOG_DIR=$ROOT_DIR/.output/taps/$TAP_NAME-catalog
else
    CATALOG_DIR=$ROOT_DIR/data/taps/$TAP_NAME
fi
FULL_CATALOG_FILE=$CATALOG_DIR/$TAP_NAME-catalog-full.json
TABLE_CATALOG_FILE=$CATALOG_DIR/$TAP_NAME-$TABLE_NAME-catalog.json
TABLE_STATE_FILE=$CATALOG_DIR/$TABLE_NAME-state.json

START=`date`
echo -e "Starting sync of '$TABLE_NAME' from '$TAP_NAME' at: $START"

python3 /projects/my-project/data/taps/extractutils.py \
    select \
    --tap_name=$TAP_NAME \
    --table_name=$TABLE_NAME \
    --full_catalog_file=$FULL_CATALOG_FILE \
    --output_file=$TABLE_CATALOG_FILE

# cd $CATALOG_DIR
EXTRACT_CMD="tap-$TAP_NAME --config $SECRET_CONF --catalog $TABLE_CATALOG_FILE | target-$TARGET_NAME >> $TABLE_STATE_FILE"
echo "Running command to extract the $TAP_NAME '$TABLE_NAME' table to $TARGET_NAME:\n\t$EXTRACT_CMD"
$EXTRACT_CMD
# tail -1 state.json > state.json.tmp && mv state.json.tmp state.json

echo -e "Completed sync of sync of '$TABLE_NAME' from '$TAP_NAME'"
echo -e "Start time: $START\nEnd time:   $(date)"
