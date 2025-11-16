{
  username,
  specialArgs,
  system,
  inputs,
  ...
}: let
  secrets = builtins.fromJSON (builtins.readFile ./secrets.json);
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs =
    specialArgs
    // {
      inherit secrets;
    };
}
