{ 
  python,
  buildPythonPackage,
  fetchFromGitHub,
}:

buildPythonPackage {
  pname = "gsas-ii";
  version = "5.4.6";
  format="other";
  
  src = fetchFromGitHub {
    owner = "AdvancedPhotonSource";
    repo = "GSAS-II";
    tag = "v5.4.6";
    sha256 = "sha256-2ivan5S9BMEjJTZmvi223Lvb4BcuFPt/ZDS/H/32xF0=";
  };
  
  buildPhase=''
  echo "BUILD PHASE"
  runHook postBuild
  '';

  postBuild=''
  '';

  installPhase=''
  echo "INSTALL PHASE"
  runHook postInstall
  '';

  postInstall = ''
  '';
}

