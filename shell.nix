{ pkgs ? import <nixpkgs> {} }:

let 

  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    projectDir = ./.;
    python = pkgs.python3;
    poetrylock = ./poetry.lock;
  };


in pkgs.mkShell {

  buildInputs = [
    pkgs.poetry
    pythonEnv
  ];

}