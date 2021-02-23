{ mkDerivation, minc_tools }:

{ infile
, transform ? null
, like ? null
, interpolation ? null
, invert ? false
, dtype ? null
, labels ? false
, keep_real_range ? false }:

mkDerivation rec {

  name = "mincresample.mnc";

  buildInputs = [ minc_tools ];

  inherit infile dtype transform interpolation invert labels like keep_real_range;

  cmd = ''
    mincresample
      ''${dtype:+-$dtype}
      ''${interpolation:+-$interpolation}
      ''${invert:+-invert}
      ''${like:+-like $like}
      ''${transform:+-transform $transform}
      $infile $out
  '';
}
