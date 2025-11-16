{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.nix-ld.url = "github:Mic92/nix-ld";
  inputs.nix-ld.inputs.nixpkgs.follows = "nixpkgs";

  inputs.home-manager.url = "github:nix-community/home-manager/master";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nur.url = "github:nix-community/NUR";

  inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL";
  inputs.nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-index-database.url = "github:Mic92/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  # inputs.neovim.url = "/home/t-elos/repo/neovim";

  outputs = inputs: let
    system = "x86_64-linux";
    hostname = "nixos";
    username = "t-elos";

    specialArgs = {
      inherit inputs system hostname username;
      inherit (inputs) self nix-index-database;
      channels = {
        inherit (inputs) nixpkgs nixpkgs-unstable;
      };
    };
  in {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules = [
        ./system
        ./runtime
        # {
        #   environment.systemPackages = [
        #     inputs.neovim.packages.${system}.nvim
        #   ];
        # }
      ];
    };
  };
}
