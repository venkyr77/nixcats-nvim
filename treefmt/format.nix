{pkgs, ...}: {
  projectRootFile = "flake.nix";

  programs = {
    deadnix = {
      enable = true;
      priority = 10;
    };

    statix = {
      enable = true;
      package = import ../nix/packages/statix.nix {inherit pkgs;};
      priority = 20;
    };

    alejandra = {
      enable = true;
      priority = 30;
    };

    stylua = {
      enable = true;
      priority = 40;
    };
  };
}
