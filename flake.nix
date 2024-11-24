{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    hyprland.url = "github:hyprwm/Hyprland";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  

  outputs = { self, hyprland, nixpkgs, home-manager }:
  let
      username = "roronoa"; # $USER
      system = "x86-64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      stateVersion = "24.11";     # See https://nixos.org/manual/nixpkgs/stable for most recent

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      
      homeDirectory = "/home/${username}";

      home = (import ./home.nix {
        inherit homeDirectory pkgs stateVersion system username;
      });
in
     {
      
      nixosModules.default = import ./nixos-dots.nix;

      # homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   modules = [
      #     # hyprland.homeManagerModules.default
      #     home
      #   ];
      # };


    };
}
