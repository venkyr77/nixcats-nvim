{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

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
    extra_pkg_config = {};

    dependencyOverlays = [
      (utils.standardPluginOverlay inputs)
    ];

    categoryDefinitions = _: {
      lspsAndRuntimeDeps = {
        general = [];
      };

      startupPlugins = {
        gitPlugins = [];
        general = [];
      };

      optionalPlugins = {
        gitPlugins = [];
        general = [];
      };

      sharedLibraries = {
        general = [];
      };

      environmentVariables = {};

      extraWrapperArgs = {};

      python3.libraries = {};

      extraLuaPackages = {};
    };

    packageDefinitions = {
      nvim = _: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          aliases = ["vim"];
        };
        categories = {
          general = true;
          gitPlugins = true;
          customPlugins = true;
          test = true;
          example = {
            youCan = "add more than just booleans";
            toThisSet = [
              "and the contents of this categories set"
              "will be accessible to your lua with"
              "nixCats('path.to.value')"
              "see :help nixCats"
            ];
          };
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

      flake = let
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [defaultPackageName];
          inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
        homeModule = utils.mkHomeModules {
          moduleNamespace = [defaultPackageName];
          inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
      in {
        overlays =
          utils.makeOverlays luaPath {
            inherit nixpkgs dependencyOverlays extra_pkg_config;
          }
          categoryDefinitions
          packageDefinitions
          defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      };

      perSystem = {system, ...}: let
        nixCatsBuilder =
          utils.baseBuilder luaPath {
            inherit nixpkgs system dependencyOverlays extra_pkg_config;
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

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [defaultPackage];
            inputsFrom = [];
            shellHook = '''';
          };
        };
      };
    };
}
