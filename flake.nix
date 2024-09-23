{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = with pkgs;
            mkShell {
              nativeBuildInputs = [ sbt metals ];
              JAVA_8_HOME = "${jdk8}/lib/openjdk";
              JAVA_17_HOME = "${jdk17}/lib/openjdk";
              JAVA_21_HOME = "${jdk21}/lib/openjdk";
              JAVA_HOME = "${jdk21}/lib/openjdk";
            };
        };
      });

}
