{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./configuration.nix
    ./environment.nix
  ];
}
