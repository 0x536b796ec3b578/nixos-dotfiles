{
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.root = {
    allowDiscards = true;
    crypttabExtraOpts = [
      "tpm2-device=auto"
      "tpm2-measure-pcr=yes"
    ];
  };
}
