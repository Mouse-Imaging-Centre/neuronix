{ mkDerivation, python }:

infile:

mkDerivation rec {

  name = "finest_resolution";
  buildInputs = [ python ];

  builder = [ "${python.interpreter}" ];

  inherit infile;

  args = [ ./builder.py ];
}
