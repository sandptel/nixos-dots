{ config, pkgs, inputs, ... }:
{
  imports = [
    # inputs.hyprland.homeManagerModules.default
    nixos-dots.nix
  ];

}