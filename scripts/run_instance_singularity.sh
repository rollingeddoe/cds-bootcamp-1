#! /bin/bash


set -e
set -u

SSH_KEY_DIR=/ext3/ssh
mkdir -p $SSH_KEY_DIR

if [[ ! -f $HOME/.ssh/ssh_host_rsa_key ]]; then
ssh-keygen -f $SSH_KEY_DIR/ssh_host_rsa_key -N '' -t rsa -b 2048
fi

if [[ ! -f $HOME/.ssh/ssh_host_ecdsa_key ]]; then
ssh-keygen -f $SSH_KEY_DIR/ssh_host_ecdsa_key -N '' -t ecdsa -b 256
fi

# This is the port on the GCP instance that will be used by the SSH daemon
SSHD_PORT=16453
SSHD_PATH=$(which sshd)

# Start new ssh daemon binding to user port. We specify the config file as /dev/null
# to prevent sshd from reading the default config file (which requires root)
echo "Starting SSH daemon"
$SSHD_PATH -f /dev/null -p $SSHD_PORT -h $SSH_KEY_DIR/ssh_host_rsa_key -h $SSH_KEY_DIR/ssh_host_ecdsa_key

sleep infinity
