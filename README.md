# nixos-dotfiles

Skynõx's NixOS configuration. A uniform installation base for any machine
using LUKS on a partition with TPM2 auto-unlock and Secure Boot via
[lanzaboote](https://github.com/nix-community/lanzaboote).


## Installation

Boot the [minimal NixOS ISO](https://nixos.org/download/#nixos-iso) as `root`
and connect to the network.

> [!NOTE]
> To install a specific branch or tag, pass `-b <ref>` to `git clone`.

```sh
# Clone the repo
nix-shell -p git
git clone https://github.com/0x536b796ec3b578/nixos-dotfiles
cd nixos-dotfiles

# Generate Secure Boot keys
sudo nix-shell -p sbctl --run "sbctl create-keys"

# Partition, format, mount, and install in one step (override the disk if it's not /dev/nvme0n1)
sudo nix --experimental-features 'nix-command flakes' run \
  'github:nix-community/disko/latest#disko-install' -- \
  --write-efi-boot-entries \
  --extra-files /var/lib/sbctl /var/lib/sbctl \
  --flake '.#nixos' \
  --disk main /dev/nvme0n1
```

## Post-Installation

Log in as `skynox` (empty password, just press Enter), then:

```sh
# Set a password for the user skynox
passwd

# Enroll Secure Boot keys into firmware (UEFI must be in Setup Mode)
sudo sbctl enroll-keys --microsoft

# Reboot, enable Secure Boot in the firmware menu, boot back into NixOS
reboot

# Verify Secure Boot is actually enabled before enrolling TPM2
sbctl status

# Enroll TPM2 (PCR 7 binds the unlock to the current Secure Boot state)
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p2

# Clone the config to a persistent location for future rebuilds
git clone https://github.com/0x536b796ec3b578/nixos-dotfiles ~/.config/nixos
cd ~/.config/nixos

# Set the machine's hostname declaratively
vim modules/networking.nix
> networking.hostName = "<name>";

sudo nixos-rebuild switch --flake .#nixos

# Reboot
reboot
```
