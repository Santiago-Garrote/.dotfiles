{
  fetchzip,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "dseg";
  version = "0.46";

  src = fetchzip {
    url = "https://github.com/keshikan/DSEG/releases/download/v${version}/fonts-DSEG_v046.zip";
    hash = "sha256-5db7ZqOd5d3ZnDU/tXGHC3GEExUoeUes9fWTeDenWsc=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    find . -type f -name '*.ttf' -print0 | while IFS= read -r -d "" font; do
      install -Dm444 "$font" "$out/share/fonts/truetype/$(basename "$font")"
    done

    runHook postInstall
  '';

  meta = {
    description = "Seven-segment and fourteen-segment display fonts";
    homepage = "https://www.keshikan.net/fonts-e.html";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
