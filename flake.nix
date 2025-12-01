{
  description = "Neovim configuration with nixCats";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
  };

  outputs = {
    flake-parts,
    nixpkgs,
    nixCats,
    treefmt-nix,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = ./.;

    categoryDefinitions = _: {
      lspsAndRuntimeDeps = {
        general = [];
      };

      startupPlugins = {
        general = [];
      };

      optionalPlugins = {
        general = [];
      };
    };

    packageDefinitions = {
      nvim = _: {
        settings = {
          wrapRc = true;
          aliases = ["vim"];
        };
        categories = {
          general = true;
        };
      };
    };

    defaultPackageName = "nvim";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {system, ...}: let
        nixCatsBuilder =
          utils.baseBuilder luaPath {
            inherit nixpkgs system;
            dependencyOverlays = [(utils.standardPluginOverlay inputs)];
          }
          categoryDefinitions
          packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs {inherit system;};
        treefmtFormatEval = treefmt-nix.lib.evalModule pkgs ./treefmt/format.nix;
        treefmtLintEval = treefmt-nix.lib.evalModule pkgs ./treefmt/lint.nix;
      in {
        packages = utils.mkAllWithDefault defaultPackage;

        checks = {
          formatting = treefmtFormatEval.config.build.check inputs.self;
          linting = treefmtLintEval.config.build.check inputs.self;
        };

        formatter = treefmtFormatEval.config.build.wrapper;
      };
    };
}
