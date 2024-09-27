# nix-shell postgres

I wanted a local postgres I didn't need to install.


## setup

```bash
nix-shell
cd postgres
. setup.sh
. run.sh
```

## fun stuff

ubuntu doesn't seem to care where we create unix sockets as long as we have ownership.
macos wants the sockets in `/run`
so you can make your sockets in `.tmp` on ubuntu , but on a mac you need sudo to create sockets in `/run` and change their ownership to your nix user to start the postgres

