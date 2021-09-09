#! /bin/bash

DATA_DIRECTORY=/scratch/wz2247/data/
IMAGE=/scratch/wz2247/singularity/images/

# This script starts singularity with all the expected binds in place.
# The following binds / overlays are defined

# -B $HOME/.ssh: binds the ssh directory to ensure that ssh authorized keys are propagated
# -B /scratch: binds the entire /scratch filesystem
# --overlay overlay-temp.ext3: temporary writable ext3 overlay
# --overlay overlay-base.ext3: overlay with the base packages, created by scripts/create_base_overlay.sh
# --overlay overlay-packages.ext3: overlay with our installed packages, created by scripts/create_package_overlay.sh
# --overlay $DATA_DIRECTORY/places365.squashfs: overlay containing the places365 dataset


singularity exec --no-home -B $HOME/.ssh -B /scratch \
    --overlay overlay-temp.ext3 \
    --overlay overlay-base.ext3:ro \
    --overlay overlay-packages.ext3:ro \
    --overlay $DATA_DIRECTORY/places365.squashfs:ro \
    $IMAGE /bin/bash
    