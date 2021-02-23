{ lib, mkDerivation, mni_autoreg }:

{ interpolation ? null
# linear registration options
, linear_opt_objective ? null
, linear_opt_groups ? null
, tol ? null
, simplex ? null
, w_translations ? null
, w_rotations ? null
, w_scales ? null
, w_shear ? null
# nonlinear registration options
, nonlinear ? null
, sub_lattice ? null
, lattice_diameter ? null
, max_def_magnitude ? null
, use_simple ? null
, super ? null
, iterations ? null
, weight ? null
, stiffness ? null
, similarity_cost_ratio ? null
} @ config:

{ source
, target
, source_mask ? null
, target_mask ? null
, transform   ? null }:

# TODO add some asserttions, e.g., interpolation in null, nn, trilinear, tricubic...

mkDerivation rec {

  name = "minctracc.xfm";
  buildInputs = [ mni_autoreg ];

  inherit source target;

  cmd = with lib; ''
    minctracc
      ${optionalString (interpolation != null) "-interpolation $interpolation"}
      ${optionalString (source_mask != null) "-source_mask $source_mask"}
      ${optionalString (target_mask != null) "-target_mask $target_mask"}
      ${optionalString (transform   != null) "-transform   $transform"}
      ${optionalString (nonlinear != null)   "-nonlinear"}
      ${source} ${target} $out
  '';

}
