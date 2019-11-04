{ stdenv, fetchurl, libX11, libXext, libXt, imake, gccmakedep}:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "xzoom";
  major = "0";
  minor = "3";
  patch = "24";
  version = "${major}.${minor}.${patch}";

  # or fetchFromGitHub(owner,repo,rev) or fetchgit(rev)
  src = fetchurl {
    url = "http://www.ibiblio.org/pub/linux/libs/X/${pname}-${major}.${minor}.tgz";
    sha256 = "0jzl5py4ny4n4i58lxx2hdwq9zphqf7h3m14spl3079y5mlzssxj";
  };
  patches = [
    (fetchurl {
       url = "http://http.debian.net/debian/pool/main/x/xzoom/xzoom_${major}.${minor}-${patch}.diff.gz";
       sha256 = "0zhc06whbvaz987bzzzi2bz6h9jp6rv812qs7b71drivvd820qbh";
    })
  ];

  nativeBuildInputs = [ imake gccmakedep ];
  buildInputs = [ libX11 libXext libXt ];

  makeFlags = [
    "PREFIX=$(out)"
    "BINDIR=$(out)/bin"
    "MANPATH=$(out)/share/man"
  ];
  installTargets = [ "install" "install.man" ];

  meta = {
    inherit version;
    description = "An X11 screen zoom tool";
    license = stdenv.lib.licenses.free ;
    maintainers = [stdenv.lib.maintainers.raskin];
    platforms = stdenv.lib.platforms.linux;
  };
}
