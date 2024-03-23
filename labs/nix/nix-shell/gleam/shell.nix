{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [ pkgs.gleam pkgs.rebar3 pkgs.erlang ];
}