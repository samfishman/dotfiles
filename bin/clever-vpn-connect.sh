#!/bin/bash

domains=("apps.clever.com" "schools.clever.com" "prod-dw.cmvbhbkkdzzl.us-west-2.redshift.amazonaws.com" "test-cluster.cmvbhbkkdzzl.us-west-2.redshift.amazonaws.com")

for d in ${domains[@]}; do
    ips=`dig +noall +answer $d | awk '{ if ($4 == "A") { print $5; } }'`
    for ip in $ips; do
        sudo route add $ip 172.27.223.1
    done
done
