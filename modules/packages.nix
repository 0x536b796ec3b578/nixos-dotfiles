{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tools
  ];

  time.timeZone = "America/Toronto";
}
