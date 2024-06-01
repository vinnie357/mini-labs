{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [ pkgs.unit ];
shellHook =
  ''
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
  '';
}