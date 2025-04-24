{
  description = "A flake for building Hello World";
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs =
    { self, nixpkgs }:
    {
      defaultPackage.x86_64-linux =
        # Notice the reference to nixpkgs here.
        with import nixpkgs {
          system = "x86_64-linux";
        };
        stdenv.mkDerivation {
          name = "ossdmk";
          src = self;
          buildPhase = ''
            g++ ./src/main.cpp -o ossdmk
          '';
          installPhase = ''
            mkdir -p $out/bin
            install -D ./ossdmk $out/bin/ossdmk
          '';
        };
    };
}

