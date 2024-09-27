#https://mgdm.net/weblog/postgresql-in-a-nix-shell/

```bash
# Create a database with the data stored in the current directory
initdb -D .tmp/mydb

# Start PostgreSQL running as the current user
# and with the Unix socket in the current directory
pg_ctl -D .tmp/mydb -l logfile -o "--unix_socket_directories='$PWD'" start

# Create a database
createdb mydb
Then every other time you re-enter that shell, you can just run the part that starts the database. It will keep running until you reboot, or stop it like this:

pg_ctl -D .tmp/mydb stop
```