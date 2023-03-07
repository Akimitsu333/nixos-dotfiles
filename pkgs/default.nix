# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  bilibili = pkgs.callPackage ./bilibili { };
  # linux-xanmod-diy = pkgs.callPackage ./linux-xanmod-diy { };
  maa = pkgs.callPackage ./maa { };
  # example = pkgs.callPackage ./example { };
}
