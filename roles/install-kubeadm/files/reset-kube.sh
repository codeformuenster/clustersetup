#!/bin/bash

set -e

kubeadm reset -f
rm -rf /etc/cni/net.d

systemctl daemon-reload

systemctl restart kubelet

iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X
