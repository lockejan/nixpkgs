{ fetchFromGitHub, fetchpatch, ncurses, lib, stdenv,
  updateAutotoolsGnuConfigScriptsHook }:

stdenv.mkDerivation rec {
  pname = "freesweep";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "rwestlund";
    repo = "freesweep";
    rev = "v${version}";
    hash = "sha256-iuu81yHbNrjdPsimBrPK58PJ0d8i3ySM7rFUG/d8NJM";
  };

  nativeBuildInputs = [ updateAutotoolsGnuConfigScriptsHook ];
  buildInputs = [ ncurses ];

  preConfigure = ''
    configureFlags="$configureFlags --with-prefsdir=$out/share"
  '';

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall
    install -D -m 0555 freesweep $out/bin/freesweep
    install -D -m 0444 sweeprc $out/share/sweeprc
    install -D -m 0444 freesweep.6 $out/share/man/man6/freesweep.6
    runHook postInstall
  '';

  meta = with lib; {
    description = "A console minesweeper-style game written in C for Unix-like systems";
    homepage = "https://github.com/rwestlund/freesweep";
    license = licenses.gpl2;
    maintainers = with maintainers; [ kierdavis ];
    platforms = platforms.unix;
  };
}
