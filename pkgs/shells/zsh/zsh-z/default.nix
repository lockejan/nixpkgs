{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "zsh-z";
  version = "unstable-2023-10-12";

  src = fetchFromGitHub {
    owner = "agkozak";
    repo = pname;
    rev = "afaf2965b41fdc6ca66066e09382726aa0b6aa04";
    sha256 = "sha256-FnGjp/VJLPR6FaODY0GtCwcsTYA4d6D8a6dMmNpXQ+g=";
  };

  strictDeps = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/zsh-z
    cp _zshz zsh-z.plugin.zsh $out/share/zsh-z
  '';

  meta = with lib; {
    description = "Jump quickly to directories that you have visited frequently in the past, or recently";
    homepage = "https://github.com/agkozak/zsh-z";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [ maintainers.evalexpr ];
  };
}
