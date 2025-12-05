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
    treefmt-nix,
    ...
  } @ inputs: let
    categoryDefinitions = {pkgs, ...}: let
      npins = import ./npins;

      mkPlugin = pname: pin:
        pin
        // {
          inherit pname;
          version = pin.revision;
        };
    in {
      lspsAndRuntimeDeps = {
        general = [
          pkgs.alejandra
          pkgs.nixd
          pkgs.stylua
        ];
      };

      optionalPlugins = {
        general =
          npins
          |> pkgs.lib.filterAttrs (pname: _: pname != "lz.n")
          |> pkgs.lib.mapAttrsToList mkPlugin;
      };

      startupPlugins = {
        general = [
          pkgs.vimPlugins.nvim-treesitter.withAllGrammars
          (mkPlugin "lz.n" npins."lz.n")
        ];
      };
    };

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
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        treefmtFormatEval = treefmt-nix.lib.evalModule pkgs ./treefmt/format.nix;
        treefmtLintEval = treefmt-nix.lib.evalModule pkgs ./treefmt/lint.nix;
      in {
        checks = {
          formatting = treefmtFormatEval.config.build.check inputs.self;
          linting = treefmtLintEval.config.build.check inputs.self;
        };

        formatter = treefmtFormatEval.config.build.wrapper;

        packages = nixCats.utils.mkAllWithDefault (
          nixCats.utils.baseBuilder
          ./.
          {inherit pkgs system;}
          categoryDefinitions
          packageDefinitions
          "nvim"
        );
      };

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
