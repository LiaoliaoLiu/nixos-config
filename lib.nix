{inputs}: {
  # genAttrs :: [String] -> (String -> String) -> AttrSet
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  mkNixosConfig = {
    system,
    hostname,
    username,
    isWsl ? false,
    modules,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = {
        inherit inputs hostname username isWsl;
        inherit (inputs) self nix-index-database;
        channels = {
          inherit (inputs) nixpkgs nixpkgs-unstable;
        };
      };
    };
}
