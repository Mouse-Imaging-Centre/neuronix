{ mkDerivation, lib, minc_tools }:

{ dtype ? null }:

infile:

mkDerivation rec {

  name = "nii2mnc.mnc";

  buildInputs = [ minc_tools ];

  cmd = ''nii2mnc ${lib.optionalString (dtype!=null) "-dtype ${dtype}"} ${infile} $out'';

}
