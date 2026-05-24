{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alacritty
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = false;

    enableSystemMonitoring = true;
    enableClipboardPaste = true;
    enableDynamicTheming = true;

    niri = {
      enableSpawn = true;
      enableKeybinds = false;
      includes.enable = false;
    };
  };

  xdg.configFile."niri/config.kdl".source = ./config/niri/config.kdl;
}
