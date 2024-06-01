# nginx unit


https://unit.nginx.org/installation/#community-nix


```bash
unitd --help

unit options:

  --version            print unit version and configure options

  --no-daemon          run unit in non-daemon mode

  --control ADDRESS    set address of control API socket
                       default: "unix:/run/unit/control.unit.sock"

  --control-mode MODE  set mode of the control API socket
                       default: 0600

  --control-user USER    set the owner of the control API socket

  --control-group GROUP  set the group of the control API socket

  --pid FILE           set pid filename
                       default: "/run/unit/unit.pid"

  --log FILE           set log filename
                       default: "/nix/store/3zpzgqcv4anbzyfmjk1x4pghp7cinn9f-unit-1.32.1/var/log/unit/unit.log"

  --modulesdir DIR     set modules directory name
                       default: "/nix/store/3zpzgqcv4anbzyfmjk1x4pghp7cinn9f-unit-1.32.1/lib/unit/modules"

  --statedir DIR       set state directory name
                       default: "/nix/store/3zpzgqcv4anbzyfmjk1x4pghp7cinn9f-unit-1.32.1/var/lib/unit"

  --tmpdir DIR         set tmp directory name
                       default: "/tmp"

  --modules DIR        [deprecated] synonym for --modulesdir
  --state DIR          [deprecated] synonym for --statedir
  --tmp DIR            [deprecated] synonym for --tmpdir

  --user USER          set non-privileged processes to run as specified user
                       default: "unit"

  --group GROUP        set non-privileged processes to run as specified group
                       default: "unit"
```

```bash
# manual
mkdir -p ./modules ./state/certs ./state/scripts ./tmp
unitd \
  --no-daemon \
  --control unix:./control.unit.sock \
  --pid ./unit.pid \
  --log ./unit.log \
  --modulesdir ./modules \
  --statedir ./state \
  --tmpdir ./tmp \
  --user nix \
  --group nix

```

```bash
# nix
tmux new-session 'nix-shell' \; split-window -h 'nix-shell -p jq'
```

```bash
# get config
curl -X GET --unix-socket  \
      ./control.unit.sock http://localhost/config | jq .
      
# add config
curl -X PUT --data-binary @conf.d/html.json --unix-socket  \
      ./control.unit.sock http://localhost/config

# check config
curl -X GET --unix-socket  \
      ./control.unit.sock http://localhost/config | jq .

# test
curl -i 127.0.0.1:8080
```

```bash
# cleanup
rm ./state/conf.json
```

