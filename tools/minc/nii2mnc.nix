{ mkDerivation, minc_tools }:

{ infile, dtype ? null }:

mkDerivation rec {

  name = "nii2mnc.mnc";

  buildInputs = [ minc_tools ];

  inherit infile dtype;

  cmd = ''nii2mnc ''${dtype:+-$dtype} $infile $out'';

}
