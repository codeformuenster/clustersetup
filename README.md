# clustersetup

Hobbyist bare metal kubernetes cluster setup using ansible

## Requirements

Directory `keys` should contain a ssh key for accessing your nodes through ssh.

You also should have the `vault-id` password for encrypted values in the root directory of this repository.

For nodes, Ubuntu 20.04 LTS is used

- Select "Open SSH Server" and "Basic Ubuntu server" at installation
- Allows signing in using the ssh key in `keys/kube-vsh`

Check out [VM-setup.md](docs/VM-setup.md) for a detailed description.

## With local python & ansible installion

Install dependencies

    ansible-galaxy install -r requirements.yaml

Only do this the very first time (for a new host add `--limit "NAME-OF-NEW-HOST-FROM-INVENTORY"`)

    ansible-playbook --tags initial-setup --inventory inventory.yaml --ask-become-pass clustersetup.yaml

Run playbooks

    ansible-playbook --inventory inventory.yaml --vault-id vault-id clustersetup.yaml

Then, bootstrap your nodes

**Attention**: The `bootstrap-nodes` should be used only once for your cluster or after manually running `kubeadm reset --force && rm -rf /etc/cni/net.d` on all of the nodes.

    ansible-playbook --tags bootstrap-nodes --inventory inventory.yaml clustersetup.yaml

### References

- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
- https://github.com/kubernetes/kubeadm/blob/d4b2a53/docs/ha-considerations.md
