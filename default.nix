{ nixpkgs ? import <nixpkgs> { } }:

# TODO: global control over substituters/local build?
let
  nixpkgsAndImagingTools = nixpkgs // tools;  # do we want to include nixpkgs in tools??  weird ...

  lib = nixpkgs.lib;

  callPackage = lib.callPackageWith nixpkgsAndImagingTools;

  pythonWithPackages = nixpkgs.python3.withPackages;

  tools = rec {  # currently `rec` to make runMincCommand work; could factor

    ### generic utilities

    mkDerivation = import ./make-derivation.nix nixpkgs;

    pure = callPackage ./tools/pure { };  # similar to nixpkgs.writeText ... unnecessary to define?

    runCommand = nixpkgs.runCommandNoCC;
    # eg `runCommand "test" { inherit mni_autoreg; } "${mni_autoreg}/bin/minctracc ..."`;
    # not as convenient as our own runCommand below

    # TODO: pairwise registration pipeline: use
    # lib.attrsets.cartesianProductOfSets { a = [ 1 2 ]; b = [ 10 20 ]; }


    ### imaging tools - MINC

    runMincCommand = callPackage ./tools/runCommand.nix { } {
      inherit (nixpkgs) minc_tools minc_widgets mni_autoreg;
    };
    runMincCommand_ = runMincCommand { };

    mincbigaverage = callPackage ./tools/minc/mincbigaverage.nix { };

    mincblob_det = infile: runMincCommand { inherit infile; } "mincblob -determinant ${infile} $out";

    det = { reference, transform, fwhm }@args:
      add1
        (mincblob_det
          (smooth_vector {
             infile = (minc_displacement { inherit reference transform; } ); fwhm = fwhm;
          }));

    add1 = infile: runMincCommand { inherit infile; } "mincmath -add -const 1 ${infile} $out";

    log = infile: runMincCommand { inherit infile; } "mincmath -log ${infile} $out";

    log_det = x: log (det x);  # TODO where is composition?

    mincblur = callPackage ./tools/minc/mincblur.nix { };

    minc_displacement = callPackage ./tools/minc/minc_displacement { };

    minctracc = callPackage ./tools/minc/minctracc.nix { };

    mincresample = callPackage ./tools/minc/mincresample.nix { };

    mnc2nii = callPackage ./tools/minc/mnc2nii.nix { };
    mnc2nii_ = mnc2nii { };

    nii2mnc = callPackage ./tools/minc/nii2mnc.nix { };
    nii2mnc_ = nii2mnc { };

    smooth_vector = callPackage ./tools/minc/smooth_vector.nix { };


    # TODO smooth_vector

    xfmconcat = callPackage ./tools/minc/xfmconcat.nix { };

    xfminvert = infile: runMincCommand { inherit infile; } "xfminvert ${infile} $out";


    ### imaging tools - Nibabel ecosystem:

    finest_resolution = callPackage ./tools/finest_resolution {
      python = pythonWithPackages(ps: with ps; [ nibabel ]);
    };


    ### imaging tools - ANTs suite

    runANTsCommand = callPackage ./tools/runCommand.nix { } { inherit (nixpkgs) ants; };
    runANTsCommand_ = runANTsCommand { };

    antsRegistration = callPackage ./tools/ants/antsRegistration.nix { };

    AverageAffineTransform = { dim ? "3", reference_transform ? null }: transforms: runANTsCommand #{ inherit dim reference_transform transforms; } 
      ''
        AverageAffineTransform
          ${lib.optionalString (reference_transform != null) "-R ${reference_transform}"}
          ${dim} $out ${toString transforms}
      '';
        # $(optionalString (reference_transform != null) '-R ${reference_transform}')
    #    #$ (optionalString (reference_transform != null) "-R ${reference_transform}")
    #'';  # TODO allow per-transform inverse (-i) and weights

    majority_labels = label_volumes: runANTsCommand "ImageMath MajorityVoting ${toString label_volumes} $out";

    fuse_labels = infiles: runANTsCommand "ImageMath AverageLabels ${toString infiles} $out";

    ### pipelines

    align_to_template = import pipelines/align_to_template.nix;

  };
in
  tools
