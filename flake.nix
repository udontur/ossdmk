{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    prog_src = {
      flake = false;
      url = "github:udontur/ossdmk";
    };
  };
  outputs = {self, nixpkgs, ...}@inputs: let
    forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
  in {
    packages = forAllSys (system: let
      pkgs = import nixpkgs { inherit system; };
      ossdmk = pkgs.callPackage ./. {
        inherit (inputs) prog_src;
      };
    in {
      default = ossdmk;
    });
  };
}


# {
#   description = "A flake for building Hello World";
#   inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
#   outputs = { 
#     self, nixpkgs 
#   }:
#     let
#       systems = ["x86_64-linux"];
#       pkgs = import nixpkgs { inherit systems; };
#     in {
#       packages = {
#         default = pkgs.stdenv.mkDerivation {
#           name = "ossdmk";
#           pname="ossdmk";
#           version = "1.0.0";
#           src = self;
#           buildPhase = ''
#             g++ ./src/main.cpp -o ossdmk
#           '';
#           installPhase = ''
#             mkdir -p $out/bin
#             install -D ./ossdmk $out/bin/ossdmk
#           '';
#         };
#       };
#     };
# }

# {
#   description = "Manage NetworkManager connections with dmenu/rofi/wofi instead of nm-applet";

#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs";
#   };

#   outputs = {
#     self,
#     nixpkgs,
#   }: let
#     systems = ["x86_64-linux"];
#     forAllSystems = f:
#       nixpkgs.lib.genAttrs systems (system:
#         f {
#           pkgs = import nixpkgs {inherit system;};
#         });
#   in {
#     devShells = forAllSystems ({pkgs}: {
#       default = pkgs.mkShell {
#         packages = builtins.attrValues {
#           inherit
#             (pkgs)
#             glib
#             gobject-introspection
#             networkmanager
#             ;
#           inherit
#             (pkgs.python3Packages)
#             python
#             pygobject3
#             ;
#         };
#       };
#     });
#     packages = forAllSystems ({pkgs}: {
#       default = pkgs.stdenv.mkDerivation {
#         name = "networkmanager_dmenu";
#         pname = "networkmanager_dmenu";
#         dontBuild = true;
#         src = ./.;
#         buildInputs = builtins.attrValues {
#           inherit
#             (pkgs)
#             glib
#             gobject-introspection
#             networkmanager
#             ;
#           inherit
#             (pkgs.python3Packages)
#             python
#             pygobject3
#             wrapPython
#             ;
#         };
#         installPhase = ''
#           mkdir -p $out/bin $out/share/applications $out/share/doc/$pname
#           cp networkmanager_dmenu $out/bin/
#           cp networkmanager_dmenu.desktop $out/share/applications
#           cp README.md $out/share/doc/$pname/
#           cp config.ini.example $out/share/doc/$pname/
#         '';
#         postFixup = let
#           inherit (pkgs.python3Packages) pygobject3;
#         in ''
#            makeWrapperArgs="\
#           --prefix GI_TYPELIB_PATH : $GI_TYPELIB_PATH \
#           --prefix PYTHONPATH : \"$(toPythonPath $out):$(toPythonPath ${pygobject3})\""
#            wrapPythonPrograms
#         '';
#         meta = {
#           description = "Manage NetworkManager connections with dmenu/rofi/wofi instead of nm-applet";
#           homepage = "https://github.com/firecat53/networkmanager-dmenu";
#           license = pkgs.lib.licenses.mit;
#           maintainers = ["firecat53"];
#           platforms = pkgs.lib.platforms.all;
#         };
#       };
#     });
#   };
# }