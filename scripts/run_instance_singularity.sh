#! /bin/bash


ENV_PREFIX=/ext3/conda/pytorch


set -e
set -u

if [[ ! -f $HOME/.ssh/ssh_host_rsa_key ]]; then
ssh-keygen -f $HOME/.ssh/ssh_host_rsa_key -N '' -t rsa -b 2048
fi

if [[ ! -f $HOME/.ssh/ssh_host_ecdsa_key ]]; then
ssh-keygen -f $HOME/.ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 256
fi

conda activate $ENV_PREFIX

# This is the port on the GCP instance that will be used by the SSH daemon
SSHD_PORT=16453
SSHD_PATH=$(which sshd)

# Start new ssh daemon binding to user port. We specify the config file as /dev/null
# to prevent sshd from reading the default config file (which requires root)
echo "Starting SSH daemon"
$SSHD_PATH -f /dev/null -p $SSHD_PORT -h ~/.ssh/ssh_host_rsa_key -h ~/.ssh/ssh_host_ecdsa_key

sleep infinity
