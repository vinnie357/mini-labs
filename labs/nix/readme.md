# nix labs

using nix to access various toolsets in an isolated manner rather than:

- running docker containers, build run manage per use
- using adsf where its all together


## requirements

- nix cli


## install
```bash
. ../../scripts.nix.sh

nix-shell -p nix-info --run "nix-info -m"
```

### just run pkgs

```bash
nix-shell -p python3
python --version
```
### combine multiple packages

```bash
 nix-shell -p gleam -p erlang -p rebar3
 nix-shell -p gleam erlang rebar3
 gleam -version
```

### run unfree licenses sad face hashi.

`error: Package ‘packer-1.10.2’ in /nix/store/m88c3ih5bbq3pfmrm35zkp5qakvnkf8v-nixpkgs/nixpkgs/pkgs/development/tools/packer/default.nix:31 has an unfree license (‘bsl11’), refusing to evaluate.`

```bash
NIXPKGS_ALLOW_UNFREE=1 nix-shell -p packer
packer --version
```
### labs

https://search.nixos.org/packages

- nix-shell
    - elixir
    - rust
    - golang
    - gleam
