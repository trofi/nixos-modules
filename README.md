# nixos-modules
Various modules I use on NixOS.

Note: it's not a drop-in replacement for for `/etc/nixos`. You are
expected to import these explicitly. Usually as:

```nix
# somewhere in /etc/nixos/configuration.nix
{ config, pkgs, ... }:
{
  imports = [
    ./aclocal.nix
    ./include.nix
    # ...
  ];
}
```

# Usage

Some modules might be generic enough to be used by others. Some are
probably too tailored to the way I use systems. You might want to copy
a module if you plan to use it for real.
