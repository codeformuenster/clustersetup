# How to install VMs

We're using Ubuntu 20.04 LTS as server OS. This document explains the installation process.

## Prerequisites

- In the "Hardware" menu
    - Remove the VLAN tag of the network device
- In the "Options" menu
    - Set "Boot order" to boot "Network" first
    - Disable "QEMU Guest Agent"
- On your local machine, `xdotool` is really handy to enter passwords


## Manual installation of the VM

- Start the VM and open the VNC Console
- Wait for PXE boot to load the network boot menu
- Select
    - "Linux Network Installs"
    - "Ubuntu"
    - "Ubuntu 20.04 LTS Focal Fossa"
    - "Install"


## Manual installation steps

Select "Install" without specifying a preseed url

- The Ubuntu installer loads. Select
    - "English"
    - "other"
    - "Europe"
    - "Germany
    - "United States - en_US.UTF-8"
    - "No". Don't detect keyboard layout
    - "English (US)" as country of origin for the keyboard
    - "English (US)" again
    - "kube<X>" for hostname. Use a number for `<X>`
    - "Germany" as Ubuntu archive mirror country
    - Confirm "de.archive.ubuntu.com"
    - Leave Proxy configuration blank
    - "kube" as full user name
    - "kube" as user name for your account
    - use `sleep 1; xdotool type "PASSWORD"` with a preselected password (not PASSWORD)
    - Confirm password
    - Confirm "Europe/Berlin" as your time zone
    - Select "Guided - use entire disk" for Partitioning method
    - Select the disk "sda"
    - Confirm "Write the changes to disk"
    - Select "Install security updates automatically"
    - At "Choose software to install", select
        - "OpenSSH server"
        - "Basic Ubuntu Server"
    - Select "Yes" to install GRUB boot loader into master boot record
    - Confirm "Is the system clock set to UTC" with "Yes"

## After installation

- Shut down the VM
- In the "Hardware" menu
    - Add the VLAN tag of the network device (removed in the first step)
- In the "Options" menu
    - Set "Boot order" to boot "Disk" first
- Start the VM
- Open the VNC console
- First Boot will take quite some time (Waiting for network which is not configured)
- Esc maybe will show you some progress
- If the only a cursor blinks in the top left corner
    - Send Ctrl + Alt + F1
    - This will allow you to log in
- Use username "kube" and the password from the installation routine to sign in
- Execute `ip a`. Interface `ens18` will have a dynamic IPv6 address.

## Set up network

For these steps, you'll need the VMs: external IP (v4 & v6), netmasks, and gateways.

- Use the ipv6 from step before to ssh into the host `ssh kube@ipv6...`
- Edit `/etc/netplan/01-netcfg.yaml` as root

      network:
        version: 2
        renderer: networkd
        ethernets:
          ens18:
            addresses:
            - X.X.X.X/YY
            - Z:Z:..../AA
            gateway4: X.X.X.X
            gateway6: Z:Z:Z:Z....

- Execute `netplan apply`. This will disrupt the network connection briefly. If you have made an error, continue using the VNC console
- Transfer your ssh public key to the host `ssh-copy-id -i keys/kube-vsh.pub kube@X.X.X.X`

### Initial ansible setup

Check the README.md file of this repository for further instructions
