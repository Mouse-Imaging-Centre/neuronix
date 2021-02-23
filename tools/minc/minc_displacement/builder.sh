set -eu
set -o pipefail

source $setup

minc_displacement $reference $transform $out
