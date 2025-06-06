{ 
  pkgs,
  buildPythonPackage,
}:

buildPythonPackage {
  pname = "xrt";
  version = "1.6.1";
  src = pkgs.fetchFromGitHub {
    owner = "kklmn";
    repo = "xrt";
    rev = "43a229b98c49669378e2e2127ba00ac9217de451";
    sha256 = "sha256-BfMfAx/sN3Uf/JxY41DzDce0yAotFeI9o//wINeOVEM=";
  };

  postInstall = ''
    makeWrapper $out/bin/xrtQookStart.py $out/bin/xrtQook --run "chmod -R 777 \$HOME/.xrt"
    makeWrapper ${pkgs.python3.interpreter} $out/bin/xrtBentXtal \
    --add-flags "$out/lib/python3.12/site-packages/xrt/gui/xrtBentXtal.py" \
    --run "chmod -R 777 \$HOME/.xrt"
  '';
}

