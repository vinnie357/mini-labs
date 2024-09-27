#!/bin/bash
#sudo locale-gen en_US.UTF-8
#LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
root_path=${PROJECT_DIR:-"$PWD"}
postgres_dir="$root_path/.tmp/postgres"
#postgres_run_dir="$root_path/postgres/.tmp/run"
postgres_run_dir="/run/$(basename $root_path)/nix-pg"
echo "postgres_dir: $postgres_dir"  
# mkdir -p $postgres_dir # create the directory if it doesn't exist
sudo mkdir -p $postgres_run_dir
sudo chown -R $USER:$USER $postgres_run_dir

if [ -d .tmp ]; then
    if [ -S .s.PGSQL.5432.lock ]; then
        echo "Socket file already exists. Skipping start."
    else
        echo "Starting PostgreSQL..."
        pg_ctl -D "$postgres_dir" -l logfile -o "--unix_socket_directories='$postgres_run_dir' --listen_addresses='0.0.0.0'" start
    fi
else
    echo "Initializing PostgreSQL..."
    echo "Creating PostgreSQL directory... $postgres_dir"
    initdb -D "$postgres_dir"
    sleep 2
    echo "Starting PostgreSQL..."
    pg_ctl -D "$postgres_dir" -l logfile -o "--unix_socket_directories='$postgres_run_dir' --listen_addresses='0.0.0.0'" start

fi

if ! psql -h localhost -lqt | cut -d \| -f 1 | grep -qw postgres; then
    echo "Creating database..."
    createdb -h localhost postgres
else
    echo "Database already exists. Skipping creation."
fi

if psql -h localhost -tAc "SELECT 1 FROM pg_roles WHERE rolname='postgres'" >/dev/null 2>&1; then
    echo "User already exists. Skipping creation."
else
    echo "Creating user..."
    createuser -h localhost -s postgres
fi
