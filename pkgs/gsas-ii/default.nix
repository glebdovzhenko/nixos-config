{ pkgs
, python
, buildPythonPackage
, fetchFromGitHub
, openssl_3_4
, gcc14
, gfortran14
, pkg-config
, stdenv
, numpy_1
, scipy
, meson
, cython
, pybind11
, ninja
, wxpython
, matplotlib
, pyopengl
, pillow
, h5py
, hdf5plugin
, requests
, gitpython
, sphinx
, sphinx-rtd-theme
}:

buildPythonPackage {
  pname = "gsas-ii";
  version = "5.4.6";
  format = "other";

  src = fetchFromGitHub {
    owner = "AdvancedPhotonSource";
    repo = "GSAS-II";
    tag = "v5.4.6";
    sha256 = "sha256-2ivan5S9BMEjJTZmvi223Lvb4BcuFPt/ZDS/H/32xF0=";
  };

  dependencies = [
    numpy_1
    scipy
    meson
    cython
    pybind11
    ninja
    wxpython
    matplotlib
    pyopengl
    pillow
    h5py
    hdf5plugin
    requests
    gitpython
    sphinx
    sphinx-rtd-theme
  ];

  propagatedBuildInputs = [
    openssl_3_4
    gcc14
    gfortran14
    pkg-config
    stdenv
    python
  ];

  buildPhase = ''
    runHook preBuild
    echo "BUILD PHASE"
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    echo "INSTALL PHASE"
    mkdir -p $out/bin
    makeWrapper ${python}/bin/python $out/bin/gsas-ii \
      --add-flags "$src/GSASII/G2.py" \

    runHook postInstall
  '';

}

