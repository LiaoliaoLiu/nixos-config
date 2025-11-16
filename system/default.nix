{
  lib,
  system,
  username,
  hostname,
  pkgs,
  inputs,
  ...
}: {
  imports =
    [
      inputs.nix-ld.nixosModules.nix-ld
    ]
    ++ lib.optional (system == "x86_64-linux") ./wsl.nix;

  time.timeZone = "America/Vancouver";
  networking.hostName = "${hostname}";
  environment.enableAllTerminfo = true;
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

  programs.fish.enable = true;
  programs.nix-ld.dev.enable = true;
  environment.pathsToLink = ["/share/fish"];
  environment.shells = [pkgs.fish];
  users.users.${username} = {
    isNormalUser = true;
    # FIXME: change your shell here if you don't want fish
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      # FIXME: uncomment the next line if you want to run docker without sudo
      # "docker"
    ];
    # FIXME: add your own hashed password
    # hashedPassword = "";
    # FIXME: add your own ssh public key
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa ..."
    # ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
}
