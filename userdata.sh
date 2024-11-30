#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${cluster_name} ${bootstrap_arguments}
/opt/aws/bin/cfn-signal --exit-code $? \
         --stack  ${stack_name} \
         --resource NodeGroup  \
         --region ${region}