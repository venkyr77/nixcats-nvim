{
  description = "Neovim configuration with nixCats";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
  };

  outputs = {
    flake-parts,
    nixCats,
    nixpkgs,
    treefmt-nix,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = ./.;

    categoryDefinitions = {pkgs, ...}: {
      lspsAndRuntimeDeps = {
        general = [];
      };

      optionalPlugins = {
        general = [];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
        ];
      };
    };

    defaultPackageName = "nvim";

    packageDefinitions = {
      nvim = _: {
        categories = {
          general = true;
        };
        settings = {
          aliases = ["vim"];
          wrapRc = true;
        };
      };
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      perSystem = {system, ...}: let
        defaultPackage = nixCatsBuilder defaultPackageName;
        nixCatsBuilder =
          utils.baseBuilder luaPath {
            dependencyOverlays = [(utils.standardPluginOverlay inputs)];
            inherit nixpkgs system;
          }
          categoryDefinitions
          packageDefinitions;
        pkgs = import nixpkgs {inherit system;};
        treefmtFormatEval = treefmt-nix.lib.evalModule pkgs ./treefmt/format.nix;
        treefmtLintEval = treefmt-nix.lib.evalModule pkgs ./treefmt/lint.nix;
      in {
        checks = {
          formatting = treefmtFormatEval.config.build.check inputs.self;
          linting = treefmtLintEval.config.build.check inputs.self;
        };

        formatter = treefmtFormatEval.config.build.wrapper;

        packages = utils.mkAllWithDefault defaultPackage;
      };

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
