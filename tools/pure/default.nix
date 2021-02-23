{ mkDerivation }:

value:

mkDerivation rec {

  name = "pure";

  inherit value;

  cmd = ''echo "$value" > $out'';
}
