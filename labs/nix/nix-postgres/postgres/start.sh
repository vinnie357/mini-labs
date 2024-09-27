#!/bin/bash
root_path=${PROJECT_DIR:-"$PWD"}
postgres_dir="$root_path/.tmp/postgres"
#postgres_run_dir="$root_path/postgres/.tmp/run"
postgres_run_dir="/run/$(basename $root_path)/nix-pg"
if [ -d .tmp ]; then
    if [ -S .s.PGSQL.5432.lock ]; then
        echo "Socket file already exists. Skipping start."
    else
        echo "Starting PostgreSQL..."
        pg_ctl -D $postgres_dir -l logfile -o "--unix_socket_directories='$postgres_run_dir' --listen_addresses='0.0.0.0'" start
    fi
else
    . ./setup.sh
fi
