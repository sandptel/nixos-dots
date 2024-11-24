{ home-manager, system, inputs, config, lib, pkgs, ... }:

with lib;

let
    cfg = config.nixos-dots.configs;
      # Values you should modify
      username = "roronoa"; # $USER
      system = "x86-64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      stateVersion = "24.11";     # See https://nixos.org/manual/nixpkgs/stable for most recent

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "/${homeDirPrefix}/${username}";

      home = (import ./home.nix {
        inherit homeDirectory pkgs stateVersion system username;
      });
in
{
  options.config.nixos-dots.configs = {
    enable = mkEnableOption "Add trawl and trawld.service";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      
    ];

  home-manager={
  extraSpecialArgs={inherit inputs;};
  useGlobalPkgs=true;
  useUserPackages=true;
  backupFileExtension= "backup";
  users={
    roronoa= {
      imports =[
        inputs.hyprland.homeManagerModules.default
      ./home.nix
      ];
      };
  };
};
  };
}