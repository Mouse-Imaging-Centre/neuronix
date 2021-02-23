{ mkDerivation, minc_tools }:

{ transforms }:

mkDerivation rec {

  name = "xfmconcat.xfm";

  buildInputs = [ minc_tools ];

  cmd = ''xfmconcat ${toString transforms} $out'';
}
