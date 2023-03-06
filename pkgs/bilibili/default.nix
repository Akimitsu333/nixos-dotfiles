{
  stdenv,
  electron,
  fetchurl,
  lib,
  makeWrapper,
  ...
} @ args:
stdenv.mkDerivation rec {
  pname = "bilibili";
  version = "1.9.1-3";
  src = fetchurl {
    url = "https://github.com/msojocs/bilibili-linux/releases/download/v1.9.1-3/io.github.msojocs.bilibili_1.9.1-3_amd64.deb";
    sha256 = "sha256-++Rj/WEC2KximQtmzGJroV6vafswYCQFfwpjOq+A/BM=";
  };

  unpackPhase = ''
    ar x ${src}
    tar xf data.tar.xz
  '';

  buildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp -r usr/share $out/share
    sed -i "s|Exec=.*|Exec=$out/bin/bilibili|" $out/share/applications/*.desktop
    cp -r opt/apps/io.github.msojocs.bilibili/files/bin/app $out/opt
    makeWrapper ${electron}/bin/electron $out/bin/bilibili \
      --argv0 "bilibili" \
      --add-flags "$out/opt/app.asar"
  '';

  meta = with lib; {
    description = "Bilibili desktop client";
    homepage = "https://app.bilibili.com/";
    license = licenses.unfreeRedistributable;
  };
}