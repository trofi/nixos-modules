# This module pulls in "/include" and points NIX_CFLAGS_COMPILE to it.
# This way ./configure Just Works with enough installed packages.

# The problem: `gcc`/`clang` does not look at NixOS' include path and
# makes installation of devloper packages into the system less useful.
# As a result './configure' does not work as is unless you enter a nix
# shell.
#
# The solution: extend
#     `NIX_CFLAGS_COMPILE_*`
#     `NIX_CFLAGS_LINK_*`
# path variables to contain:
#     /run/current-system/sw/include
#     /run/current-system/sw/lib
{ config, lib, pkgs, ... }:
{
  config = {

    environment.pathsToLink = [
      "/include"
    ];

    environment.variables = {
     "NIX_CFLAGS_COMPILE_${lib.replaceStrings ["-"] ["_"] pkgs.stdenv.hostPlatform.config}" = "-I/run/current-system/sw/include";
     "NIX_CFLAGS_LINK_${lib.replaceStrings ["-"] ["_"] pkgs.stdenv.hostPlatform.config}" = "-L/run/current-system/sw/lib";
    };
  };
}
