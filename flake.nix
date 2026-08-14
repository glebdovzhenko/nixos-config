{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles.url = "github:glebdovzhenko/dotfiles/nixos";
  };

  outputs =
    { nixpkgs, home-manager, dotfiles, ... }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # glebd config
              home-manager.users.glebd = rec {
                home.username = "glebd";
                home.homeDirectory = "/home/glebd";
                home.stateVersion = "24.05";

                home.file = {
                  nvim = {
                    target = ".config/nvim";
                    source = "${dotfiles.outPath}/nvim";
                    recursive = true;
                    force = true;
                  };
                  tmux = {
                    target = ".config/tmux";
                    source = "${dotfiles.outPath}/tmux";
                    recursive = true;
                    force = true;
                  };
                };

                programs.home-manager.enable = true;

                programs.direnv = {
                  enable = true;
                  enableZshIntegration = true;
                  nix-direnv.enable = true;
                };

                programs.git = {
                  enable = true;
                  lfs.enable = true;
                  settings = {
                    user = {
                      name = "Gleb Dovzhenko";
                      email = "dovjenko.g@gmail.com";
                    };
                  };
                };

                programs.neovim = {
                  enable = true;
                  withPython3 = true;
                  #extraPackages = with pkgs; [
                  #  ripgrep
                  #  fd
                  #  tree-sitter
                  #  clang-tools
                  #  nixd
                  #  nixpkgs-fmt
                  #  lua-language-server
                  #  gopls
                  #  pyright
                  #];
                  viAlias = true;
                  vimAlias = true;
                  vimdiffAlias = true;

                };

                programs.tmux = {
                  enable = true;
                };

                imports = [ ./programs ];
              };

            }
          ];
        };
    };
}
