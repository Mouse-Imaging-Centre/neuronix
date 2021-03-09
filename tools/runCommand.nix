{ mkDerivation }:
# {mkDerivation, minc_tools minc_widgets mni_autoreg }:

deps: overrides: cmd:

mkDerivation (rec {

  name = "runCommand.mnc";
  buildInputs = builtins.attrValues deps;

  inherit cmd;
} // overrides)
