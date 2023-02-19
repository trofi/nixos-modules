# Problem: when RAM is full (be it tmpfs builds or just programs getting
# out of control) machine quickly grinds to a halt on IO with or without
# swap.
#
# Solution: allocate half the ram for zramswap. That way instead of
# switching from RAM usage to IO usage the system penalizes main RAM
# users by increasing CPU usage for compression/decompression. In such
# a mode there is a chance to survive short RAM spikes without huge
# latency increase. And for out-of-hands programs it's a lot easier to
# notice and kill mispehaving ones.
{ ... }:
{
  zramSwap.enable = true;
  # allow half the RAM and assume 2x compression.
  zramSwap.memoryPercent = 150;
}
