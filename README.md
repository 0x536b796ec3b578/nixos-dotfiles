# nixos-dotfiles

Skynõx's NixOS configuration. A uniform installation base for any machine
using LUKS on a partition with TPM2 auto-unlock and Secure Boot via
[lanzaboote](https://github.com/nix-community/lanzaboote).


## Installation

Boot the [minimal NixOS ISO](https://nixos.org/download/#nixos-iso) as `root`
and connect to the network.

### One-shot

```sh
nix --experimental-features 'nix-command flakes' run \
  github:nix-community/disko/v1.13.0#disko-install -- \
  --flake github:skynox/nixos-dotfiles \
  --disk main /dev/nvme0n1
```

### In two stages: Create the partition first, then proceed with the installation

```sh
# Partition, format and mount (override the disk if it's not /dev/nvme0n1)
nix --experimental-features 'nix-command flakes' run \
  github:nix-community/disko/v1.13.0 -- \
  --mode disko --flake github:skynox/nixos-dotfiles \
  --disk main /dev/nvme0n1

# Install
nixos-install --no-root-passwd --flake github:skynox/nixos-dotfiles
```

## Post-Installation

Log in as `skynox` (empty password, just press Enter), then:

```sh
# Set a password for the user skynox
passwd

# Generate and enroll Secure Boot keys
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft

# Enable Secure Boot in firmware, then enroll the TPM2
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p2

# Change the machine's hostname
sudo hostnamectl set-hostname <name>

# Persist it in the config (hostnamectl alone is overwritten on the next rebuild)
sudo vim /etc/nixos/modules/networking.nix

# Reboot
reboot
```
