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
  time.timeZone = "Asia/Ho_Chi_Minh";

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

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = with pkgs; [
    # Common Tools
    zsh
    oh-my-zsh
    git
    curl
    wget
    fzf
    unzip
    ripgrep
    dnsutils
    nmap
    tmux
    neovim
    gemini-cli
    openssl

    # C/C++
    clang-tools
    gcc
    binutils
    gnumake

    # NodeJS
    # fnm
    nodejs_22
    yarn
    nodePackages.typescript
    nodePackages."@nestjs/cli"

    # Golang
    go_1_25

    # Rust
    cargo
    rustc

    # Java
    jdk21_headless
    maven

    # Operation
    ansible
  ];

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # fnm
  # ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

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

  programs.npm.enable = true;


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

