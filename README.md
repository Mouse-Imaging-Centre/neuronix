# Neuronix

Write and run neuroimaging pipelines using the Nix package manager.  Not documented or ready for users yet!

To run an example pipeline, e.g.

```
nix build determinants -f example/example.nix --arg initial_model path/to/initial/model --arg files path-to-nix-list-of/files.nix
```

Most MINC packages are included in Nixpkgs, but some MINC-related functionality (e.g. `smooth_vector`) requires [our Nix overlay](https://github.com/Mouse-Imaging-Centre/mice-nix-overlay).

Another project with similar ideas but developed independently is [Bionix](https://github.com/PapenfussLab/bionix).
We will probably borrow some functionality such as convenient combinators and idioms and functionality for cluster execution from them in future.
