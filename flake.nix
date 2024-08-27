{
  description = "A simple HTTP server that receives contact form messages and forwards them via e-mail";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
          ];
        };
        packages = rec {
          contact-api = pkgs.callPackage ./pkgs/contact-api.nix { };
          dockerImage = pkgs.callPackage ./pkgs/docker-image.nix { inherit contact-api; };
          default = contact-api;
        };
        apps.load-image = let
          runner = pkgs.writeScript "load-docker-image" ''
            ${pkgs.podman}/bin/podman load -i ${packages.dockerImage}
          '';
        in {
          type = "app";
          program = "${runner}";
        };
      }
    );
}
