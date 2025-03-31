{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
  inputs.mkflake.url = "github:jonascarpay/mkflake";

  outputs = { nixpkgs, mkflake, self }: mkflake.lib.mkflake {
    topLevel.templates.default.path = ./.;
    perSystem = system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        myPython = pkgs.python3.withPackages (p: [
          # Packages go here
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            myPython
            pkgs.ruff
            pkgs.pyright
            pkgs.black
          ];
        };
      };
  };
}
