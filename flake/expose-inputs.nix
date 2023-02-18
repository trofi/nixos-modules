# The problem: stale `<nixpkgs>`
# On a flake based system one does not normally need to a maintain
# `nixpkgs` channel anymore. Instead one usually uses inputs.nixpkgs. As
# a result <nixpkgs> variable usually gets stale and does not match
# neither a `flake` `nixpkgs` input, nor `nixpkgs` repository in `flake
# registry`.
#
# The solution: provide `nixpkgs` via `$NIX_PATH` environment variable
# in a way that it switches automatically on `nixos-rebuld switch`.
# To implement the switching at runtime this module provides symlinks
# with stable names to the nix store:
#     /run/current-system/sw/share/nixos-flakes/inputs/${iinput} ->

{ config, lib, pkgs, ... }: {

options = {
    flakes = {
      exposeInputs = lib.mkOption {
        type = lib.types.attrsOf lib.types.path;
        default = {};
        example = lib.literalExpression "{ inherit nixpkgs; }";
        description = lib.mdDoc "Attribute set of inputs to propagate and expose as $NIX_PATH variables.";
      };
      exposeLegacyConfig = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc "Whether to expose 'nixos-config=/etc/nixos/configuration' via $NIX_PATH.";
      };
    };
  };

  config = {
    environment.pathsToLink = [
      "/share/nixos-flakes/inputs"
    ];
    environment.systemPackages = [
      (pkgs.runCommandLocal "expose-flakes-inputs" {} (
        ''
          mkdir -p "$out"/share/nixos-flakes/inputs
        '' + lib.concatLines (lib.mapAttrsFlatten (i: p:
        ''
            ln -s ${p} "$out"/share/nixos-flakes/inputs/${i}
        '') config.flakes.exposeInputs)))
    ];
    nix.nixPath = lib.mapAttrsFlatten
      (i: p: "${i}=/run/current-system/sw/share/nixos-flakes/inputs/${i}")
      config.flakes.exposeInputs
    ++ lib.optional config.flakes.exposeLegacyConfig
      "nixos-config=/etc/nixos/configuration.nix";
  };
}
