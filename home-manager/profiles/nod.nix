{ config, pkgs, ... }:

{
  imports = [
    # ../../private/home-manager/private.nix
    ../modules/init.nix
    ../core.nix
  ];

  # Nix Channel

  # Original
  # https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
  # https://github.com/nix-community/nix-on-droid/archive/release-23.11.tar.gz nix-on-droid
  # https://nixos.org/channels/nixos-23.11 nixpkgs

  # Active
  # https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  # https://github.com/nix-community/nix-on-droid/archive/master.tar.gz nix-on-droid
  # https://nixos.org/channels/nixos-unstable nixpkgs

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" "0xProto" ]; })

      # Network
      aria2
      dnsutils
      ngrok
      nmap
      proxychains
      speedtest-cli
      tor
      torsocks

      # Programming
      nodejs
      # jdk_headless
      # jre_headless
      php
      phpPackages.composer
      python312
      python312Packages.pip
      python312Packages.virtualenv
    ];

    # file = {
    #   ".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";
    # };

    shellAliases = {
      more = "less";
      nodg = "nix-on-droid generations";
      nodr = "nix-on-droid rollback";
      nods = "nix-on-droid build switch";
    };
  };

  programs.home-manager.enable = true;
  programs.utils = {
    enable = true;
    additional = true;
    clamav.enable = true;
    gnupg.enable = true;
    gnupg.agent.config = true;
    pass.enable = true;
    yt-dlp.path = "/data/data/com.termux.nix/files/home/storage/Share/YouTube/";
  };

  shell.bash.enable = true;
  shell.starship.enable = true;
  editor.neovim.enable = true;

  services.sshd = {
    enable = true;
    port = 3022;
    addressFamily = "inet";
    dir = "${config.home.homeDirectory}/.ssh";
  };
}