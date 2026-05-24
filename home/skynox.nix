{ inputs, pkgs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alacritty
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    enableSystemMonitoring = true;
    enableClipboardPaste = true;
    enableDynamicTheming = true;

    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    niri.includes.enable = false;
  };

  programs.niri.config = builtins.readFile ./config/niri/config.kdl;
}
