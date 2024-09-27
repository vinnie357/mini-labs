#!/bin/bash
root_path=${PROJECT_DIR:-"$PWD"}
postgres_dir="$root_path/.tmp/postgres"
pg_ctl -D $postgres_dir stop
