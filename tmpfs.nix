# Problem: nix-daemon builds derivations in /tmp.
#
# Solution: mount /tmp as tmpfs and allocate most RAM for it.
{ ... }:
{
  boot.tmpOnTmpfs = true;
  boot.tmpOnTmpfsSize = "75%";
}
