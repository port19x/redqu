{
  description = "A clj-nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, clj-nix }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cljpkgs = clj-nix.packages."${system}";
      in
      {
        packages = {

          clj = cljpkgs.mkCljBin {
            projectSrc = ./.;
	    name = "me.lafuente/cljdemo";
            main-ns = "redqu.core";
            jdkRunner = pkgs.jdk17_headless;
          };

          graal = cljpkgs.mkGraalBin {
            cljDrv = self.packages."${system}".clj;
          };

        };
      });
}
