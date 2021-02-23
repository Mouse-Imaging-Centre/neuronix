{ mkDerivation, minc_tools }:

{ dtype ? null }:

file:

mkDerivation rec {

  name = "mnc2nii.nii";

  buildInputs = [ minc_tools ];

  cmd = ''mnc2nii -verbose ''${dtype:+-$dtype} ${file} $out'';
}
