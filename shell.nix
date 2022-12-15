with import <nixpkgs> { };

let
  pythonPackages = python39Packages;
in pkgs.mkShell rec {
  venvDir = "./.venv";
  name = "python-env";
  buildInputs = [
    cmake
    boost
    simgrid
    # debugging tools
    gdb
    valgrind
    # C tools
    autoconf
    autoreconfHook
    automake
    libtool
    pkg-config
    zlib

    jansson # required for logging to json
  ];
  shellHook = ''
    # fixes libstdc++ issues and libgl.so issues
    LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/
    
    # fixes xcb issues :
    QT_PLUGIN_PATH=${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}
    SOURCE_DATE_EPOCH=$(date +%s)
    QT_XCB_GL_INTEGRATION="none"
  '';
}