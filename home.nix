{ homeDirectory
, pkgs
, stateVersion
, system
, username, inputs, ... }:

let
  packages = import ./packages.nix { inherit pkgs; };
in {
  home = {
    inherit homeDirectory packages stateVersion username;

    shellAliases = {
      reload-home-manager-config = "home-manager switch --flake ${builtins.toString ./.}";
    };
  };

   imports=[
    inputs.hyprland.homeManagerModules.default
    ./config.nix
];
  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      experimental-features = "nix-command flakes";
    };
  };

  programs.kitty={
  enable = true;
  extraConfig = ''
  font_size 14
  background_opacity 0.1
  '';
};

# gtk = {
#     enable = true;
#     iconTheme = {
#       name = "SolArc-Dark";
#       package = pkgs.solarc-gtk-theme;
#     }
#   };

wayland.windowManager.hyprland = {
  enable = true;
  extraConfig = ''
  # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
# Sourcing external config files

# Default Configs
$configs = $HOME/.config/hypr/configs

source=$configs/Settings.conf
source=$configs/Keybinds.conf

# User Configs
$UserConfigs = $HOME/.config/hypr/UserConfigs

source= $UserConfigs/Startup_Apps.conf
source= $UserConfigs/ENVariables.conf
source= $UserConfigs/Monitors.conf
source= $UserConfigs/Laptops.conf
source= $UserConfigs/LaptopDisplay.conf
source= $UserConfigs/WindowRules.conf
source= $UserConfigs/UserDecorAnimations.conf
source= $UserConfigs/UserKeybinds.conf
source= $UserConfigs/UserSettings.conf
source= $UserConfigs/WorkspaceRules.conf
  '';
  plugins = [
    inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
  ];
};

home.sessionVariables.GTK_THEME = "gruvbox-dark";

# home.packages = with pkgs;[

# ];

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = import ./programs.nix;
}
