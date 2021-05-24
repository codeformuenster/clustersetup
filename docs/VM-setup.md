# How to install VMs

We're using Ubuntu 20.04 LTS as server OS. This document explains the installation process.

## Prerequisites

Our VMs run on Proxmox, but that usually does not matter. It should work any other way.

- In the "Hardware" menu
    - Remove the VLAN tag of the network device
- In the "Options" menu
    - Set "Boot order" to boot "Network" first
    - Disable "QEMU Guest Agent"
- On your local machine, `xdotool` is really handy to enter passwords


## Installation of the VM (preseed and manual)

- Start the VM and open the VNC Console
- Wait for PXE boot to load the network boot menu
- Select
    - "Linux Network Installs"
    - "Ubuntu"
    - "Ubuntu 20.04 LTS Focal Fossa (subiquity)"

## Autoinstall

Instead of selecting "Install", select "Specify preseed url..."

Create empty files named `meta-data` and `vendor-data`. For `user-data` copy file [`autoinstall-user-data-example.yaml`](./autoinstall-user-data-example.yaml) and change accordingly.

Host these files somewhere the installer can access them.

Using `xdotool` you can enter the url. (Or just manually type it)

Watch the machine install itself. Continue with [After installation](#after-installation).

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
- Make sure Firewall is enabled & allows traffic on port 22
- Start the VM

### DNS settings

Check the [Network documentation](Network.md)

### Initial ansible setup

Check the README.md file of this repository for further instructions
