{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
    settings = {
      user.email = "liu.liaoliao@outlook.com";
      user.name = "Liao-Liao Liu";
      # FIXME: uncomment the next lines if you want to be able to clone private https repos
      # url = {
      #   "https://oauth2:${secrets.github_token}@github.com" = {
      #     insteadOf = "https://github.com";
      #   };
      #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
      #     insteadOf = "https://gitlab.com";
      #   };
      # };
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
