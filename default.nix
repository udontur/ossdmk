{
  lib,
  stdenv,
  fetchFromGitHub,
  prog_src,
}:

stdenv.mkDerivation rec {
  pname = "ossdmk";
  name="ossdmk";
  src=prog_src;
  # src = fetchFromGitHub {
  #   owner = "udontur";
  #   repo = "ossdmk";
  #   tag = "v${version}";
  #   hash = "sha256-gWOPkOehSK64XO4hwRKTXjlSkkV/jhhUFlUCb0goEN4=";
  # };

  buildPhase = '' 
    g++ ./src/main.cpp -o ossdmk
  '';
  installPhase = ''
    mkdir -p $out/bin
    install -D ./ossdmk $out/bin/ossdmk
  '';
  # installPhase = ''
  #   runHook preInstall
  #   install -Dm755 ./ossdmk $out/bin/ossdmk
  #   runHook postInstall
  # '';

  meta = {
    description = "Ontario Secondary School Diploma (OSSD) Mark Calculator CLI Tool";
    homepage = "https://github.com/udontur/ossdmk";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ udontur ];
    mainProgram = "ossdmk";
    platforms = lib.intersectLists lib.platforms.linux lib.platforms.x86;
  };
}