# nix dockertools pkg

https://ryantm.github.io/nixpkgs/builders/images/dockertools/

https://nix.dev/tutorials/nixos/building-and-running-docker-images.html

```bash


cat <<'EOF' hello.nix
{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "hello-docker";
  config = {
    Cmd = [ "${pkgsLinux.hello}/bin/hello" ];
  };
}
EOF

nix-build hello.nix

docker load < result
# or
docker load < $(nix-build hello.nix)

tag=$(docker image list | grep hello-docker | awk '{print $2}')

docker run hello-docker:$tag

# examples
cat <<EOF > examples.nix
$(curl -L https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/build-support/docker/examples.nix)
EOF

nix-build '<nixpkgs>' -A dockerTools.examples.redis
docker load < result

docker run redis:latest

# something crazier
cat <<'EOF' > redis.nix

{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "redis";
  tag = "latest";

  fromImage = "scratch";
  fromImageName = null;
  fromImageTag = "latest";

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [ pkgs.redis ];
    pathsToLink = [ "/bin" ];
  };

  runAsRoot = ''
    #!${pkgs.runtimeShell}
    mkdir -p /data
  '';

  config = {
    Cmd = [ "/bin/redis-server" ];
    WorkingDir = "/data";
    Volumes = { "/data" = { }; };
  };

  diskSize = 1024;
  buildVMMemorySize = 512;
}
EOF

nix-build redis.nix < result

docker load < result


```