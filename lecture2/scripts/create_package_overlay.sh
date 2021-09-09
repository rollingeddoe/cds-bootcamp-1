#! /bin/bash

# Set this to the directory containing empty overlay images
# Note: on GCP the overlay directory does not exist
OVERLAY_DIRECTORY=/scratch/work/public/overlay-fs-ext3/
if [[ ! -f $OVERLAY_DIRECTORY ]]; then
OVERLAY_DIRECTORY=/scratch/wz2247/singularity/overlays/
fi

IMAGE_DIRECTORY=/scratch/wz2247/singularity/images/

# Set this to the overlay to use for additional packages.
ADDITIONAL_PACKAGES_OVERLAY=overlay-1GB-400K.ext3

# We will install our own packages in an additional overlay
# So that we can easily reinstall packages as needed without
# having to clone the base environment again.
echo "Extracting additional package overlay"
cp $OVERLAY_DIRECTORY/$ADDITIONAL_PACKAGES_OVERLAY.gz .
gunzip $ADDITIONAL_PACKAGES_OVERLAY.gz
mv $ADDITIONAL_PACKAGES_OVERLAY overlay-packages.ext3


# We now execute the commands to install the packages that we need.
echo "Installing additional packages"
singularity exec --no-home -B $HOME/.ssh \
    --overlay overlay-base.ext3 \
    $IMAGE_DIRECTORY/pytorch_21.06-py3.sif /bin/bash << 'EOF'
source ~/.bashrc
conda activate /ext3/conda/bootcamp
conda install -y pytest
conda install -c conda-forge hydra-core omegaconf openssh
python -m pip install -y pytorch-lightning
EOF
