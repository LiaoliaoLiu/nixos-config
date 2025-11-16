{...}: {
  programs.fish = {
    interactiveShellInit = ''
      # WSL-specific: Add win32yank to PATH
      fish_add_path --append /mnt/c/Users/liuli/scoop/apps/win32yank/0.1.1
    '';

    shellAliases = {
      # WSL-specific: Windows utilities
      pbcopy = "/mnt/c/Windows/System32/clip.exe";
      pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
      explorer = "/mnt/c/Windows/explorer.exe";
    };
  };
}
