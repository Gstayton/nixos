{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    wayland-utils
    xdg-desktop-portal-hyprland
    kdePackages.sddm-kcm
    hyprpanel
    hyprpaper
    hypridle # dpms control
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
