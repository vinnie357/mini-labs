{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; }; } }:

pkgs.mkShell {
  buildInputs = [ pkgs.nomad pkgs.docker  pkgs.xdg-utils ];
shellHook =
  ''
    if ! groups $USER | grep &>/dev/null '\bdocker\b'; then
      echo "Warning: $USER is not in the docker group. Please add the user to the docker group."
      exit 1
    fi
    nomad=$(echo $(which nomad))
    #alias nomad=$(echo $(which nomad))
    #tmux new-session 'sudo $nomad agent -dev -config=nomad.conf' \; split-window -h 'nix-shell -p jq'
    #tmux new-session 'sudo $nomad agent -dev -config=nomad.conf'
    xdg-open http://localhost:4646/ui/
    sudo $nomad agent -dev -config=nomad.conf
    #xdg-open http://localhost:4646/ui/
  '';
}