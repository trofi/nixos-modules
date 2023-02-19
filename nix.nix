# The problem: nix defaults don't support a few basic features like
# flags or auto-optimize store.
#
# The solution: enable a few reasonable defaults for development or
# daily use.
{ ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    daemonCPUSchedPolicy = "idle";
    extraOptions = ''
      # enable content-addressed store for remotes
      experimental-features = flakes nix-command ca-derivations

      # otheriwse 'nix develop' produces undistinguishable shell prompt
      # TODO: how to sneak in whitespace here?
      bash-prompt-suffix = dev>

      # Ease mass greps over a compressed filesystem
      compress-build-log = false

      keep-outputs = false
      keep-derivations = false
    '';
  };
}
