set -eu
set -o pipefail

PATH=
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

# restore +u for `nix-shell`s
set +u
