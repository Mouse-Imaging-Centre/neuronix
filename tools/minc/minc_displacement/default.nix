{ mkDerivation, minc_stuffs }:

{ transform, reference }:

mkDerivation rec {

  name = "minc_displacement.mnc";

  buildInputs = [ minc_stuffs ];

  inherit transform reference;

  args = [ ./builder.sh ];

}
