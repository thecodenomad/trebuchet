let
  overlay = self: super: {
    trebuchet = self.poetry2nix.mkPoetryApplication {
      projectDir = ./.;
    };
  };
  hostPkgs = import <nixpkgs> { overlays = [ overlay ]; };
  linuxPkgs = import <nixpkgs> { overlays = [overlay ]; system = "x86_64-linux"; };
  in 
  {
    inherit (hostPkgs) trebuchet;

    docker = hostPkgs.dockerTools.buildLayeredImage {
      name = "trebuchet";
      tag = "latest";
      contents = [ 
         linuxPkgs.trebuchet 
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