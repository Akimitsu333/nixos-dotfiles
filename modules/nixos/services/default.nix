{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./clash-meta.nix
    ./openssh.nix
    ./tailscale.nix
  ];
}
