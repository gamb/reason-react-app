{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  bs-platform-src = fetchFromGitHub {
    owner = "turboMaCk";
    repo = "bs-platform.nix";
    rev = "c20e8dc8703ad7975c99d76b5779d31c86078d98";
    sha256 = "06wii6487crawi7ngbls59snvygqhh29jz5f9q106m3vp9jzy7h9";
  };
  bs-platform = import "${bs-platform-src}/bs-platform.nix" {
    inherit stdenv fetchFromGitHub ninja nodejs python35;
  };
in mkShell {
  buildInputs = [
    bs-platform
    nodejs
    ocamlPackages_4_02.merlin
    ocaml_4_02
    nodePackages.parcel-bundler
  ];
  shellHook = ''
    mkdir -p ./node_modules/.bin
    ln -sfn ${bs-platform} ./node_modules/bs-platform
    ln -sfn ${bs-platform}/bin/* ./node_modules/.bin
  '';
}
