let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    git
    gh
    kind
    kubectl
    bat
    go-task
    timoni
    kuttl
    kubernetes-helm
    upbound
    yq-go
  ];
}
