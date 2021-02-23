{ mkDerivation, minc_stuffs }:

{ infile
, distance ? null
, fwhm ? null
, mask ? null
}:

assert (distance != null || fwhm != null);
assert (distance == null || fwhm == null);

mkDerivation rec {

  name = "smooth_vector.mnc";

  buildInputs = [ minc_stuffs ];

  inherit infile fwhm distance mask;

  cmd = ''
    smooth_vector
      ''${mask:+--mask $mask}
      ''${distance:+--spline --distance $distance}
      ''${fwhm:+--filter --fwhm $fwhm}
      $infile $out
  '';
}
