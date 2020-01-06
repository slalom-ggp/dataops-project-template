#!bin/env python3

import os
import yaml
import json
from pathlib import Path
from collections import OrderedDict
import fire

ROOT_DIR = "."


def apply_catalog_filters(catalog_dir, table_name):
    source_catalog_path = os.path.join(catalog_dir, "catalog-full.json")
    output_catalog_path = os.path.join(catalog_dir, f"{table_name}-catalog.json")
    catalog_full = json.loads(Path(source_catalog_path).read_text())
    # tap_config_path = os.path.join(catalog_dir, "tap-config.yml")
    # tap_config_template = os.path.join(catalog_dir, "tap-config.yml.template")
    # tap_config = yaml.safe_load(Path(tap_config_path).read_text())
    # table_list = tap_config["streams"]["include"]
    included_table_objects = []
    excluded_table_objects = []
    full_table_list = sorted([tbl["stream"] for tbl in catalog_full["streams"]])
    for tbl in catalog_full["streams"]:
        stream_name = tbl["stream"]
        if stream_name == table_name:
            for metadata in tbl["metadata"]:
                if len(metadata["breadcrumb"]) == 0:
                    metadata["metadata"]["selected"] = True
            included_table_objects.append(tbl)
        else:
            excluded_table_objects.append(stream_name)
    catalog_new = {"streams": included_table_objects}
    # with open(tap_config_template, 'w') as f:
    #     template = {}
    #     template["streams"] = {}
    #     template["streams"]["include"] = sorted(table_list)
    #     template["streams"]["exclude"] = sorted(excluded_table_objects)
    #     yaml.dump(template, f)
    with open(output_catalog_path, 'w') as f:
        json.dump(catalog_new, f, indent=2)


def main():
    fire.Fire(apply_catalog_filters)


if __name__ == "__main__":
    main()
