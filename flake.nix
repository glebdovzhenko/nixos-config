{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          #nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # glebd config
          home-manager.users.glebd = rec {
            home.username = "glebd";
            home.homeDirectory = "/home/glebd";
            home.stateVersion = "24.05";

            programs.home-manager.enable = true;

            programs.direnv = {
              enable = true;
              enableZshIntegration = true;
              nix-direnv.enable = true;
            };

            programs.git = {
              enable = true;
              settings = {
                user =
                  {
                    name = "Gleb Dovzhenko";
                    email = "dovjenko.g@gmail.com";
                  };
              };
            };

            programs.neovim = {
              enable = true;
              viAlias = true;
              vimAlias = true;
              vimdiffAlias = true;
            };

            imports = [ ./programs ];
          };

        }
      ];
    };
  };
}
