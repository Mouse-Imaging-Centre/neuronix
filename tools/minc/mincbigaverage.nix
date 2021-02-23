{ mkDerivation, minc_widgets }:

{ files, robust ? false }:

mkDerivation rec {

  name = "mincbigaverage.mnc";
  buildInputs = [ minc_widgets ];

  inherit files robust;

  # TODO files should come from a file to avoid Bash error when the command is too long;
  # mincbigaverage supports reading filenames from a file and runCommand also has an option for this,
  # i.e. add passAsFile = [ "builder.sh" ] or similar (and make this do something?)
  cmd = ''mincbigaverage ''${robust:+-robust} --tmpdir $TMP $files $out'';

}
