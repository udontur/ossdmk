{
  description = "Ontario Secondary School Diploma (OSSD) Mark Calculator CLI Tool";
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux.default =
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
