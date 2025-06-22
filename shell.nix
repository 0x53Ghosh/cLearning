{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    clang
    gdb
    gnumake
  ];

  shellHook = ''
    export TMPDIR="$PWD/.tmp"
    mkdir -p "$TMPDIR"
    rm -rf "$TMPDIR"/*
  '';
}