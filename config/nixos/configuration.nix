# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  # imports = [
  #   # include NixOS-WSL modules
  #   <nixos-wsl/modules>
  # ];

  wsl.enable = true;
  wsl.defaultUser = "khainguyen";
  wsl.docker-desktop.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  users.users.khainguyen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    git
    curl
    wget
    fzf
    nmap
    ripgrep
    tmux
    neovim
    # You also had build-essential in the script;
    # gcc and tools are usually pulled in via stdenv, but you can be explicit:
    gcc
    binutils
    nodejs_22
    go_1_25
    cargo
    rustc
    yarn
    gnumake
  ];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "candy";
    };
    autosuggestions = {
      enable = true;
    };
  };


  systemd.user.tmpfiles.rules = [
    "L %h/.tmux/plugins/tpm - - - - ${pkgs.fetchFromGitHub {
   owner = "tmux-plugins";
   repo = "tpm";
   rev = "master";
   sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
  }}"
  ];

  users.defaultUserShell = pkgs.zsh;
}

