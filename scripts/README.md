# Scripts for Packages

These scripts are primarily for installing packages.

## Nix

Nix is used if I want the latest version of a package.

I have tried

- [home-manager](https://github.com/nix-community/home-manager)
- flake containing packages, with nix profile. [ref](https://discourse.nixos.org/t/how-do-nix-profiles-and-flakes-fit-together/28139/7)

However, I found these solutions unsatisfactory.

For home-manager, you need to hard-code the username, which can be problematic when applying the configuration to different hosts, such as shared workstations or legacy servers. Hard-coding the username introduces unnecessary limitations. While some people have addressed this issue using [chezmoi templates](https://www.reddit.com/r/NixOS/comments/10tu984/comment/j7af5t8/), it still feels clumsy.

Another issue is the meaning of the `home.stateVersion` variable remains unclear to me. I am unsure what value to set to ensure it works across all machines while still installing the latest versions of specified packages.

Using a flake with `buildEnv` and `nix profile install .` has its drawbacks. The installed tools and their versions are not visible in `nix profile list`. It just creates a new package named after the folder, and when stored with chezmoi, it's called "chezmoi," which is confusing. There are workarounds like sub-folders or git submodules, but they bring other issues, so, whatever.

I'll just go with `nix profile install nixpkgs#$pkg` for now. There is a `manifest.json` for Nix profile, but I am unsure how to use it to install packages.

## sudo and nix

To use sudo with nix packages, either

- add nix root profile to secure_path
- run commands with `sudo -i ...`
- open root shell with `sudo -s`

for `sudo env` command, `$PATH` is set by `secure_path` in `/etc/sudoers`, change the value by `sudo visudo`

- [What environment do I get with sudo? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/a/16112)
- [sudo - Which could be the risks to add "Defaults secure_path="/home/username" in "/etc/sudoers" - Ask Ubuntu](https://askubuntu.com/q/924037)

## nix-env

I am using `nix profile` now, it's just my notes.

nix-env package versions on non-NixOS

Looks like you can find the default channel is `nixpkgs-unstable` from `/root/.nix-channels`. I see nothing with `sudo -i nix-channel --list` and I don't know why, though it does output channels when I am playing inside vm. Finally fixed by `nix-channel --add <nixpkg_url>`.

The channel doesn't update automatically, so it is at the date when you install nix. I installed nix on two VMs on different dates. When I executed `nix-env -iA nixpkgs.neovim`, I got two different versions.

Updating channels is like running `apt update`. Simply execute `sudo -i nix-channel --update nixpkgs --verbose`.

To update nix cli, open root shell with `sudo -s` and follow the [doc](https://nix.dev/manual/nix/2.17/installation/upgrading).

Refs

- [Where does nix profile get versions from? - Help - NixOS Discourse](https://discourse.nixos.org/t/where-does-ninix-profile-get-versions-from/35745/2)
- [Nix-channel --update doesn't update anything, my nixpkgs-unstable channel is months old - Help - NixOS Discourse](https://discourse.nixos.org/t/nix-channel-update-doesnt-update-anything-my-nixpkgs-unstable-channel-is-months-old/44039)
- [You may not need a Home Manager | Roman Zaynetdinov (zaynetro)](https://www.zaynetro.com/post/2024-you-dont-need-home-manager-nix)

## nix flake with buildEnv

sample code

```nix
{
  # nix profile install .
  description = "A flake for my Nix packages";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "my-packages";
        paths = with pkgs; [
          neovim
          tmux
        ];
      };
    };
}
```
