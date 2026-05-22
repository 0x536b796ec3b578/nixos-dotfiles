{
  imports = [
    ./modules/boot.nix
    ./modules/disko.nix
    ./modules/luks.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/swap.nix
    ./modules/tpm2.nix
    ./modules/users.nix
  ];

  system.stateVersion = "25.11";
}
