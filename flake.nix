{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, hyprland, nixpkgs, home-manager }:
     {


      nixosModules.default = import ./nixos-dots.nix;

    #   homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
        

    #     modules = [
    #       # hyprland.homeManagerModules.default
    #       home
    #     ];
    #   };



    };
}
