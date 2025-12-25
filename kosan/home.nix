{ config, pkgs, inputs, ... }:
let username = "kosan";
in {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
  home = {
    packages = with pkgs; [
      waybar # should be in DE setup
      starship
      foot
      git
      wmenu # should probably be in DE setup
      wl-clipboard
      grim # part of DE
      slurp # ^^
      swww # ^^^^
      jetbrains-mono
			wineWow64Packages.full
      lutris
      jujutsu
      lazyjj
			orca-slicer
			bambu-studio
			emacs
			emacsPackages.treesit-grammars.with-all-grammars
			emacsPackages.vterm
			emacsPackages.pdf-tools
			multimarkdown
			cargo

    ];

    inherit username;
    homeDirectory = "/home/${username}";

    # file = {
    #   "hello.txt" = {
    #     text = "echo 'Hello, world!'";
    #     executable = true;
    #   };
    # };

    stateVersion = "25.05";
  };
  # wayland.windowManager.river = {
  #   enable = true;
  #   systemd.enable = true;
  # };
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   systemd.enable = true;
  # };
}
