# nixos-config

Based on https://github.com/LGUG2Z/nixos-wsl-starter. Althought it works, but I cannot tolerate the way the original author organized his configurations.

## WSL
Follow the instructions of [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) to install NixOS.

- Get a copy of this repo (you'll probably want to fork it eventually):

```bash
git clone https://github.com/LiaoliaoLiu/nixos-config /tmp/configuration
cd /tmp/configuration
```

- Change the username to your desired username in `flake.nix`
- Apply the configuration and shutdown the WSL2 VM

```bash
sudo nixos-rebuild switch --flake /tmp/configuration && sudo shutdown -h now
```

- Reconnect to the WSL2 VM

```bash
wsl -d NixOS
```

- `cd ~` and then `pwd` should now show `/home/<YOUR_USERNAME>`
- Move the configuration to your new home directory

```bash
mv /tmp/configuration ~/configuration
```

- Install `win32yank` with `scoop` and add it to your `$PATH` in [./runtime/wsl.nix](./runtime/wsl.nix)
- Apply the configuration

```bash
sudo nixos-rebuild switch --flake ~/configuration
```

Note: If developing in Rust, you'll still be managing your toolchains and
components like `rust-analyzer` with `rustup`!

## Project Layout

This project uses a modular structure with clear separation between system-level and user-level configurations:

- `flake.nix` - Main flake entry point where dependencies are specified (with minimal configuraitons)
  - `nixpkgs` - Remove `master` if you want to use a 'stable' version.
  - `nixos-wsl` - WSL-specific configuration options
  - `nix-index-database` tells you how to install a package when you run a command which requires a binary not in the `$PATH`
  - `neovim` - My neovim is still shitty, ideally you want to put the below in [./runtime/default.nix](./runtime/default.nix) for yours:

```nix
  environment.systemPackages = [
    inputs.neovim.packages.${system}.nvim
  ];
```

- `system/` - System-level configuration
  - `default.nix` - (hostname, timezone, users...)
  - `wsl.nix` - WSL-specific NixOS system configuration (conditionally imported on `x86_64-linux`)

- `runtime/` - User-level configuration and packages
  - `default.nix` - NixOS-level home-manager options
  - `home.nix` - User packages, home directory settings, and module imports
  - `shell.nix` - Shell-related configurations
  - `git.nix` - Git configuration
  - `wsl.nix` - WSL-specific shell configurations (conditionally imported on `x86_64-linux`)
  - `secrets.json` - Secret values (you know what to do)
