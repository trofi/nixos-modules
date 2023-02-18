# The problem: aclocal does not look at NixOS' aclocal path and makes
# installation of devloper packages into the system less useful.
# As a result 'autoreconf' does not work as is unless you enter a nix
# shell.
#
# The solution: extend `ACLOCAL_PATH` path variable to contain
#     /run/current-system/sw/share/aclocal
{ config, ... }:
{
  config = {

    environment.pathsToLink = [
      "/share/aclocal"
    ];

    environment.profileRelativeSessionVariables = {
      ACLOCAL_PATH = [ "/share/aclocal" ];
    };

  };
}
