# trivial version stolen from Nix-pills series
pkgs: attrs:
  with pkgs;
  let defaultAttrs = {

    builder = "${bash}/bin/bash";
    args = [ ./default-builder.sh ];

    setup = ./setup.sh;

    baseInputs = [ gnutar gzip coreutils gawk gnused gnugrep ];
    buildInputs = [];

    system = builtins.currentSystem;
  };
  in
  derivation (defaultAttrs // attrs)
