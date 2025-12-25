{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [ wayland-utils inputs.mangowc rofi ];

  services.xserver.enable = true;

}
