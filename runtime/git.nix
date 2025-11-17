{
  pkgs,
  local,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
    settings = {
      user.email = local.gitEmail;
      user.name = local.gitName;
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };
}
