{ pkgs, ... }:

# kvit-term (github.com/kvit-s/kvit-term) is a small MPL-2.0 terminal-emulator
# library built directly on Qt Quick (QQuickItem view + libvterm), rather than
# a QWidget-based terminal wrapped for QML. It's not packaged in nixpkgs, and
# unlike a normal app dependency it has to become a *loadable QML plugin*
# (qmldir + shared library) so Quickshell's own QML engine can `import
# KvitTerm` at runtime — Quickshell is a separate, already-built process, so
# it can only ever load a QML module, never link against one at compile time.
pkgs.stdenv.mkDerivation {
  pname = "kvit-term";
  version = "unstable-2026-08-26";

  src = pkgs.fetchFromGitHub {
    owner = "kvit-s";
    repo = "kvit-term";
    rev = "c08cbacebd9f9940d7419724b65c821fa639ab77";
    hash = "sha256-8ixnpp9SY5pXND+e9E1V/4qZcxiFx0RotWlkb6utPrs=";
  };

  # kvit-term's own qt_add_qml_module call passes NO_PLUGIN because it's
  # designed to be linked statically into a consumer's own compiled Qt app.
  # This drops NO_PLUGIN to get the ordinary loadable-plugin build
  # qt_add_qml_module already supports for exactly this case — upstream just
  # doesn't opt into it for their own (different) intended use.
  postPatch = ''
    sed -i '/NO_PLUGIN/d' src/CMakeLists.txt
    cat >> src/CMakeLists.txt <<'EOF'

install(DIRECTORY ''${CMAKE_BINARY_DIR}/qmlmodules/KvitTerm DESTINATION qml)

# qt_add_qml_module's auto-generated plugin target sets its own INSTALL_RPATH
# internally (to make an uninstalled build's plugin find its own library by
# absolute build-tree path, e.g. /build/source/build/src) which overrides any
# CMAKE_INSTALL_RPATH passed on the command line. That absolute path is
# exactly the kind of build-sandbox leak Nix refuses to ship, so it's
# overridden again here, after the target exists, with one relative to where
# the plugin actually installs ($out/qml/KvitTerm, two levels below $out).
if(TARGET kvit-termplugin)
    set_target_properties(kvit-termplugin PROPERTIES
        INSTALL_RPATH "$ORIGIN/../../lib"
        BUILD_WITH_INSTALL_RPATH TRUE
    )
endif()
EOF
  '';

  nativeBuildInputs = [ pkgs.cmake pkgs.ninja ];
  buildInputs = [ pkgs.qt6.qtbase pkgs.qt6.qtdeclarative ];
  dontWrapQtApps = true;

  cmakeFlags = [
    "-DKVITTERM_SHARED_LIBS=ON"
    "-DKVITTERM_BUILD_TESTS=OFF"
    "-DKVITTERM_BUILD_EXAMPLES=OFF"
  ];

  # Verified working end-to-end: this exact derivation's `qml` output loads
  # and constructs kvitterm::TerminalView from a standalone
  # QQmlApplicationEngine, matching how Quickshell will consume it (see
  # $out/qml/KvitTerm for the qmldir + plugin + typeinfo Quickshell imports).
}
