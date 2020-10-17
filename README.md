# clustersetup

Hobbyist bare metal kubernetes cluster setup using ansible

## Requirements

Directory `keys` should contain a ssh key for accessing your nodes through ssh.

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

    ansible-playbook --inventory inventory.yaml clustersetup.yaml

### References

- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
