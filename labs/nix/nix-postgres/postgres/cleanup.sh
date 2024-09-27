#!/bin/bash
# stop postgres
# delete the postgres temp directory
root_path=${PROJECT_DIR:-"$PWD"}
postgres_temp_dir="$root_path/.tmp/"
postgres_dir="$root_path/.tmp/postgres"
postgres_run_dir="/run/$(basename $root_path)/nix-pg"
pg_ctl -D $postgres_dir stop
rm -rf $postgres_temp_dir
sudo rm -rf "/run/$(basename $root_path)"
