{ mkDerivation, minc_tools, minc_widgets, mni_autoreg }:

overrides: cmd:

mkDerivation rec {

  name = "runMincCommand.mnc";
  buildInputs = [ minc_tools minc_widgets mni_autoreg ];

  inherit cmd;
} // overrides
