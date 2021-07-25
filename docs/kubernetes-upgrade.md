# Upgrading the cluster to a newer kubernetes version

Since kubelet and related component versions are managed through an ansible role, some manual steps are required to upgrade the cluster.

The rest of these instructions follow the [official instructions](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/) with few deviations.

## Upgrade software to new versions

- SSH into a node
- Execute `sudo apt update` to refresh package lists
- Use `apt-cache madison <packagename> | head -n1` to get latest versions for
  - `kubelet`, then update `kubelet_version` in `group_vars/all/kubeadm.yaml`
  - `kubeadm` (`kubeadm_version`)
  - `helm` (`helm_version`)
  - `containerd.io` (`containerd_version`)
  - `docker-ce-cli` (`docker_cli_version`)
  - `docker-ce`
- Save your changes for `group_vars/all/kubeadm.yaml`
- Execute the playbook with `--tags install-kubeadm` flag

      ansible-playbook --tags install-kubeadm clustersetup.yaml

## Upgrade the nodes

Once you [upgraded the required software components](#upgrade-software-to-new-versions), you can start migrating node by node.

Execute these steps for each node. Do not execute anything in parallel and check if everything is up before you proceed to the next node!

### On the first node

- Check if `kubeadm` is the requested version

      kubeadm version

- Verify the upgrade plan

      kubeadm upgrade plan

- Start upgrading the first node

      sudo kubeadm upgrade apply v1.21.x

- Drain the node (We're running in High-Availibilty mode with no workers)

      kubectl drain <node-to-drain> --ignore-daemonsets

- Either restart only the kubelet or the whole node


      sudo systemctl daemon-reload
      sudo systemctl restart kubelet
      # or
      sudo reboot

- Wait until the node is `Ready` again

      kubectl get nodes

- Mark the node available for workloads again

      kubectl uncordon <node-to-drain>

- Proceed with the other nodes

### All other nodes

- Check if `kubeadm` is the requested version

      kubeadm version

- **Attention** Continue upgrading the other node

      sudo kubeadm upgrade node

- Drain the node (We're running in High-Availibilty mode with no workers)

      kubectl drain <node-to-drain> --ignore-daemonsets

- Either restart only the kubelet or the whole node


      sudo systemctl daemon-reload
      sudo systemctl restart kubelet
      # or
      sudo reboot

- Mark the node available for workloads again

      kubectl uncordon <node-to-drain>

- Wait until the node is `Ready` again

      kubectl get nodes

- Proceed with the other nodes
