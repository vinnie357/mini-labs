{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        postgresql
    ];
    shellHook = ''
        export LC_ALL=en_US.UTF-8
        # Add more environment variables here if needed
    '';
    LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}
