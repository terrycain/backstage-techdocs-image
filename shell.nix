{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs; [
      git
      gnumake
      hadolint
      trivy
    ];
    hardeningDisable = [ "all" ];
}