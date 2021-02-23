{ mkDerivation, mni_autoreg }:

{ fwhm, gradient ? true }:

infile:

mkDerivation rec {

  name = "mincblur.mnc";
  buildInputs = [ mni_autoreg ];

  #inherit fwhm infile gradient;

  outputs = if gradient then [ "blur" "grad" ] else [ "blur" ];

  cmd = ''
    mincblur -fwhm $(cat $fwhm) ${gradient:+-gradient} $infile base
    mv base_blur.mnc $blur
    ${if gradient then ''mv base_dxyz.mnc $grad'' else ""}
  '';

}
