with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "gleam-${version}";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "gleam-lang";
    repo = "gleam";
    rev = "v${version}";
    sha256 = "gPlRihwK+J7s1SeymfdVo/KIV+eEqxlLVOgsDWW9yo=";
  };

  buildInputs = [ erlang rebar3 ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp gleam $out/bin/
  '';
}