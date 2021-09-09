#! /bin/bash

#SBATCH --account=ds_ga_1006_001
#SBATCH --partition=c2s16p
#SBATCH --time=4:00:00

set -e
set -u

echo "Writing instance config file"

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR log-1.nyu.cluster << EOF
cat << EOFCONFIG > \$HOME/.ssh/burst_instance_config_cpu
Host burstinstancecpu
    Hostname ${HOSTNAME}
    ForwardAgent yes
EOFCONFIG
chmod 644 \$HOME/.ssh/burst_instance_config_cpu
EOF

sleep infinity
