# let
#   overlay = self: super: {
#     trebuchet = self.poetry2nix.mkPoetryApplication {
#       projectDir = ./.;
#     };
#   };
#   hostPkgs = import <nixpkgs> { overlays = [ overlay ]; };
#   linuxPkgs = import <nixpkgs> { overlays = [overlay ]; system = "x86_64-linux"; };
#   in 
#   {
#     inherit (hostPkgs) trebuchet;

#     docker = hostPkgs.dockerTools.buildLayeredImage {
#       name = "trebuchet";
#       tag = "latest";
#       contents = [ 
#          linuxPkgs.trebuchet 
#       ];
#       created = "now";
#       config = {
#         Cmd = [ "trebuchet" ];
#         ExposedPorts = {
#           "8000" = {};
#         };
#       };
#     };
#   }

{ pkgs ? import <nixpkgs>{} }:
let 
  trebuchet = pkgs.poetry2nix.mkPoetryApplication {
    projectDir = ./.;
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;
    python = pkgs.python3;
    src = pkgs.lib.cleanSource ./.;
  };
  in 
  {
    docker = pkgs.dockerTools.buildLayeredImage {
      name = "trebuchet";
      tag = "latest";
      contents = [ 
         trebuchet 
      ];
      created = "now";
      config = {
        Cmd = [ "trebuchet" ];
        ExposedPorts = {
          "8000" = {};
        };
      };
    };    
  }