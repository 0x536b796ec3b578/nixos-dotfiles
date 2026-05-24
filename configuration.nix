{
  imports = [
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/disko.nix
    ./modules/home-manager.nix
    ./modules/locale.nix
    ./modules/luks.nix
    ./modules/networking.nix
    ./modules/niri.nix
    ./modules/nix.nix
    ./modules/packages.nix
    ./modules/swap.nix
    ./modules/tpm2.nix
    ./modules/users.nix
  ];

  system.stateVersion = "25.11";
}
